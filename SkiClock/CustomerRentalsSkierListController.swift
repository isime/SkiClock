//
//  CustomerRentalsSkierListController.swift
//  SkiClock
//
//  Created by Ian Sime on 4/15/19.
//  Copyright © 2019 Ian Sime. All rights reserved.
//

import UIKit

class CustomerRentalsSkierListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var customer_id: Int!
    var rental_id: Int!
    
    var skiers = [CustomerSkierInfo]()
    var skier_id = [Int]()
    var first_name = [String]()
    var last_name = [String]()
    var height = [Int]()
    var weight = [Int]()
    var age = [Int]()
    var skier_type = [Int]()

    @IBOutlet weak var CustomerRentalSkiersTable: UITableView!
    @IBAction func ToHomeButtonPress(_ sender: Any) {
    }
    @IBAction func ToCustomerRentalListButtonPress(_ sender: Any) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skiers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customerRentalSkierCell = tableView.dequeueReusableCell(withIdentifier: "customerRentalSkierCell", for: indexPath)
        
        let cellText = self.first_name[indexPath.row] + " " + self.last_name[indexPath.row]
        
        customerRentalSkierCell.textLabel?.text = cellText
        customerRentalSkierCell.textLabel?.textAlignment = .center
        
        return customerRentalSkierCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "CustomerRentalSkierListToCustomerRentalSkierInfo", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CustomeRentalSkierListToCustomerHome"{
            let nextScene = segue.destination as? CustomerHomeController
            nextScene!.customer_id = self.customer_id
        }
        if segue.identifier == "CustomerRentalSkierListToCustomerRentalList" {
            let nextScene = segue.destination as? CustomerRentalsListController
            nextScene!.customer_id = self.customer_id
        }
        if segue.identifier == "CustomerRentalSkierListToCustomerRentalSkierInfo" {
            let nextScene = segue.destination as? CustomerRentalSkierInfoController
            let indexPath = self.CustomerRentalSkiersTable.indexPathForSelectedRow
            
            nextScene!.skier_id = self.skier_id[indexPath!.row]
            nextScene!.customer_id = self.customer_id
            nextScene!.skier_f_name = first_name[indexPath!.row]
            nextScene!.skier_l_name = self.last_name[indexPath!.row]
            nextScene!.height = self.height[indexPath!.row]
            nextScene!.weight = self.weight[indexPath!.row]
            nextScene!.age = self.age[indexPath!.row]
            nextScene!.skier_type = self.skier_type[indexPath!.row]
            nextScene!.rental_id = self.rental_id
        }
    }
    
    func getCustomerSkier(){
        let customerSkiersUrl = "http://146.86.199.28:5000/customer_rental_skiers/" + String(rental_id)
        
        guard let url = URL(string: customerSkiersUrl) else { return }
        
        URLSession.shared.dataTask(with: url){
            (data, response, err) in
            guard let data = data else { return }
        
        do {
            self.skiers = try JSONDecoder().decode([CustomerSkierInfo].self, from: data)
            
            for info in self.skiers {
                self.skier_id.append(info.skier_id ?? 0)
                self.first_name.append(info.first_name ?? "N/A")
                self.last_name.append(info.last_name ?? "N/A")
                self.height.append(info.height ?? 0)
                self.weight.append(info.weight ?? 0)
                self.age.append(info.age ?? 0)
                self.skier_type.append(info.skier_type ?? 0)
                
                DispatchQueue.main.async {
                    self.CustomerRentalSkiersTable.reloadData()
                }
            }
        } catch let jsonErr {
            
        }
    }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCustomerSkier()

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
