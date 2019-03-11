//
//  NewCustomerController.swift
//  SkiClock
//
//  Created by Ian Sime on 3/6/19.
//  Copyright © 2019 Ian Sime. All rights reserved.
//

import UIKit

class NewCustomerController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var StatePicker: UIPickerView!
    
    var StatePickerData: [String] = [String]()
    
    @IBOutlet weak var CusFname: UITextField!
    @IBOutlet weak var CusLName: UITextField!
    @IBOutlet weak var StreetAddress: UITextField!
    @IBOutlet weak var ZipCode: UITextField!
    @IBOutlet weak var CityBox: UITextField!
    @IBOutlet weak var CusPhon: UITextField!
    @IBOutlet weak var CusEmail: UITextField!
    @IBOutlet weak var CusSignature: UITextField!
    
    
    @IBAction func SubmitCusInfo(_ sender: Any) {
        let FName: String = CusFname.text ?? "No First Name"
        let LName: String = CusLName.text ?? "No Last Name"
        let Address: String = StreetAddress.text ?? "No Address"
        let Zip: String = ZipCode.text ?? "0"
        let City: String = CityBox.text ?? "No City"
        let Phone: String = CusPhon.text ?? "0"
        let Email: String = CusEmail.text ?? "no@no.com"
        let statePicked = StatePickerData[StatePicker.selectedRow(inComponent: 0)]
        let Signature = CusSignature.text ?? "No Signature"
    
        
        let cusJson: [String: String] = ["fname": FName, "lname": LName, "address": Address, "state": statePicked, "zip": Zip, "city": City, "phone": Phone, "email": Email, "signature": Signature]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: cusJson)
        
        let url = URL(string: "http://127.0.0.1:5000/new_customer")
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

        // Do any additional setup after loading the view.
        
        self.StatePicker.delegate = self
        self.StatePicker.dataSource = self
        
        StatePickerData = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DC", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return StatePickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return StatePickerData[row]
    }
    
    

}
