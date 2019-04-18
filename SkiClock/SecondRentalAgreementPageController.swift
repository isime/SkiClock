//
//  SecondRentalAgreementPageController.swift
//  SkiClock
//
//  Created by Ian Sime on 4/15/19.
//  Copyright © 2019 Ian Sime. All rights reserved.
//

import UIKit

class SecondRentalAgreementPageController: UIViewController {
    var skier_id: Int!
    var rental_id: Int!

    @IBOutlet weak var RentalAgreement9: UILabel!
    @IBOutlet weak var RentalAgreement10: UILabel!
    @IBOutlet weak var TermsLabel: UILabel!
    @IBOutlet weak var SignatureBox: UITextField!
    
    @IBAction func SubmtSignatureButtonPress(_ sender: Any) {
        sendSignature()
    }
    
    
    
    func setAgreements(){
        setAgreement9()
        setAgreement10()
        setTermsLabel()
    }
    
    func setAgreement9(){
    RentalAgreement9.text = " 9.  I hereby agree to accept the terms and conditions of this contract. This document constitutes the final and entire agreement between Christ Sports, LLC, and the undersigned."
        
        RentalAgreement9.numberOfLines = 3
    }
    func setAgreement10(){
        RentalAgreement10.text = "10.  In exchange for, and in consideration of Christy Sports, LLC making this Equipment available to me, I CONTRACTUALLY AGREE that any and ALL DISPUTS between myself and Christy Sports, LLC arising from my use of this Equipment OR my participation in the Activity and INCLUDING any claims for personal injury and/or death, will be GOVERNED BY THE LAWS OF THE STATE OF COLORADO OR UTAH and EXCLUSIVE JURISDICTION thereof will be in the state court residing in the county where the alleged tort occurred or federal courts of the state of Colorado or Utah."
        RentalAgreement10.numberOfLines = 5
    }
    func setTermsLabel(){
        TermsLabel.text = "I, THE UNDERSIGNED, HAVE CAREFULLY READ AND UNDERSTAND THE EQUIPEMNT RENTAL AGREEMENT AND RELEASE OF LIABILITY."
        TermsLabel.numberOfLines = 3
        TermsLabel.textColor = UIColor.red
    }
    
    func sendSignature() {
        let signature = SignatureBox.text ?? "N/A"
        let signatureJSON: [String: String] = ["skier_id": String(skier_id), "signature": signature]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: signatureJSON)
        
        let url = URL(string: "http://10.0.0.7:5000/add_skier_signature")
        var request = URLRequest(url: url!)
        request.httpMethod = "Post"
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in guard let data = data, error == nil else {print(error?.localizedDescription ?? "No Data");  return }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
            }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SecondRentalAgreeMentToSkierList"{
            let nextScene = segue.destination as? SkierListController
            nextScene!.rental_id = self.rental_id
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAgreements()
        print(skier_id)

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
