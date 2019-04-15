//
//  CustomerLoginController.swift
//  SkiClock
//
//  Created by Ian Sime on 4/15/19.
//  Copyright © 2019 Ian Sime. All rights reserved.
//

import UIKit

class CustomerLoginController: UIViewController {
    var customer_id: String = "0"

    @IBOutlet weak var customerIDEntery: UITextField!
    
    @IBAction func LoginButtonPress(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CustomerLoginToCustomerHome"{
            let nextScene = segue.destination as? CustomerHomeController
            self.customer_id = customerIDEntery.text ?? "0"
            nextScene!.customer_id = Int(self.customer_id)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
