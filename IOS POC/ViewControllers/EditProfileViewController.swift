//
//  EditProfileViewController.swift
//  PocCombineMajor
//
//  Created by Pawan on 23/01/23.
//

import UIKit
import SwiftUI

class EditProfileViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var EditImageView: UIImageView!
    @IBOutlet weak var EditConatctName: UITextField!
    @IBOutlet weak var EditContactProfile: UITextField!
    @IBOutlet weak var EditContactNumber: UITextField!
    @IBOutlet weak var EditEmail: UITextField!
    @IBOutlet weak var SaveEditedContactDataButton: UIBarButtonItem!
    @IBOutlet weak var ChangeImageButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        // geting Data from ViewController identifier - ContactViewController
        ShowContactData()
        // Shwing edited data
        // Do any additional setup after loading the view.
    }
    func ShowContactData(){
        var contact = DashboardViewController.selectedContact
//        let VC = self.storyboard?.instantiateViewController(withIdentifier: "ContactViewController") as! DashboardViewController
        EditConatctName.text = contact!.Name
        EditContactProfile.text = contact!.Profile
        EditContactNumber.text = contact!.Phone
        EditEmail.text = contact!.Email
//        EditImageView.image = VC.ContactArray[DassboardViewController.ContactRowDataIndex!].ProfileImage
        EditImageView.loadFrom(URLAddress: contact!.ProfileImageUrl!)
//        "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2")

      
    }
    @IBAction func OnClickSaveEditedData(_ sender: Any) {
        if EditConatctName.text!.trimmingCharacters(in: .whitespacesAndNewlines) == ""||EditContactProfile.text!.trimmingCharacters(in: .whitespacesAndNewlines) == ""||EditConatctName.text!.trimmingCharacters(in: .whitespacesAndNewlines) == ""||EditContactNumber.text!.trimmingCharacters(in: .whitespacesAndNewlines) == ""||EditConatctName.text!.trimmingCharacters(in: .whitespacesAndNewlines) == ""||EditEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            let EmpityFieldsAlert = UIAlertController(title: "Warning", message: "fill all fields", preferredStyle: UIAlertController.Style.alert)
            EmpityFieldsAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default))
            self.present(EmpityFieldsAlert, animated: true, completion: nil)
}
        else{
            let EmpityFieldsAlert = UIAlertController(title: "Warning", message: "you can change ", preferredStyle: UIAlertController.Style.alert)
            EmpityFieldsAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default))
            self.present(EmpityFieldsAlert, animated: true, completion: nil)
}
    }
    
    @IBAction func onClickChnageImage(_ sender: Any) {
        let ChosseImage = UIAlertController(title: "Chosse Image", message: nil, preferredStyle: UIAlertController.Style.alert)
        ChosseImage.addAction(UIAlertAction(title: "Camera", style: UIAlertAction.Style.default,handler: { UIAlertAction in
            self.editImageByCamera()
        }))
//        ChosseImage.addAction(UIAlertAction(title: "Camera", style: UIAlertAction.Style.default))
        ChosseImage.addAction(UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default,handler: { UIAlertAction in
            self.editImageByGallery()
        }))
        ChosseImage.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default))
        self.present(ChosseImage, animated: true, completion: nil)
//        editImageByCamera()

 }

    func editImageByCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
        
    }
    func editImageByGallery(){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            EditImageView.image = image
        }

    }

    
}
extension UIImageView {
    func loadFrom(URLAddress: String) {
        if let url = URL(string: URLAddress) {
           URLSession.shared.dataTask(with: url) { (data, response, error) in
             // Error handling...
             guard let imageData = data else { return }

             DispatchQueue.main.async {
               self.image = UIImage(data: imageData)
             }
           }.resume()
         }

    }
}



