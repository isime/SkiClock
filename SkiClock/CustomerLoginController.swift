//
//  CustomerLoginController.swift
//  SkiClock
//
//  Created by Ian Sime on 4/15/19.
//  Copyright © 2019 Ian Sime. All rights reserved.
//

import UIKit

struct CustomerLoginInfo: Decodable {
    let customer_id: Int?
    let first_name: String?
}

class CustomerLoginController: UIViewController {
    var customer_id: String = "1"
    var customers = [CustomerLoginInfo]()
    var ids = [Int]()
    var first_name = [String]()
    var realID = false
    var next_first_name: String = "None"
    let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

    @IBOutlet weak var customerIDEntery: UITextField!
    @IBOutlet weak var ErrorLabel: UILabel!
    
    @IBAction func LoginButtonPress(_ sender: Any) {
        getCustomerID()
        if realID{
            ErrorLabel.textColor = UIColor.white
        self.performSegue(withIdentifier: "customerLoginToCustomerHome", sender: self)
        }
        else{
            ErrorLabel.textColor = UIColor.red
        }
    }
    
    func setError(){
        ErrorLabel.text = "Invalid Customer ID"
        ErrorLabel.textColor = UIColor.white
    }
    
    func getCustomerID(){
        realID = false
        customer_id = customerIDEntery.text ?? "1"
        checkCustomerID()
    }
    
    func checkCustomerID(){
//        let check_id = Int(customer_id) ?? 0
//        if ids.contains(check_id){
//        realID = true
//        }
        if Set(customer_id).isSubset(of: nums){
            realID = true
        }
        if customer_id == ""{
            realID = false
        }
    }
    
//    func getFirstName(){
//        let index = self.ids.index(of: Int(customer_id) ?? 0)
//        next_first_name = self.first_name[index!]
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "customerLoginToCustomerHome"{
            let nextScene = segue.destination as? CustomerHomeController
            nextScene!.customer_id = Int(customer_id)
        }
    }
    
    func getCustomerInfo(){
        let customerUrl = "http://10.0.0.7:5000/customers"
        
        guard let url = URL(string: customerUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                self.customers = try JSONDecoder().decode([CustomerLoginInfo].self, from: data)
                for info in self.customers{
                    self.ids.append(info.customer_id ?? 0)
                    self.first_name.append(info.first_name ?? "N/A")
                }
                    
                    DispatchQueue.main.async {
                    
                    }
            } catch let jsonErr {
                
            }
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getCustomerInfo()
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
