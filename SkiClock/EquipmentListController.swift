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

class EquipmentListController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let equipmentUrl = "http://127.0.0.1:5000/in_stock"
        guard let url = URL(string: equipmentUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                let equipment = try
                JSONDecoder().decode(Equipment.self, from: data)
                print(equipment)
            } catch let jsonErr {
                
            }
        }.resume()
        
//        URLSession.shared.dataTask(with: url) { (data, response, err) in
//            guard let data = data else { return }
//
//            do {
//                let equipment = try JSONDecoder().decode(Equipment.self, from: data)
//                print(equipment)
//            }
//    }.resume()
    
    
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
