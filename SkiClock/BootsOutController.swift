//
//  BootsOutController.swift
//  SkiClock
//
//  Created by Ian Sime on 3/17/19.
//  Copyright © 2019 Ian Sime. All rights reserved.
//

import UIKit

class BootsOutController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var boots = [Boot]()
    var id = [Int]()
    var sole_length = [Int]()
    var size = [Float]()
    var manufacturer = [String]()
    var model = [String]()

    @IBOutlet weak var BootsOutTable: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bootsOutCell = tableView.dequeueReusableCell(withIdentifier: "bootsOutCell"/*Identifier*/, for: indexPath as IndexPath)
        
        let cellText = String(self.size[indexPath.row]) + " | " + self.manufacturer[indexPath.row] + " | " + self.model[indexPath.row] + " | " +  String(self.sole_length[indexPath.row]) + " | " + String(self.id[indexPath.row])
        
        bootsOutCell.textLabel?.text = cellText
        bootsOutCell.textLabel?.textAlignment = .center
        
        return bootsOutCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boots.count
    }
    
    func getEquipment(){
        let equipmentUrl = "http://10.0.0.7:5000/currently_out_boots"
        guard let url = URL(string: equipmentUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                self.boots = try JSONDecoder().decode([Boot].self, from: data)
                //                print(skis)
                for info in self.boots {
                    self.id.append(info.boot_id ?? 0)
                    self.sole_length.append(info.sole_length ?? 0)
                    self.size.append(info.size ?? 0)
                    self.manufacturer.append(info.manufacturer ?? "N/A")
                    self.model.append(info.model ?? "N/A")
                    
                    DispatchQueue.main.async {
                        self.BootsOutTable.reloadData()
                    }
                    
                }
                
                //                print(self.boots)
            } catch let jsonErr {
                
            }
            }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getEquipment()
        
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
