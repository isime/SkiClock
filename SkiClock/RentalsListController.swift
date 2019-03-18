//
//  RentalsListController.swift
//  SkiClock
//
//  Created by Ian Sime on 3/17/19.
//  Copyright © 2019 Ian Sime. All rights reserved.
//

import UIKit

struct Rental: Decodable {
    let last_name:  String?
    let first_name: String?
    let rental_id: Int?
    let customer_id: Int?
}

class RentalsListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var rentals = [Rental]()
    var id = [Int]()
    var last_name = [String]()
    var first_name = [String]()
    var cus_id = [Int]()

    @IBOutlet weak var RentalsTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rentals.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rentalCell = tableView.dequeueReusableCell(withIdentifier: "rentalCell", for: indexPath)
        
        let cellText =  self.last_name[indexPath.row] + ", " + self.first_name[indexPath.row] + " | " + String(self.id[indexPath.row])
        
        rentalCell.textLabel?.text = cellText
        rentalCell.textLabel?.textAlignment = .center
        return rentalCell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "TodaysRentalsToSkier", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TodaysRentalsToSkier"{
        let nextScene = segue.destination as? SkierListController
        let indexPath = self.RentalsTable.indexPathForSelectedRow
            let rental_id = id[indexPath!.row]
            let customer_id = cus_id[indexPath!.row]
            nextScene!.customer_id = customer_id
            nextScene!.rental_id = rental_id
        }
    }
    
    
    
    func getRentals(){
        let rentalsUrl = "http://127.0.0.1:5000/todays_rentals"
        guard let url = URL(string: rentalsUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                self.rentals = try JSONDecoder().decode([Rental].self, from: data)
                //                print(skis)
                for info in self.rentals {
                    self.id.append(info.rental_id ?? 0)
                    self.cus_id.append(info.customer_id ?? 0)
                    self.last_name.append(info.last_name ?? "N/A")
                    self.first_name.append(info.first_name ?? "N/A")
                    
                    DispatchQueue.main.async {
                        self.RentalsTable.reloadData()
                    }
                    
                }
                //                print(self.id)
                //                print("BREAK HERE")
//                                print(self.rentals)
            } catch let jsonErr {
                
            }
            }.resume()
}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRentals()

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
