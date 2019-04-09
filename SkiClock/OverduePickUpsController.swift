//
//  OverduePickUpsController.swift
//  SkiClock
//
//  Created by Ian Sime on 4/9/19.
//  Copyright © 2019 Ian Sime. All rights reserved.
//

import UIKit

class OverduePickUpsController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var rentals = [Rental]()
    var rental_id = [Int]()
    var last_name = [String]()
    var first_name = [String]()
    var customer_id = [Int]()
    
    @IBOutlet weak var OverdueRentalTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rentals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let overdueRentalCell = tableView.dequeueReusableCell(withIdentifier: "overdueRentalCell", for: indexPath)
        
        let cellText = self.last_name[indexPath.row] + ", " + self.first_name[indexPath.row] + " | " + String(self.rental_id[indexPath.row])
        
        overdueRentalCell.textLabel?.text = cellText
        overdueRentalCell.textLabel?.textAlignment = .center
        return overdueRentalCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "OverduePickUpsToSkiers", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OverduePickUpsToSkiers"{
            let nextScene = segue.destination as? SkierListController
            let indexPath = self.OverdueRentalTable.indexPathForSelectedRow
            nextScene!.rental_id = self.rental_id[indexPath!.row]
            nextScene!.customer_id = self.customer_id[indexPath!.row]
        }
    }
    
    func getOverdueRentals(){
        let overdueRentalUrl = "http://127.0.0.1:5000/overdue_rentals"
        guard let url = URL(string: overdueRentalUrl) else { return }
        
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
                        self.OverdueRentalTable.reloadData()
                    }
                }
            } catch let jsonErr {
                
            }
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getOverdueRentals()

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
