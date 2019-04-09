//
//  ReturnSkierFormController.swift
//  SkiClock
//
//  Created by Ian Sime on 4/9/19.
//  Copyright © 2019 Ian Sime. All rights reserved.
//

import UIKit

class ReturnSkierFormController: UIViewController {

    var skier_id: Int!
    var skier_f_name: String!
    var skier_l_name: String!
    var customer_f_name: String!
    var customer_l_name: String!
    var customer_id: Int!
    var rental_id: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(skier_id)
        print(rental_id)
        print(customer_l_name)

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
