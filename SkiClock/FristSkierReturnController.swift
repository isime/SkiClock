//
//  FristSkierReturnController.swift
//  SkiClock
//
//  Created by Ian Sime on 4/3/19.
//  Copyright © 2019 Ian Sime. All rights reserved.
//

import UIKit

struct SkierReturnInfo: Decodable {
    let skier_first_name: String?
    let skier_last_name: String?
    let skier_id: Int?
    let customer_first_name: String?
    let customer_last_name: String?
    let customer_id: Int?
    let ski_id: Int?
    let ski_manufacture: String?
    let ski_model: String?
    let length: Int?
    let boot_id: Int?
    let boot_manufacture: String?
    let boot_model: String?
    let boot_size: Float?
    let sole_length: Int?
    let helmet_id: Int?
    let Color: String?
    let helmet_size: String?
    let rental_id: Int?
}

class FristSkierReturnController: UIViewController {
    
    @IBOutlet weak var customerFNameLabel: UILabel!
    @IBOutlet weak var customerLName: UILabel!
    @IBOutlet weak var skierFNameLabel: UILabel!
    @IBOutlet weak var skierLNameLabel: UILabel!
    @IBOutlet weak var rentalNumberLable: UILabel!
    @IBOutlet weak var skiIId: UILabel!
    @IBOutlet weak var skiLength: UILabel!
    @IBOutlet weak var skiModel: UILabel!
    @IBOutlet weak var skiManufacturer: UILabel!
    @IBOutlet weak var bootID: UILabel!
    @IBOutlet weak var bootSize: UILabel!
    @IBOutlet weak var bootModel: UILabel!
    @IBOutlet weak var bootManufacturer: UILabel!
    @IBOutlet weak var helmetID: UILabel!
    @IBOutlet weak var helmetSize: UILabel!
    @IBOutlet weak var helmetColor: UILabel!
    
    var assetID: String!
//    var returnData = SkierReturnInfo
    var skier_f_name: String!
    var skier_l_name: String!
    var skier_id: Int!
    var customer_f_name: String!
    var customer_l_name: String!
    var customer_id: Int!
    var ski_id: Int!
    var ski_manufacture: String!
    var ski_model: String!
    var ski_length: Int!
    var boot_id: Int!
    var boot_manufacture: String!
    var boot_model: String!
    var boot_size: Float!
    var boot_sole_length: Int!
    var helmet_id: Int!
    var helmet_size: String!
    var helmet_color: String!
    var rental_id: Int!
    
    func getRenturnInfo(){
        let rentalsUrl = "http://127.0.0.1:5000/get_return/" + String(assetID)
        guard let url = URL(string: rentalsUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                let returnData = try JSONDecoder().decode(SkierReturnInfo.self, from: data)
                    print(returnData)
                
                    self.skier_f_name = returnData.skier_first_name
                    self.skier_l_name = returnData.skier_last_name
                    self.skier_id = returnData.skier_id ?? 0
                    self.customer_f_name = returnData.customer_first_name
                    self.customer_id = returnData.customer_id
                    self.ski_id = returnData.ski_id
                self.ski_manufacture = returnData.ski_manufacture
                    self.ski_model = returnData.ski_model
                    self.ski_length = returnData.length
                    self.boot_id = returnData.boot_id
                    self.boot_manufacture = returnData.boot_manufacture
                    self.boot_model = returnData.boot_model
                    self.boot_size = returnData.boot_size
                    self.boot_sole_length = returnData.sole_length
                    self.helmet_id = returnData.helmet_id
                    self.helmet_size = returnData.helmet_size
                    self.helmet_color = returnData.Color
                    self.rental_id = returnData.rental_id ?? 0
                
                    DispatchQueue.main.async {
                       self.initialText()
                    }
                
                //                print(self.id)
                //                print("BREAK HERE")
                //                print(self.skiers)
            } catch let jsonErr {
                
            }
            }.resume()
    }
    
    func initialText(){
        customerFNameLabel.text = customer_f_name
        customerLName.text = customer_l_name
        skierFNameLabel.text = skier_f_name
        skierLNameLabel.text = skier_l_name
        rentalNumberLable.text = String(rental_id)
        skiIId.text = String(ski_id)
        skiLength.text = String(ski_length)
        skiModel.text = ski_model
        skiManufacturer.text = ski_manufacture
        bootID.text = String(boot_id)
        bootSize.text = String(boot_size)
        bootModel.text = boot_model
        bootManufacturer.text = boot_manufacture
        helmetID.text = String(helmet_id)
        helmetSize.text = helmet_size
        helmetColor.text = helmet_color
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "firstSkierReturnToReturnSkierList"{
            let nextScene = segue.destination as? ReturnSkierListController
            nextScene!.rental_id = rental_id
            nextScene!.customer_id = customer_id
            nextScene!.customer_f_name = customer_f_name
            nextScene!.customer_l_name = customer_l_name
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getRenturnInfo()
//        initialText()

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
