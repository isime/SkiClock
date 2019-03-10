//
//  NextNewSkierController.swift
//  SkiClock
//
//  Created by Ian Sime on 3/9/19.
//  Copyright © 2019 Ian Sime. All rights reserved.
//

import UIKit

class NextNewSkierController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var SkierTypes: [String] = [String]()

    @IBOutlet weak var NextSkierType: UIPickerView!
    @IBOutlet weak var NextFName: UITextField!
    @IBOutlet weak var NextLName: UITextField!
    @IBOutlet weak var NextWeight: UITextField!
    @IBOutlet weak var NextHeightFT: UITextField!
    @IBOutlet weak var NextHeightIN: UITextField!
    @IBOutlet weak var NextAge: UITextField!
    
    @IBAction func sendNextSkier(_ sender: Any) {
        let FName: String = NextFName.text ?? "No First Name"
        let LName: String = NextLName.text ?? "No Last Name"
        let Weight: String = NextWeight.text ?? "0"
        let HeightFT: String = NextHeightFT.text ?? "0"
        let HeightIN: String = NextHeightIN.text ?? "0"
        let Age: String = NextAge.text ?? "0"
        let SkierType = SkierTypes[NextSkierType.selectedRow(inComponent: 0)]
        
        
        let skierJson: [String: String] = ["fname": FName, "lname": LName, "weight": Weight, "heightft": HeightFT, "heightin": HeightIN, "age": Age, "skiertype": SkierType]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: skierJson)
        
        let url = URL(string: "http://127.0.0.1:5000/new_skier")
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
        self.NextSkierType.delegate = self
        self.NextSkierType.dataSource = self
        
        SkierTypes = ["1: Beginner", "2: Intermediate", "3: Expert"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return SkierTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return SkierTypes[row]
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
