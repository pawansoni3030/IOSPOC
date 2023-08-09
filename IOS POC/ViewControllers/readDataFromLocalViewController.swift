//
//  readDataFromLocalViewController.swift
//  PocCombineMajor
//
//  Created by Pawan on 10/02/23.
//

import UIKit

class readDataFromLocalViewController: UIViewController {

    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var contactNumberLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func onClickLoadDataFromLocal(_ sender: Any) {
        let LocalData = loadData()
            fullNameLabel.text = LocalData.userName
            contactNumberLabel.text = LocalData.userContact
            emailAddressLabel.text = LocalData.userEmail
            print(LocalData.userName!)


    }
    func loadData() -> contactData{
        //  creating path to directry
        let userDirectry = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileUrl = URL(filePath: "myFile",relativeTo: userDirectry).appendingPathExtension(for: .json)
        // read data from local
        var savedData:contactData? = nil
        do{
           let localDataUrl = try Data(contentsOf: fileUrl)
              savedData = try JSONDecoder().decode(contactData.self, from: localDataUrl)
                print("data fetch successfull")
        }catch{
                print("unable to load data")}
        if savedData != nil{
            return savedData!
        }
        else{
            print("error in loading Data")
            let noSuchData = contactData(userName: "nil", userContact: "nil", userEmail: "nil")
            return noSuchData
        }
    }
  
}
