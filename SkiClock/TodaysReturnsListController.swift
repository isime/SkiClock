//
//  TodaysReturnsListController.swift
//  SkiClock
//
//  Created by Ian Sime on 4/14/19.
//  Copyright © 2019 Ian Sime. All rights reserved.
//

import UIKit

class TodaysReturnsListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var rentals = [Rental]()
    var rental_id = [Int]()
    var last_name = [String]()
    var first_name = [String]()
    var customer_id = [Int]()

    @IBOutlet weak var TodaysReturnsTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rentals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todaysReturnCell = tableView.dequeueReusableCell(withIdentifier: "todaysReturnCell", for: indexPath)
        
        let cellText = self.last_name[indexPath.row] + ", " + self.first_name[indexPath.row] + " | " + String(self.rental_id[indexPath.row])
        todaysReturnCell.textLabel?.text = cellText
        todaysReturnCell.textLabel?.textAlignment = .center
        return todaysReturnCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "TodaysReturnsToSkierList", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TodaysReturnsToSkierList" {
            let nextScene = segue.destination as? ReturnSkierListController
            let indexPath = self.TodaysReturnsTable.indexPathForSelectedRow
            nextScene!.rental_id = self.rental_id[indexPath!.row]
            nextScene!.customer_id = self.customer_id[indexPath!.row]
            nextScene!.customer_f_name = self.first_name[indexPath!.row]
            nextScene!.customer_l_name = self.last_name[indexPath!.row]
        }
    }
    
    func getTodaysReturns(){
        let todaysReturnsUrl = "http://10.0.0.7:5000/todays_returns"
        guard let url = URL(string: todaysReturnsUrl) else { return }
        
        URLSession.shared.dataTask(with: url) {
            (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                self.rentals = try JSONDecoder().decode([Rental].self, from: data)
                
                for info in self.rentals {
                    self.rental_id.append(info.rental_id ?? 0)
                    self.customer_id.append(info.customer_id ?? 0)
                    self.last_name.append(info.last_name ?? "N/A")
                    self.first_name.append(info.first_name ?? "N/A")
                    
                    DispatchQueue.main.async {
                        self.TodaysReturnsTable.reloadData()
                    }
                }
            } catch let jsonErr {
                
            }
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTodaysReturns()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
