//
//  RentalAgreementController.swift
//  SkiClock
//
//  Created by Ian Sime on 4/15/19.
//  Copyright © 2019 Ian Sime. All rights reserved.
//

import UIKit

class RentalAgreementController: UIViewController {
    var skier_id: Int!
    var rental_id: Int!

    @IBOutlet weak var RentalAgreementLabel1: UILabel!
    @IBOutlet weak var RentalAgreementLabel2: UILabel!
    @IBOutlet weak var RentalAgreementLabel3: UILabel!
    @IBOutlet weak var RentalAgreementLabel4: UILabel!
    @IBOutlet weak var RentalAgreement5: UILabel!
    @IBOutlet weak var RentalAgreement6: UILabel!
    @IBOutlet weak var RentalAgreement7: UILabel!
    @IBOutlet weak var RentalAgreement8: UILabel!
    
    
    func setAgreementLabels(){
        setAgreement1()
        setAgreement2()
        setAgreement3()
        setAgreement4()
        setAgreement5()
        setAgreement6()
        setAgreement7()
        setAgreement8()
    }
    func setAgreement1(){
        RentalAgreementLabel1.text = "1.  I accept for use as is the equipment listed on this form, and accept full financial responsibility for the care of the equipment while it is in my possession. I will be responsible for the replacement at full value of any equipment rented under this form, but not returned to the shop. I agree to return all rental equipment by the agree date."
        RentalAgreementLabel1.numberOfLines = 3
    }
    func setAgreement2(){
        RentalAgreementLabel2.text = "2.  I have made no misrepresentations to Christy Sports, LLC, its employees, owners, parent or sister corporations, subsidiaries, affiliates, agents, officers, directors or any entity under common ownership with Christy Sports, LLC, or any equipment manufacturers or distributors, (collectively “PROVIDERS”) with regard to any information, which that have requested of me related to the rental and/or use of the rented/purchases Equipment."
        RentalAgreementLabel2.numberOfLines = 3
    }
    func setAgreement3(){
        RentalAgreementLabel3.text = "3.  I understand that the snowboard/skiboard/snowshoe (“Equipment”) being furnished had a NON-RELEASE BOOT RETENTION SYSTEM and, as a result of the boot retention system, and the operation of the Equipment, there are inherent risks involved. I understand the Equipment system will NOT RELEASE during use, nor is it specifically designed to release as the result of forces induced during ordinary operation, and is therefore absolutely no guarantee of my safety and this Equipment-boot-binding system does NOT REDUCE THE RISK of injuries to part of my body."
        RentalAgreementLabel3.numberOfLines = 5
    }
    func setAgreement4(){
        RentalAgreementLabel4.text = "4.  I understand that a helmet designed for recreational snow sports use will help reduce the risk of some types of injuries to the user at slower speed. I recognize that serious injury or death can result from both low and high-energy impacts, even when a helmet is worn."
        RentalAgreementLabel4.numberOfLines = 3
    }
    func setAgreement5(){
        RentalAgreement5.text = "5.  I understand and am aware that snowboarding/skiboarding/snowshoeing (“Activity”) is a dangerous Activity. I understand that the sport of snowboarding/skiboarding/snowshoeing can the use of this Equipment involves inherent risks of injury to any and all parts of my body. I recognize that injuries are common and ordinary occurrences of the sport. I hereby agree to freely and expressly assume and accept any and all risks of injury or death to the user of this Equipment while snowboarding/skiboarding/snowshoeing."
        RentalAgreement5.numberOfLines = 4
    }
    func setAgreement6(){
        RentalAgreement6.text = "6.  I AGREE TO RELEASE Christy Sports, LLC, its employees, owners, affiliates, agents, officers, directors, and the manufacturers and distributors of the Equipment (collectively “PROVIDORS”) from all liability for injury, death, property loss and damage which results from the Equipment user’s participation in the sport of skiing/snowboarding/skiboarding use, or is any way related to use of this Equipment, including all liability which results from the NEGLIGENCE of PROVIDERS, or any other person or cause."
        RentalAgreement6.numberOfLines = 4
    }
    func setAgreement7(){
        RentalAgreement7.text = " 7.  I further agree to defend and indemnify PROVIDORS for any loss “attorney’s fees and costs and any legal costs or any other costs,” damage, including any that results from claims or lawsuits for personal injury, death and property loss and damage related in any way to the use of this Equipment."
        RentalAgreement7.numberOfLines = 3
    }
    func setAgreement8(){
        
        RentalAgreement8.text = "8.  ALL INTRUCTIONS ON THE USE OF MY RENTAL EQUIPMENT HAVE BEEN MADE CLEAR TO ME, AND I UNDERSTAND THE FUNCTION OF MY EQUIPMENT."
        RentalAgreement8.numberOfLines = 2
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RentalAgreementToSecondPageRentalAgreement" {
            let nextScene = segue.destination as? SecondRentalAgreementPageController
            nextScene!.skier_id = self.skier_id
            nextScene!.rental_id = self.rental_id
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAgreementLabels()
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
