//
//  ReturnsHomeController.swift
//  SkiClock
//
//  Created by Ian Sime on 4/1/19.
//  Copyright © 2019 Ian Sime. All rights reserved.
//

import UIKit

class ReturnsHomeController: UIViewController {

    @IBOutlet weak var assetIDBox: UITextField!
    
    @IBAction func searchForReturn(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "rentalSearchToFirstSkier"{
            let nextScene = segue.destination as? FristSkierReturnController
            let assest_id = assetIDBox.text ?? "0"
            nextScene!.assetID = assest_id
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
