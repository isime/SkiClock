//
//  TomorrowsPickUpsController.swift
//  SkiClock
//
//  Created by Ian Sime on 4/9/19.
//  Copyright © 2019 Ian Sime. All rights reserved.
//

import UIKit

class TomorrowsPickUpsController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var rentals = [Rental]()
    var rental_id = [Int]()
    var first_name = [String]()
    var last_name = [String]()
    var customer_id = [Int]()

    @IBOutlet weak var TomorrowsPickUpsTabel: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return rentals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tomorrowsPickUpCell = tableView.dequeueReusableCell(withIdentifier: "tomorrowsPickUpCell", for: indexPath)
        
        let cellText = self.last_name[indexPath.row] + ", " + self.first_name[indexPath.row] + " | " + String(self.rental_id[indexPath.row])
        
        tomorrowsPickUpCell.textLabel?.text = cellText
        tomorrowsPickUpCell.textLabel?.textAlignment = .center
        return tomorrowsPickUpCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "TomorrowsPickUpsToSkiers", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TomorrowsPickUpsToSkiers"{
            let nextScene = segue.destination as? SkierListController
            let indexPath = self.TomorrowsPickUpsTabel.indexPathForSelectedRow
            nextScene!.customer_id = customer_id[indexPath!.row]
            nextScene!.rental_id = rental_id[indexPath!.row]
        }
    }
    
    func getTomorrowsPickUps(){
        let tomorrowsPickUpsUrl = "http://127.0.0.1:5000/tomorrows_rentals"
        guard let url = URL(string: tomorrowsPickUpsUrl) else { return }
        
        URLSession.shared.dataTask(with: url) {
            (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                self.rentals = try JSONDecoder().decode([Rental].self, from: data)
                
                for info in self.rentals {
                    self.rental_id.append(info.rental_id ?? 0)
                    self.customer_id.append(info.customer_id ?? 0)
                    self.first_name.append(info.first_name ?? "N/A")
                    self.last_name.append(info.last_name ?? "N/A")
                    
                    DispatchQueue.main.async {
                        self.TomorrowsPickUpsTabel.reloadData()
                    }
                }
            } catch let jsonErr {
                
            }
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTomorrowsPickUps()

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
