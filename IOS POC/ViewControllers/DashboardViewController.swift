//
//  ViewController.swift
//  PocCombineMajor
//
//  Created by Pawan on 19/01/23.
//

import UIKit

class DashboardViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var ContactListTabelView: UITableView!
    
    var contactArray:[ContactModel.Contact]?
    
    public static var selectedContact: ContactModel.Contact?  = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJsonFile()
        ContactListTabelView.dataSource = self
        ContactListTabelView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func loadJsonFile(){
        guard let path = Bundle.main.path(forResource: "Contacts", ofType: "json")else{return}
        let url = URL(fileURLWithPath: path)

        do {
        
          let data = try Data(contentsOf: url)
          print(data)
          let contact = try
            JSONDecoder().decode(ContactModel.self, from: data)
            print("i am 1st one to call")
            self.contactArray = contact.ContactsData

        } catch  {
          print(error)

        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { print("i am second")
     return (contactArray!.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ContactData = contactArray![indexPath.row]
       guard let Cell = tableView.dequeueReusableCell(withIdentifier: "Contactcell", for: indexPath) as? ContactCell
        else{
           fatalError("The dequeued cell is not an instance of TableViewCell.")
       }
        Cell.accessoryType = .disclosureIndicator
        Cell.ContactNameLabel?.text = ContactData.Name
        Cell.ContactProfileLabel?.text = ContactData.Profile
//        Cell.ContactProfilePhoto?.image.loadFrom(URLAddress: ContactData.profile_photo_url)
        return Cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("1",indexPath.row)
        DashboardViewController.selectedContact =  contactArray![indexPath.row]
       // print("2",DashboardViewController.ContactRowDataIndex)
        performSegue(withIdentifier: "ContactProfile", sender: self)
        
    }
    
}

