//
//  CustomerNewSkierFormController.swift
//  SkiClock
//
//  Created by Ian Sime on 4/15/19.
//  Copyright © 2019 Ian Sime. All rights reserved.
//

import UIKit

class CustomerNewSkierFormController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var customer_id: Int!
    var SkierTypes: [String] = [String]()

    @IBOutlet weak var FNameBox: UITextField!
    @IBOutlet weak var LNameBox: UITextField!
    @IBOutlet weak var WeightBox: UITextField!
    @IBOutlet weak var HeightFTBox: UITextField!
    @IBOutlet weak var HeightINBox: UITextField!
    @IBOutlet weak var SkierTypePicker: UIPickerView!
    @IBOutlet weak var AgeBox: UITextField!
    
    @IBAction func ToCustomerHomeButtonPress(_ sender: Any) {
        sendCustomerSkier()
    }
    @IBAction func ToSkierListButtonPress(_ sender: Any) {
        sendCustomerSkier()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CustomerNewSkierToCustomerHome"{
            let nextScene = segue.destination as? CustomerHomeController
            nextScene!.customer_id = self.customer_id
        }
        if segue.identifier == "CustomerNewSkierToSkierList"{
            let nextScene = segue.destination as? CustomerSkierListController
            nextScene!.customer_id = self.customer_id
        }
    }
    
    func sendCustomerSkier(){
        let first_name = FNameBox.text ?? "No First Name"
        let last_name = LNameBox.text ?? "No Last Name"
        let weight = WeightBox.text ?? "0"
        let height_ft = HeightFTBox.text ?? "0"
        let height_in = HeightINBox.text ?? "0"
        let age = AgeBox.text ?? "0"
        let skier_type = SkierTypes[SkierTypePicker.selectedRow(inComponent: 0)]
        
        let skierJson: [String: String] = ["fname": first_name, "lname": last_name, "weight": weight, "heightft": height_ft, "heightin": height_in, "age": age, "skiertype": skier_type, "customer_id": String(customer_id)]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: skierJson)
        
        let url = URL(string: "http://10.0.0.7:5000/customer_new_skier")
        var request = URLRequest(url: url!)
        request.httpMethod = "Post"
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in guard let data = data, error == nil else {print(error?.localizedDescription ?? "No Data"); return }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        task.resume()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return SkierTypes.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent compoonent: Int) -> String? {
        return SkierTypes[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SkierTypePicker.delegate = self
        self.SkierTypePicker.dataSource = self
        self.SkierTypes = ["1: Beginner", "2: Intermediate", "3: Expert"]
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
