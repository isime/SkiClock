//
//  SkierEquipmentFormContoller.swift
//  SkiClock
//
//  Created by Ian Sime on 3/18/19.
//  Copyright © 2019 Ian Sime. All rights reserved.
//

import UIKit

struct SettingsInfo: Decodable {
    let skier_code: String?
    let din: String?
}

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
    var skier_code: String = "N/A"
    var din: String = "0.0"
    var sole_length: String = "0"
    var skiID: String = "NULL"
    var bootID: String = "NULL"
    var helmetID: String = "NULL"
    
    let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    var realSoleLength: Bool = false
    var realSkiID: Bool = false
    var realBootID: Bool = false
    var realHelmetID: Bool = false
    var realDin: Bool = false

    @IBOutlet weak var fNameLabel: UILabel!
    @IBOutlet weak var lNameLabel: UILabel!
    @IBOutlet weak var feetLabel: UILabel!
    @IBOutlet weak var inchesLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var skierTypeLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var skierCodeLabel: UILabel!
    @IBOutlet weak var dinLabel: UILabel!
    
    @IBOutlet weak var ErrorLabel: UILabel!
    
    
    
    @IBOutlet weak var soleLengthBox: UITextField!
    @IBOutlet weak var bootIDBox: UITextField!
    @IBOutlet weak var skiIDBox: UITextField!
    @IBOutlet weak var helmetIDBox: UITextField!
    
    @IBAction func SubmitButtonPress(_ sender: Any) {
        getIDs()
        if realSkiID && realBootID && realHelmetID && realDin{
            sendSkierEquipment()
            self.performSegue(withIdentifier: "skierEquipmentToRentalAgreement", sender: self)
        }
        else if realDin == false && realSkiID && realBootID && realHelmetID{
            setDinError()
        }
        else if realDin{
            setIDError()
        }
        else {
            setAllError()
        }
    }
    
    @IBAction func getInfoButtonPress(_ sender: Any) {
        sole_length = soleLengthBox.text ?? "0"
        checkSoleLength()
        if realSoleLength{
        getSkierCodeAndDin()
        realDin = true
        }
    }
    
    func getIDs(){
        skiID = skiIDBox.text ?? "NULL"
        if skiID == ""{
            skiID = "NULL"
        }
        bootID = bootIDBox.text ?? "NULL"
        if bootID == ""{
            bootID = "NULL"
        }
        helmetID = helmetIDBox.text ?? "NULL"
        if helmetID == ""{
            helmetID = "NULL"
        }
        checkIDs()
    }
    
    func setReals(){
        realHelmetID = false
        realBootID = false
        realSkiID = false
    }
    
    func setAllError(){
        ErrorLabel.text = "Invalid ID's and Din"
        ErrorLabel.textColor = UIColor.red
    }
    
    func setDinError(){
        ErrorLabel.text = "Din Needed"
        ErrorLabel.textColor = UIColor.red
    }
    
    func checkIDs(){
        setReals()
        checkSkiID()
        checkBootID()
        checkHelmetID()
        if skiID == "NULL" && bootID == "NULL"{
            realSkiID = false
            realBootID = false
        }
    }
    
    func setIDError(){
        if realSkiID == false && realHelmetID == true && realBootID == true{
            ErrorLabel.text = "Invalid Ski ID"
        }
        else if realSkiID == true && realBootID == false && realHelmetID == true{
            ErrorLabel.text = "Invalid Boot ID"
        }
        else if realSkiID == true && realBootID == true && realHelmetID == false{
            ErrorLabel.text = "Invalid Helmet ID"
        }
        else if skiID == "NULL" && bootID == "NULL"{
            ErrorLabel.text = "Either Ski or Boot Required"
            ErrorLabel.textColor = UIColor.red
        }
        else {
            ErrorLabel.text = "Invalid ID's"
        }
        ErrorLabel.textColor = UIColor.red
        }
    
    func checkSkiID(){
        if skiID == "NULL"{
            realSkiID = true
        }
        if Set(skiID).isSubset(of: nums){
            if skiID.count == 6{
                realSkiID = true
            }
        }
    }
    
    func checkBootID(){
        if bootID == "NULL"{
            realBootID = true
        }
        if Set(bootID).isSubset(of: nums){
            if bootID.count == 6{
                realBootID = true
            }
        }
    }
    
    func checkHelmetID(){
        if helmetID == "NULL"{
            realHelmetID = true
        }
        if Set(helmetID).isSubset(of: nums){
            if helmetID.count == 6{
                realHelmetID = true
            }
        }
    }
    
    func checkSoleLength(){
        if Set(sole_length).isSubset(of: nums){
            if sole_length.count == 3{
            realSoleLength = true
            ErrorLabel.textColor = UIColor.white
        }
            else{
                setInvalidSole()
            }
        }
        else {
            setInvalidSole()
        }
    }
    
    func setInvalidSole(){
        realSoleLength = false
        ErrorLabel.text = "Invalid Sole Length"
        ErrorLabel.textColor = UIColor.red
    }
    
    
    func initialText() {
        fNameLabel.text = first_name
        lNameLabel.text = last_name
        weightLabel.text = String(weight)
        feetLabel.text = String(height/12)
        inchesLabel.text = String(height%12)
        ageLabel.text = String(age)
        skierTypeLabel.text = String(skier_type)
    }
    
    func setKeyboard(){
        soleLengthBox.keyboardType = .numberPad
        skiIDBox.keyboardType = .numberPad
        bootIDBox.keyboardType = .numberPad
        helmetIDBox.keyboardType = .numberPad
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "skierEquipmentToRentalAgreement"{
            let nextScene = segue.destination as? RentalAgreementController
            nextScene!.skier_id = self.skier_id
            nextScene!.rental_id = self.rental_id
        }
    }
    
    func setInfo() {
        skierCodeLabel.text = skier_code
        dinLabel.text = din
    }
   
    func sendSkierEquipment() {
        
        let equipmentJSON: [String: String] =
            ["skier_id": String(skier_id), "ski_id": skiID, "boot_id": bootID, "sole_length": sole_length, "rental_id": String(rental_id), "helmet_id": helmetID, "skier_code": skier_code, "din": din ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: equipmentJSON)
        
        let url = URL(string: "http://10.0.0.7:5000/add_skier_equipment")
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
    
    func getSkierCodeAndDin() {
        let dinUrl = "http://10.0.0.7:5000/get_skier_code_din/" + String(height) + "/" + String(weight) + "/" + String(age) + "/" + String(skier_type) + "/" + String(sole_length)
        guard let url = URL(string: dinUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                let info = try JSONDecoder().decode(SettingsInfo.self, from: data)
                
                self.skier_code = info.skier_code ?? "N/A"
                self.din = info.din ?? "0.0"
                
                DispatchQueue.main.async {
                    self.setInfo()
                }
            } catch let jsonErr { }
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialText()
        setKeyboard()

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
