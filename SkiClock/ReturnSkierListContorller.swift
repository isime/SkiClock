//
//  ReturnSkierListContorller.swift
//  SkiClock
//
//  Created by Ian Sime on 4/8/19.
//  Copyright © 2019 Ian Sime. All rights reserved.
//

import UIKit

struct ReturnSkierInfo: Decodable {
    let firstName: String?
    let lastName: String?
    let skierID: Int?
}

class ReturnSkierListContorller: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var rental_id: Int!
    var customer_id: Int!
    var customer_f_name: String!
    var customer_l_name: String!
    
    var skiers = [ReturnSkierInfo]()
    var skier_id = [Int]()
    var skier_first_name = [String]()
    var skier_last_name = [String]()

    @IBOutlet weak var ReturnSkierTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skiers.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let returnSkierCell = tableView.dequeueReusableCell(withIdentifier: "returnSkierCell", for: indexPath)
        
        let cellText =  self.skier_first_name[indexPath.row] + " " + self.skier_last_name[indexPath.row]
        
        returnSkierCell.textLabel?.text = cellText
        returnSkierCell.textLabel?.textAlignment = .center
        return returnSkierCell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: "SkierListToEquipmentForm", sender: nil)
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "SkierListToEquipmentForm"{
//            let nextScene = segue.destination as? SkierEquipmentFormContoller
//            let indexPath = self.SkiersTable.indexPathForSelectedRow
//
//            let firstName = first_name[indexPath!.row]
//            let lastName = last_name[indexPath!.row]
//            let Age = age[indexPath!.row]
//            let Height = height[indexPath!.row]
//            let Weight = weight[indexPath!.row]
//            let skierType = skier_type[indexPath!.row]
//            let skierID = skier_id[indexPath!.row]
//            let rentalID = rental_id
//            let customerID = customer_id
//
//            nextScene!.first_name = firstName
//            nextScene!.last_name = lastName
//            nextScene!.age = Age
//            nextScene!.height = Height
//            nextScene!.weight = Weight
//            nextScene!.skier_type = skierType
//            nextScene!.skier_id = skierID
//            nextScene!.rental_id = rentalID
//            nextScene!.customer_id = customerID
//        }
//    }
    
    func getSkiers(){
        let rentalsUrl = "http://127.0.0.1:5000/get_return_skiers/" + String(rental_id)
        guard let url = URL(string: rentalsUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                self.skiers = try JSONDecoder().decode([ReturnSkierInfo].self, from: data)
                //                print(skis)
                for info in self.skiers {
                    self.skier_id.append(info.skierID ?? 0)
                    self.skier_last_name.append(info.lastName ?? "N/A")
                    self.skier_first_name.append(info.firstName ?? "N/A")
                    
                    DispatchQueue.main.async {
                        self.ReturnSkierTable.reloadData()
                    }
                    
                }
                //                print(self.id)
                //                print("BREAK HERE")
                //                print(self.skiers)
            } catch let jsonErr {
                
            }
            }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ReturnSkierTable.delegate = self
        ReturnSkierTable.dataSource = self
        print(rental_id)
        getSkiers()

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
