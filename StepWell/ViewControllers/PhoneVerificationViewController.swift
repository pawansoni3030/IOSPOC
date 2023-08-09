//
//  PhoneVerificationViewController.swift
//  StepWell
//
//  Created by Pawan on 16/02/23.
//

import UIKit
import FirebaseAuth

class PhoneVerificationViewController: UIViewController {

    @IBOutlet weak var otpMessageLabel: UILabel!
    @IBOutlet weak var otpTextField: UITextField!
    @IBOutlet weak var VerificationAndCreateUserbutton: UIButton!
    @IBOutlet weak var errorBox: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpEnvironment()
        // Do any additional setup after loading the view.
    }
    func showError(_ message:String){
        errorBox.isHidden = false
    }
    func SetUpEnvironment(){
        errorBox.isHidden = true
       }
    @IBAction func onCLickVerifyOTP(_ sender: Any) {
        let Error = validateData()
        if Error != nil{
            showError(Error!)
            return
        }
        else{ // steps which are pending
            // send verification call from last view controller to optmise time .. creat Account in this VC for Avoiding inproper login
            // verify mail before creating user
            let OTP = otpTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
        }
    }
    func validateData() -> String?{
        if otpTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Enter OTP"
        }
        else {
            return nil
        }
    }
    
}
