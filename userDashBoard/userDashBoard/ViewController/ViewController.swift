//
//  ViewController.swift
//  userDashBoard
//
//  Created by Pawan on 16/01/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userNameTextLabel: UILabel!
    @IBOutlet weak var userPhoneTextLabel: UILabel!
    @IBOutlet weak var userEmailTextLabel: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userAboutLabel: UILabel!
    @IBOutlet weak var editDataButton: UIBarButtonItem!
    var userName = "Pawan Soni"
    var userPhone = "9999241526"
    var userEmail = "pawan.soni@virtubox.io"
    var userAbout = "hi i am an ios dev. "
    override func viewDidLoad() {
        super.viewDidLoad()
      
        userNameTextLabel.text = userName
        userPhoneTextLabel.text = userPhone
        userEmailTextLabel.text = userEmail
        userAboutLabel.text = userAbout
        // Do any additional setup after loading the view.
    
    }



    @IBAction func editUserData(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "EditUserViewController") as! EditUserViewController
//        VC.userNameTextField.placeholder = userName
//        VC.userPhoneTextField.placeholder = userPhone
//        VC.userEmailTextField.placeholder = userEmail
//        VC.userAboutTextField.placeholder = userAbout

        self.navigationController?.pushViewController(VC, animated: true)
        
    }
}

