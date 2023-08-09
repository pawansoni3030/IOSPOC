//
//  DataStorageViewController.swift
//  PocCombineMajor
//
//  Created by Pawan on 06/02/23.
//

import UIKit

var defaults = UserDefaults.standard


class DataStorageViewController: UIViewController {
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var contactNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var submitDataButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        cachedata()
    }
    
    @IBAction func onClickSubmitAndShowData(_ sender: Any) {
        defaults.setValue(fullNameTextField.text ?? "", forKey:"fullname")
        defaults.setValue(contactNumberTextField.text ?? "", forKey:"contactNumber")
        defaults.setValue(emailTextField.text ?? "", forKey:"emailAddress")
        let myJsonData = cachedata()
        saveData(myJsonData: myJsonData)
    }
    func cachedata() -> contactData{
        if let fullName = defaults.value(forKey:"fullname") as? String,let contactNumber = defaults.value(forKey:"contactNumber")  as? String,let emailAddress = defaults.value(forKey:"emailAddress") as? String{
            nameLabel.text = fullName
            emailAddressLabel.text = emailAddress
            contactLabel.text = contactNumber
        }
        let data = contactData(userName: nameLabel.text, userContact: contactLabel.text, userEmail: emailAddressLabel.text)
        return data
    }
    func saveData(myJsonData:contactData){
        //creating path
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = URL(fileURLWithPath: "myFile", relativeTo: directoryURL).appendingPathExtension("json")
        do{ let jsonData = try JSONEncoder().encode(myJsonData)
            //save data
            try jsonData.write(to:fileURL )
            print("file Save: \(fileURL.absoluteURL)")
        }catch{
            print("nhi hua data store!!! ")
            return}
        
    }
}


