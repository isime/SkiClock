//
//  CustomerRentalSkierInfoController.swift
//  SkiClock
//
//  Created by Ian Sime on 4/15/19.
//  Copyright © 2019 Ian Sime. All rights reserved.
//

import UIKit

class CustomerRentalSkierInfoController: UIViewController {
    
    var rental_id: Int!
    var customer_id: Int!
    var skier_id: Int!
    var skier_f_name: String!
    var skier_l_name: String!
    var height: Int!
    var weight: Int!
    var age: Int!
    var skier_type: Int!
    
    var boot_id: Int!
    var boot_manufacturer: String!
    var boot_model: String!
    var sole_lenght: Int!
    var boot_size: Float!
    var ski_id: Int!
    var ski_manufacturer: String!
    var ski_lenght: Int!
    var ski_model: String!
    
    @IBOutlet weak var FNameLabel: UILabel!
    @IBOutlet weak var LNameLabel: UILabel!
    @IBOutlet weak var WeightLabel: UILabel!
    @IBOutlet weak var HeightFTLabel: UILabel!
    @IBOutlet weak var HeightINLabel: UILabel!
    @IBOutlet weak var AgeLabel: UILabel!
    @IBOutlet weak var SkierTypeLaebl: UILabel!
    @IBOutlet weak var BootIDLabel: UILabel!
    @IBOutlet weak var BootManuLabel: UILabel!
    @IBOutlet weak var BootModelLabel: UILabel!
    @IBOutlet weak var BootSizeLabel: UILabel!
    @IBOutlet weak var SoleLenghtLabel: UILabel!
    @IBOutlet weak var SkiIDLabel: UILabel!
    @IBOutlet weak var SkiManufacturerLabel: UILabel!
    @IBOutlet weak var SkiModelLabel: UILabel!
    @IBOutlet weak var SkiLengthLabel: UILabel!
    @IBAction func ToSkierListButtonPress(_ sender: Any) {
    }
    @IBAction func ToHomeButtonPress(_ sender: Any) {
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CustomerRentalSkierInofToCustomerRentalSkierList"{
            let nextScene = segue.destination as? CustomerRentalsSkierListController
            nextScene!.rental_id = self.rental_id
            nextScene!.customer_id = self.customer_id
        }
        if segue.identifier == "CustomerReturnSkierInfoToCustomerHome"{
            let nextScene = segue.destination as? CustomerHomeController
            nextScene!.customer_id = self.customer_id
        }
    }
    
    func getSkierType(skierType: Int) -> String{
        var skierTypeString: String = "No Skier Type"
        if skierType == 1{
            skierTypeString = "1: Beginner"
        }
        else if skierType == 2{
            skierTypeString = "2: Intermediate"
        }
        else if skierType == 3{
            skierTypeString = "3: Expert"
        }
        return skierTypeString
    }
    
    func initialText(){
        FNameLabel.text = skier_f_name
        LNameLabel.text = skier_l_name
        WeightLabel.text = String(weight)
        HeightFTLabel.text = String(height/12)
        HeightINLabel.text = String(height%12)
        AgeLabel.text = String(age)
        SkierTypeLaebl.text = self.getSkierType(skierType: skier_type)
        BootIDLabel.text = String(boot_id)
        BootManuLabel.text = boot_manufacturer
        BootModelLabel.text = boot_model
        BootSizeLabel.text = String(boot_size)
        SoleLenghtLabel.text = String(sole_lenght)
        SkiIDLabel.text = String(ski_id)
        SkiManufacturerLabel.text = ski_manufacturer
        SkiModelLabel.text = ski_model
        SkiLengthLabel.text = String(ski_lenght)
    }
    
    func getSkierInfo(){
        let skierInfoUrl = "http://146.86.199.28:5000/get_skier_info/" + String(skier_id)
        
        guard let url = URL(string: skierInfoUrl) else { return }
        
        URLSession.shared.dataTask(with: url) {
            (data, response, err) in
            guard let data = data else { return }
            
            do {
                let skierEquipment = try JSONDecoder().decode(SkierEquipmentInfo.self, from: data)
                
                self.ski_id = skierEquipment.ski_id
               self.ski_manufacturer = skierEquipment.ski_manufacture
                self.ski_model = skierEquipment.ski_model
                self.ski_lenght = skierEquipment.length
                self.boot_id = skierEquipment.boot_id
                self.boot_manufacturer = skierEquipment.boot_manufacture
                self.boot_model = skierEquipment.boot_model
                self.boot_size = skierEquipment.boot_size
                self.sole_lenght = skierEquipment.sole_length
                
                DispatchQueue.main.async {
                    self.initialText()
                }
            } catch let jsonErr {
                
            }
            }.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getSkierInfo()

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
