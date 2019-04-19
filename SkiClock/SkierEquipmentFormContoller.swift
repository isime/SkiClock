//
//  SkierEquipmentFormContoller.swift
//  SkiClock
//
//  Created by Ian Sime on 3/18/19.
//  Copyright © 2019 Ian Sime. All rights reserved.
//

import UIKit

class SkierEquipmentFormContoller: UIViewController {
    
    var first_name: String!
    var last_name: String!
    var age: Int!
    var height: Int!
    var weight: Int!
    var skier_type: Int!
    var skier_id: Int!
    var rental_id: Int!
    var customer_id: Int!
    
//    var upperSkierCodes: [String] = ["A", "B", "C", "D" , "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P"]
//    var lowerSkierCodes: [String] = ["a", "b", "c", "d" , "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p"]
//
//    var realIds: Bool = false
//    var realSkierCode: Bool = false
//    var realDin: Bool = false
//    var realSoleLength: Bool = false

    @IBOutlet weak var fNameLabel: UILabel!
    @IBOutlet weak var lNameLabel: UILabel!
    @IBOutlet weak var feetLabel: UILabel!
    @IBOutlet weak var inchesLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var skierTypeLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var ErrorLabel: UILabel!
    
    
    
    @IBOutlet weak var soleLengthBox: UITextField!
    @IBOutlet weak var bootIDBox: UITextField!
    @IBOutlet weak var skierCodeBox: UITextField!
    @IBOutlet weak var dinBox: UITextField!
    @IBOutlet weak var skiIDBox: UITextField!
    @IBOutlet weak var helmetIDBox: UITextField!
    
    @IBAction func ToRentalAgreementButtonPress(_ sender: Any) {
//        checkDin()
//        checkIDS()
//        checkSkierCode()
//        checkSoleLength()
//        if realSoleLength && realDin && realSkierCode && realIds{
//            sendSkierEquipment()
//        }
//        else {
//            ErrorLabel.textColor = UIColor.red
//        }
        sendSkierEquipment()
    }
    
//    func checkIDS(){
//        let bootInput = bootIDBox.text ?? "0"
//        let skiInput = skiIDBox.text ?? "0"
//        let helmetInput = helmetIDBox.text ?? "0"
//        let bootNum = Int(bootInput)
//        let skiNum = Int(skiInput)
//        let helmetNum = Int(skiInput)
//
//        if (bootInput.count == 6 || bootInput == nil) && (skiInput.count == 6 || skiInput == nil) && (helmetInput.count == 6 || helmetInput == nil){
//        if bootNum != nil && skiNum != nil && helmetNum != nil{
//                print("valid ids")
//            realIds = true
//        }
//        }
//    }
//
//    func checkSkierCode(){
//        let skierCodeInput = bootIDBox.text ?? "0"
//        if upperSkierCodes.contains(skierCodeInput) || lowerSkierCodes.contains(skierCodeInput){
//            realSkierCode = true
//        }
//    }
//
//    func checkDin(){
//        let dinInput = dinBox.text ?? "N/A"
//        let dinFloat = Float(dinInput)
//        if dinFloat != nil{
//            realDin = true
//        }
//    }
//
//    func checkSoleLength(){
//        let soleIput = soleLengthBox.text ?? "N/A"
//        let soleInt = Int(soleIput)
//        if soleInt != nil {
//            realSoleLength = true
//        }
//    }
//
    func initialText() {
        fNameLabel.text = first_name
        lNameLabel.text = last_name
        weightLabel.text = String(weight)
        feetLabel.text = String(height/12)
        inchesLabel.text = String(height%12)
        ageLabel.text = String(age)
        skierTypeLabel.text = String(skier_type)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SkierEquipmentToRentalAgreeMent"{
            let nextScene = segue.destination as? RentalAgreementController
            nextScene!.skier_id = self.skier_id
            nextScene!.rental_id = self.rental_id
        }
    }
    
   
    
    func sendSkierEquipment() {
        let skiID = skiIDBox.text ?? "NULL"
        let bootID = bootIDBox.text ?? "NULL"
        let soleLength = soleLengthBox.text ?? "0"
        let skierCode = skierCodeBox.text ?? "A"
        let din = dinBox.text ?? "0.0"
        let helmet_id = helmetIDBox.text ?? "NULL"
        
        let equipmentJSON: [String: String] =
            ["skier_id": String(skier_id), "ski_id": skiID, "boot_id": bootID, "sole_length": soleLength, "skier_code": skierCode, "din": din, "rental_id": String(rental_id), "helmet_id": helmet_id ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: equipmentJSON)
        
        let url = URL(string: "http://146.86.199.28:5000/add_skier_equipment")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in guard let data = data, error == nil else {print(error?.localizedDescription ?? "No Data"); return }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialText()

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
