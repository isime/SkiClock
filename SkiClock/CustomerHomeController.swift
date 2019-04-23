//
//  CustomerHomeController.swift
//  SkiClock
//
//  Created by Ian Sime on 4/15/19.
//  Copyright © 2019 Ian Sime. All rights reserved.
//

import UIKit

class CustomerHomeController: UIViewController {
    var customer_id: Int!
//    var first_name: String!
    
    @IBOutlet weak var WelcomLabel: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CustomerHomeToSkierList"{
            let nextScene = segue.destination as? CustomerSkierListController
            nextScene!.customer_id = self.customer_id
        }
        if segue.identifier == "CustomerHomeToRentalList"{
            let nextScene = segue.destination as? CustomerRentalsListController
            nextScene!.customer_id = self.customer_id
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        WelcomLabel.text = "Welcome " + first_name
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
