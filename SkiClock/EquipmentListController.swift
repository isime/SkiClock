//
//  EquipmentListController.swift
//  SkiClock
//
//  Created by Ian Sime on 3/7/19.
//  Copyright © 2019 Ian Sime. All rights reserved.
//

import UIKit

struct Equipment: Decodable {
    let skis: [Ski]?
    let boots: [Boot]?
    let helmets: [Helmet]?
}

struct Ski: Decodable {
    let ski_id: Int?
    let length: Int?
    let manufacturer: String?
    let model: String?
}

struct Boot: Decodable {
    let boot_id: Int?
    let manufacturer: String?
    let model: String?
    let size: Float?
    let sole_length: Int?
}

struct Helmet: Decodable {
    let helmet_id: Int?
    let color: String?
    let size: String?
}

class EquipmentListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var skis = [Ski]()
    var id = [Int]()
    var length = [Int]()
    var manufacturer = [String]()
    var model = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skis.count

    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let skiCell = tableView.dequeueReusableCell(withIdentifier: "skiCell", for: indexPath)
        
        let cellText = String(self.length[indexPath.row]) + " | " + self.manufacturer[indexPath.row] + " | " + self.model[indexPath.row] + " | " + String(self.id[indexPath.row])
        
        skiCell.textLabel?.text = cellText
        skiCell.textLabel?.textAlignment = .center
        return skiCell
    }
    
    @IBOutlet weak var skisTable: UITableView!
    
    func getEquipment(){
        let equipmentUrl = "http://10.0.0.7:5000/in_stock_skis"
        guard let url = URL(string: equipmentUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                 self.skis = try JSONDecoder().decode([Ski].self, from: data)
//                print(skis)
                for info in self.skis {
                    self.id.append(info.ski_id ?? 0)
                    self.length.append(info.length ?? 0)
                    self.manufacturer.append(info.manufacturer ?? "N/A")
                    self.model.append(info.model ?? "N/A")
                    
                    DispatchQueue.main.async {
                        self.skisTable.reloadData()
                    }

                }
//                print(self.id)
//                print("BREAK HERE")
//                print(self.skis)
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
