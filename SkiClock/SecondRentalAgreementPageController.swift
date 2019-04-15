//
//  SecondRentalAgreementPageController.swift
//  SkiClock
//
//  Created by Ian Sime on 4/15/19.
//  Copyright © 2019 Ian Sime. All rights reserved.
//

import UIKit

class SecondRentalAgreementPageController: UIViewController {

    @IBOutlet weak var RentalAgreement9: UILabel!
    @IBOutlet weak var RentalAgreement10: UILabel!
    @IBOutlet weak var TermsLabel: UILabel!
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        setAgreements()

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
