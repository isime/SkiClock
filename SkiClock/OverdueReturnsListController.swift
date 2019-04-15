//
//  OverdueReturnsListController.swift
//  SkiClock
//
//  Created by Ian Sime on 4/14/19.
//  Copyright © 2019 Ian Sime. All rights reserved.
//

import UIKit

class OverdueReturnsListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var rentals = [Rental]()
    var rental_id = [Int]()
    var last_name = [String]()
    var first_name = [String]()
    var customer_id = [Int]()

    @IBOutlet weak var OverdueReturnsTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rentals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let overdueReturnCell = tableView.dequeueReusableCell(withIdentifier: "overdueReturnCell", for: indexPath)
        
        let cellText = self.last_name[indexPath.row] + ", " + self.first_name[indexPath.row] + " | " + String(self.rental_id[indexPath.row])
        overdueReturnCell.textLabel?.text = cellText
        overdueReturnCell.textLabel?.textAlignment = .center
        return overdueReturnCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "OverdueReturnToSkiers", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OverdueReturnToSkiers"{
            let nextScene = segue.destination as? ReturnSkierListController
            let indexPath = self.OverdueReturnsTable.indexPathForSelectedRow
            nextScene!.rental_id = self.rental_id[indexPath!.row]
            nextScene!.customer_id = self.customer_id[indexPath!.row]
            nextScene!.customer_l_name = self.last_name[indexPath!.row]
            nextScene!.customer_f_name = self.first_name[indexPath!.row]
        }
    }
    
    func getOverdueReturns(){
    let overdueReturnsUrl = "http://127.0.0.1:5000/overdue_returns"
        guard let url = URL(string: overdueReturnsUrl) else { return }
        
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
                        self.OverdueReturnsTable.reloadData()
                    }
                }
            } catch let jsonErr {
                
            }
        }.resume()
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getOverdueReturns()

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
