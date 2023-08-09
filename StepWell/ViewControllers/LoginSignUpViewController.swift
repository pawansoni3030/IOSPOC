//
//  LoginSignUpViewController.swift
//  StepWell
//
//  Created by Pawan on 26/01/23.
//

import UIKit
import FirebaseAuth

class LoginSignUpViewController: UIViewController {
    @IBOutlet weak var CheckBoxToShowAndHidePasswordButton: UIButton!
    @IBOutlet weak var UserEmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var ForgetPasswordButton: UIButton!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var CreateAccountButton: UIButton!    
    @IBOutlet weak var TermAndConditionButton: UIButton!
    
    var CheckBoxForPasswordVisibility = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEnvironment()
        // Do any additional setup after loading the view.
    }
    func validatefields() -> String?{
        
        if UserEmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)=="" || PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)=="" {
            return "Enter all Fileds"
        }
            return nil
    }
    func setupEnvironment(){PasswordTextField.isSecureTextEntry = true}
    @IBAction func ShowAndHidePassword(_ sender: Any) {
        if CheckBoxForPasswordVisibility == false{
            CheckBoxForPasswordVisibility = true
            PasswordTextField.isSecureTextEntry = true
             self.CheckBoxToShowAndHidePasswordButton.setImage(UIImage(named: "checkbox_unfill"), for: .normal)
        } else {
            CheckBoxForPasswordVisibility = false
            PasswordTextField.isSecureTextEntry = false
            self.CheckBoxToShowAndHidePasswordButton.setImage(UIImage(named: "checkbox_fill"), for: .normal)
        }
    }
    @IBAction func onClickValidateUserAndLogin(_ sender: Any) {
        let Error = validatefields()
        if Error != nil{ showAlert(alertTitle: "Error", Error!)
            return }
        let EMAIL = UserEmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let PASSWORD = PasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                Auth.auth().signIn(withEmail: EMAIL, password: PASSWORD){(AuthDataResult,Err) in
            if Err != nil {
                let errorMessage = Err?.localizedDescription
                self.showAlert(alertTitle: "Error", errorMessage!)
                return
            }
            // user is Signup Done
            self.performSegue(withIdentifier: "homeViewController", sender: self)
        }
    }
}
