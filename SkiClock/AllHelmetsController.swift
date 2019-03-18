//
//  AllHelmetsController.swift
//  SkiClock
//
//  Created by Ian Sime on 3/17/19.
//  Copyright © 2019 Ian Sime. All rights reserved.
//

import UIKit

class AllHelmetsController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var helmets = [Helmet]()
    var id = [Int]()
    var size = [String]()
    var color = [String]()

    @IBOutlet weak var AllHelmetsTable: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let allHelmetsCell = tableView.dequeueReusableCell(withIdentifier: "allHelmetsCell"/*Identifier*/, for: indexPath as IndexPath)
        
        let cellText = self.size[indexPath.row] + " | " + self.color[indexPath.row] + " | " +   String(self.id[indexPath.row])
        
        allHelmetsCell.textLabel?.text = cellText
        allHelmetsCell.textLabel?.textAlignment = .center
        
        return allHelmetsCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return helmets.count
    }
    
    func getEquipment(){
        let equipmentUrl = "http://127.0.0.1:5000/all_helmets"
        guard let url = URL(string: equipmentUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                self.helmets = try JSONDecoder().decode([Helmet].self, from: data)
                //                print(skis)
                for info in self.helmets {
                    self.id.append(info.helmet_id ?? 0)
                    self.size.append(info.size ?? "N/A")
                    self.color.append(info.color ?? "N/A")
                    
                    DispatchQueue.main.async {
                        self.AllHelmetsTable.reloadData()
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
