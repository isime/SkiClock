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
    let skis_returned: String?
    let boot_id: Int?
    let boot_manufacture: String?
    let boot_model: String?
    let boot_size: Float?
    let sole_length: Int?
    let boots_returned: String?
    let helmet_id: Int?
    let color: String?
    let helmet_size: String?
    let helmet_returned: String?
    let rental_id: Int?
}

class FristSkierReturnController: UIViewController {
    
    var assetID: String!
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
    var skis_returned: String!
    var skis_already: String = "false"
    var skis_back: String = "false"
    var boot_id: Int!
    var boot_manufacture: String!
    var boot_model: String!
    var boot_size: Float!
    var boot_sole_length: Int!
    var boots_returned: String!
    var boots_already: String = "false"
    var boots_back: String = "false"
    var helmet_id: Int!
    var helmet_size: String!
    var helmet_color: String!
    var helmet_returned: String!
    var helmet_already: String = "false"
    var helmet_back: String = "false"
    var rental_id: Int!
    var helmetTaken: Bool = true
    var bootsTaken: Bool = true
    var skisTaken: Bool = true
    
    @IBOutlet weak var customerFNameLabel: UILabel!
    @IBOutlet weak var customerLNameLabel: UILabel!
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

   
    @IBAction func ToSkierListButtonPress(_ sender: Any) {
        sendSkierReturn()
    }
    @IBAction func ToRentalSearchButtonPress(_ sender: Any) {
        sendSkierReturn()
    }
    @IBAction func ToHomeButtonPress(_ sender: Any) {
        sendSkierReturn()
    }
    @IBAction func ToRentalsHomeButtonPress(_ sender: Any) {
        sendSkierReturn()
    }
    
    
    @IBOutlet weak var SkisButton: UIButton!
    @IBAction func SkisButtonPress(_ sender: Any) {
        if SkisButton.currentTitle == "Skis" {
        skisBack()
            checkAllEquipment()
        }
        else if SkisButton.currentTitle == "Skis Back" {
            skisNotBack()
        }
    }
    
    @IBOutlet weak var BootsButton: UIButton!
    @IBAction func BootsReturnedButton(_ sender: Any) {
        if BootsButton.currentTitle == "Boots"{
            bootsBack()
            checkAllEquipment()
        }
        else if BootsButton.currentTitle == "Boots Back"{
            bootsNotBack()
        }
    }
    
    @IBOutlet weak var HelmetButton: UIButton!
    @IBAction func HelemetButtonPress(_ sender: Any) {
        if HelmetButton.currentTitle == "Helmet"{
            helmetBack()
            checkAllEquipment()
        }
        else if HelmetButton.currentTitle == "Helmet Back"{
            helmetNotBack()
        }
    }
    
    @IBOutlet weak var AllEquipmentButton: UIButton!
    @IBAction func AllEquipmentButtonPress(_ sender: Any) {
        if AllEquipmentButton.currentTitle == "All Equipment"{
            allEquipmentBack()
        }
        else if AllEquipmentButton.currentTitle == "All Equipment Back"{
            allEquipmentNotBack()
            skisNotBack()
            bootsNotBack()
            helmetNotBack()
        }
    }
    
    func checkTaken(){
        if self.ski_id == 0{
            self.skisTaken = false
        }
        if self.boot_id == 0{
            self.bootsTaken = false
        }
        if self.helmet_id == 0{
            self.helmetTaken = false
        }
    }
    
    func setNotTakenButtons(){
        if skisTaken == false{
            setSkisNotTaken()
        }
        if bootsTaken == false{
            setBootsNotTaken()
        }
        if helmetTaken == false{
            setHelmetNotTaken()
        }
    }
    
    func setSkisNotTaken(){
        SkisButton.setTitle("No Skis", for: .normal)
        if skis_already == "false"{
        SkisButton.backgroundColor = UIColor.red
        }
    }
    
    func setBootsNotTaken(){
        BootsButton.setTitle("No Boots", for: .normal)
        if boots_already == "false"{
        BootsButton.backgroundColor = UIColor.red
        }
    }
    
    func setHelmetNotTaken(){
        HelmetButton.setTitle("No Helmet", for: .normal)
        if helmet_already == "false"{
        HelmetButton.backgroundColor = UIColor.red
        }
    }
    
    func allEquipmentNotBack(){
        if skis_already == "false" || boots_already == "false" || helmet_already == "false"{
        AllEquipmentButton.setTitle("All Equipment", for: .normal)
        AllEquipmentButton.backgroundColor = UIColor.black
        }
    }
    func allEquipmentBack(){
        AllEquipmentButton.setTitle("All Equipment Back", for: .normal)
        AllEquipmentButton.backgroundColor = UIColor.blue
        skisBack()
        bootsBack()
        helmetBack()
    }
    
    func skisBack(){
        if skisTaken == true{
        SkisButton.setTitle("Skis Back", for: .normal)
        }
        SkisButton.backgroundColor = UIColor.blue
        skis_back = "true"
    }
    func skisNotBack(){
        if skisTaken == true && skis_already == "false"{
        SkisButton.setTitle("Skis", for: .normal)
        SkisButton.backgroundColor = UIColor.black
            skis_back = "false"
            allEquipmentNotBack()
        }
    }
    
    func bootsBack(){
        if bootsTaken == true{
        BootsButton.setTitle("Boots Back", for: .normal)
        }
        BootsButton.backgroundColor = UIColor.blue
        boots_back = "true"
    }
    func bootsNotBack(){
        if bootsTaken == true && boots_already == "false"{
        BootsButton.setTitle("Boots", for: .normal)
        BootsButton.backgroundColor = UIColor.black
            boots_back = "false"
            allEquipmentNotBack()
        }
    }
    
    func helmetBack(){
        if helmetTaken == true{
        HelmetButton.setTitle("Helmet Back", for: .normal)
        }
        HelmetButton.backgroundColor = UIColor.blue
        helmet_back = "true"
    }
    func helmetNotBack(){
        if helmetTaken == true && helmet_already == "false"{
        HelmetButton.setTitle("Helmet", for: .normal)
        HelmetButton.backgroundColor = UIColor.black
            helmet_back = "false"
            allEquipmentNotBack()
        }
    }
    
    func checkAllEquipment(){
        if skisTaken == true && bootsTaken == true && helmetTaken == true{
        if SkisButton.currentTitle == "Skis Back"{
            if BootsButton.currentTitle == "Boots Back"{
                if HelmetButton.currentTitle == "Helmet Back"{
                    allEquipmentBack()
                }
            }
        }
    }
        if skisTaken == false && bootsTaken == true && helmetTaken == true{
            if BootsButton.currentTitle == "Boots Back"{
                if HelmetButton.currentTitle == "Helmet Back"{
                    allEquipmentBack()
                }
            }
        }
        if skisTaken == true && bootsTaken == true && helmetTaken == false{
            if SkisButton.currentTitle == "Skis Back"{
                if BootsButton.currentTitle == "Boots Back"{
                    allEquipmentBack()
                }
            }
        }
        if skisTaken == true && bootsTaken == false && helmetTaken == true{
            if SkisButton.currentTitle == "Skis Back"{
                if HelmetButton.currentTitle == "Helmet Back"{
                    allEquipmentBack()
                }
            }
        }
        if skisTaken == true && bootsTaken == false && helmetTaken == false{
            if SkisButton.currentTitle == "Skis Back"{
                allEquipmentBack()
            }
        }
        if skisTaken == false && bootsTaken == true && helmetTaken == false {
            if BootsButton.currentTitle == "Boots Back"{
                allEquipmentBack()
            }
        }
        if skisTaken == false && bootsTaken == false && helmetTaken == true{
            if HelmetButton.currentTitle == "Helmet Back"{
                allEquipmentBack()
            }
        }
    }
    
    func checkAlready(){
        if skis_returned != "00/00/0000"{
            skis_already = "true"
            skis_back = "true"
            skisBack()
        }
        if boots_returned != "00/00/0000"{
            boots_already = "true"
            boots_back = "true"
            bootsBack()
        }
        if helmet_returned != "00/00/0000"{
            helmet_already = "true"
            helmet_back = "true"
            helmetBack()
        }
    }
    
    
    func getRenturnInfo(){
        let rentalsUrl = "http://10.0.0.7:5000/get_return/" + String(assetID)
        guard let url = URL(string: rentalsUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                let returnData = try JSONDecoder().decode(SkierReturnInfo.self, from: data)
                
                    self.skier_f_name = returnData.skier_first_name
                    self.skier_l_name = returnData.skier_last_name
                    self.skier_id = returnData.skier_id ?? 0
                    self.customer_f_name = returnData.customer_first_name
                self.customer_l_name = returnData.customer_last_name
                    self.customer_id = returnData.customer_id
                    self.ski_id = returnData.ski_id
                self.ski_manufacture = returnData.ski_manufacture
                    self.ski_model = returnData.ski_model
                    self.ski_length = returnData.length
                self.skis_returned = returnData.skis_returned
                    self.boot_id = returnData.boot_id
                    self.boot_manufacture = returnData.boot_manufacture
                    self.boot_model = returnData.boot_model
                    self.boot_size = returnData.boot_size
                    self.boot_sole_length = returnData.sole_length
                self.boots_returned = returnData.boots_returned
                    self.helmet_id = returnData.helmet_id
                    self.helmet_size = returnData.helmet_size
                    self.helmet_color = returnData.color
                self.helmet_returned = returnData.helmet_returned
                    self.rental_id = returnData.rental_id ?? 0
                
                    DispatchQueue.main.async {
                       self.initialText()
                        self.checkTaken()
                        self.checkAlready()
                    self.checkAllEquipment()
                    self.setNotTakenButtons()

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
        customerLNameLabel.text = customer_l_name
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
    
    func sendSkierReturn(){
        let returnSkierJson: [String: String] = ["skier_id": String(skier_id), "ski_id": String(ski_id), "skis_back": skis_back, "skis_already": skis_already, "boot_id": String(boot_id), "boots_back": boots_back, "boots_already": boots_already, "helmet_id": String(helmet_id), "helmet_back": helmet_back, "helmet_already": helmet_already, "rental_id": String(rental_id)]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: returnSkierJson)
        
        let url = URL(string: "http://10.0.0.7:5000/return_skier_equipment")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in guard let data = data, error == nil else {print(error?.localizedDescription ?? "No Data"); return }
            let reponseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = reponseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        task.resume()
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
