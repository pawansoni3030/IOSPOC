//
//  ContactProfileController.swift
//  PocCombineMajor
//
//  Created by Pawan on 20/01/23.
//

import UIKit

class ContactProfileController: UIViewController{
   
    @IBOutlet weak var ContactName: UILabel!
    
    @IBOutlet weak var ContactProfileDesignation: UILabel!
    
    @IBOutlet weak var ContactEmailId: UILabel!
    
    @IBOutlet weak var ContactPhoneNumber: UILabel!
    @IBOutlet weak var ContactProfileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData() // geting Data from ViewController Storyboard identifier ContactViewController
       }
    func getData(){
//        let VC = self.storyboard?.instantiateViewController(withIdentifier: "ContactViewController") as! DashboardViewController
//        print(DashboardViewController.ContactRowDataIndex)
        var contact = DashboardViewController.selectedContact;
        ContactName.text = contact!.Name
        ContactProfileDesignation.text = contact!.Profile
//        ContactProfileImage.image = VC.contactArray![DassboardViewController.ContactRowDataIndex!].ProfileImage
        ContactPhoneNumber.text = contact!.Phone
        ContactEmailId.text = contact!.Email
        
    }
}
