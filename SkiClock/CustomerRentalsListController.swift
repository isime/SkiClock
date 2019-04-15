//
//  CustomerRentalsListController.swift
//  SkiClock
//
//  Created by Ian Sime on 4/15/19.
//  Copyright © 2019 Ian Sime. All rights reserved.
//

import UIKit
struct CustomerRental: Decodable {
    let rental_id: Int?
    let date_out: String?
    let due_date: String?
    let date_in: String?
}

class CustomerRentalsListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var customer_id: Int!
    var rentals = [CustomerRental]()
    var rental_id = [Int]()
    var date_out = [String]()
    var due_date = [String]()
    var date_in = [String]()

    @IBOutlet weak var CustomerRentalsTable: UITableView!
    
    @IBAction func ToHomeButtonPress(_ sender: Any) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return rentals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rentalCell = tableView.dequeueReusableCell(withIdentifier: "customerRentalCell", for: indexPath)
        
        let cellText = "Rental Number: " + String(rental_id[indexPath.row]) + " | Pick-Up Date: " + date_out[indexPath.row] + " | Due Date: " + due_date[indexPath.row] + " | Return Date: " + date_in[indexPath.row]
        rentalCell.textLabel?.text = cellText
        rentalCell.textLabel?.textAlignment = .center
        return rentalCell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier ==  "CustomerRentalListToCustomerHome"{
            let nextScene = segue.destination as? CustomerHomeController
            nextScene!.customer_id = self.customer_id
        }
    }
    
    func getCustomerRentals(){
        let rentalsUrl = "http://127.0.0.1:5000/customer_rentals/" + String(customer_id)
        
        guard let url = URL(string: rentalsUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                self.rentals = try JSONDecoder().decode([CustomerRental].self, from: data)
                
                for info in self.rentals {
                    self.rental_id.append(info.rental_id ?? 0)
                    self.date_out.append(info.date_out ?? "00/00/0000/")
                    self.due_date.append(info.due_date ?? "00/00/0000/")
                    self.date_in.append(info.date_in ?? "00/00/0000/")
                    
                    DispatchQueue.main.async {
                        self.CustomerRentalsTable.reloadData()
                    }
                }
            } catch let jsonErr {
                
            }
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCustomerRentals()

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
