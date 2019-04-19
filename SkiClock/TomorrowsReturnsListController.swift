//
//  TomorrowsReturnsListController.swift
//  SkiClock
//
//  Created by Ian Sime on 4/15/19.
//  Copyright © 2019 Ian Sime. All rights reserved.
//

import UIKit

class TomorrowsReturnsListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var rentals = [Rental]()
    var rental_id = [Int]()
    var last_name = [String]()
    var first_name = [String]()
    var customer_id = [Int]()

    @IBOutlet weak var TomorrowsReturnsTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rentals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tomorrowsReturnCell = tableView.dequeueReusableCell(withIdentifier: "tomorrowsReturnCell", for: indexPath)
        
        let cellText = self.last_name[indexPath.row] + ", " + self.first_name[indexPath.row] + " | " + String(self.rental_id[indexPath.row])
        tomorrowsReturnCell.textLabel?.text = cellText
        tomorrowsReturnCell.textLabel?.textAlignment = .center
        return tomorrowsReturnCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "TomorrowsReturnToSkierList", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TomorrowsReturnToSkierList" {
            let nextScene = segue.destination as? ReturnSkierListController
            let indexPath = self.TomorrowsReturnsTable.indexPathForSelectedRow
            nextScene!.rental_id = self.rental_id[indexPath!.row]
            nextScene!.customer_id = self.customer_id[indexPath!.row]
            nextScene!.customer_l_name = self.last_name[indexPath!.row]
            nextScene?.customer_f_name = self.first_name[indexPath!.row]
        }
    }
    
    func getTomorrowsReturns() {
        let tomorrowsReturnsUrl = "http://146.86.199.28:5000/tomorrows_returns"
        guard let url = URL(string: tomorrowsReturnsUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                self.rentals = try JSONDecoder().decode([Rental].self, from: data)
                
                for info in self.rentals {
                    self.rental_id.append(info.rental_id ?? 0)
                    self.customer_id.append(info.customer_id ?? 0)
                    self.last_name.append(info.last_name ?? "N/A")
                    self.first_name.append(info.first_name ?? "N/A")
                    
                    DispatchQueue.main.async {
                        self.TomorrowsReturnsTable.reloadData()
                    }
                }
            } catch let jsonErr {
                
            }
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTomorrowsReturns()

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
