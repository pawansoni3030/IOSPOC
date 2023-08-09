//
//  EditUserViewController.swift
//  userDashBoard
//
//  Created by Pawan on 16/01/23.
//

import UIKit

class EditUserViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var userPhoneTextField: UITextField!
    
    @IBOutlet weak var userEmailTextField: UITextField!
    
    @IBOutlet weak var EditUserProfilePhoto: UIImageView!
    @IBOutlet weak var userAboutTextField: UITextField!
    
    @IBOutlet weak var saveUserDataButton: UIBarButtonItem!
    var editUserName = " "
    var editUserPhoneNumber = " "
    var editUserEmail = " "
    var editUserAboutDiscription = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()
         editUserName = userNameTextField.text!
         editUserPhoneNumber = userPhoneTextField.text!
         editUserEmail = userEmailTextField.text!
         editUserAboutDiscription = userAboutTextField.text!
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") as! ViewController
        VC.userName = userNameTextField.text!
        VC.userPhone = userPhoneTextField.text!
        VC.userEmail = userEmailTextField.text!
        VC.userAbout = userAboutTextField.text!
    }
    @IBAction func saveUserDataOnClick(_ sender: Any) {
        

//        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
}
