//
//  ReturnSkierListController.swift
//  SkiClock
//
//  Created by Ian Sime on 4/9/19.
//  Copyright © 2019 Ian Sime. All rights reserved.
//

import UIKit

struct ReturnSkierInfo: Decodable {
    let first_name: String?
    let last_name: String?
    let skier_id: Int?
}

class ReturnSkierListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var customer_id: Int!
    var customer_f_name: String!
    var customer_l_name: String!
    var rental_id: Int!
    
    var skiers = [ReturnSkierInfo]()
    var skier_id = [Int]()
    var skier_f_name = [String]()
    var skier_l_name = [String]()

    @IBOutlet weak var ReturnSkierTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skiers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let returnSkierCell = tableView.dequeueReusableCell(withIdentifier: "returnSkierCell", for: indexPath)
        
        let cellText = self.skier_f_name[indexPath.row] + " " + self.skier_l_name[indexPath.row]
        
        returnSkierCell.textLabel?.text = cellText
        returnSkierCell.textLabel?.textAlignment = .center
        return returnSkierCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPAth: IndexPath) {
        self.performSegue(withIdentifier: "ReturnSkierListToReturnSkierForm", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ReturnSkierListToReturnSkierForm"{
            let nextScene = segue.destination as? ReturnSkierFormController
            let indexPath = self.ReturnSkierTable.indexPathForSelectedRow
            
            let skier_first_name = skier_f_name[indexPath!.row]
            let skier_last_name = skier_l_name[indexPath!.row]
            let skier_id_number = skier_id[indexPath!.row]
            
            nextScene!.skier_id = skier_id_number
            nextScene!.skier_f_name = skier_first_name
            nextScene!.skier_l_name = skier_last_name
            nextScene!.rental_id = self.rental_id
            nextScene!.customer_f_name = self.customer_f_name
            nextScene!.customer_l_name = self.customer_l_name
            nextScene!.customer_id = self.customer_id
        }
    }
    
    func getRenturnSkiers(){
        let returnSkiersUrl = "http://146.86.199.28:5000/skiers/" + String(rental_id)
        
        guard let url = URL(string: returnSkiersUrl) else { return }
        
        URLSession.shared.dataTask(with: url) {
            (data, response, err) in
            guard let data = data else { return }
            
            do {
                self.skiers = try JSONDecoder().decode([ReturnSkierInfo].self, from: data)
                
                for info in self.skiers {
                    self.skier_id.append(info.skier_id ?? 0)
                    self.skier_f_name.append(info.first_name ?? "N/A")
                    self.skier_l_name.append(info.last_name ?? "N/A")
                    
                    DispatchQueue.main.async {
                        self.ReturnSkierTable.reloadData()
                    }
                }
            } catch let jsonErr {
                
            }
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRenturnSkiers()

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
