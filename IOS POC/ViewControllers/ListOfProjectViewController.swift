//
//  ListOfProjectViewController.swift
//  PocCombineMajor
//
//  Created by Pawan on 22/01/23.
//

import UIKit

class ListOfProjectViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {


    @IBOutlet weak var ListOfPocTabelView: UITableView!
    var ProjectListArray  = ["Dashboard","BankFD","NumberToWord","ImagePicker","Canvas","Factorial","Local Storage","Button Layout"]
    override func viewDidLoad() {
        super.viewDidLoad()
        ListOfPocTabelView.delegate = self
        ListOfPocTabelView.dataSource = self

        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ProjectListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CELL = tableView.dequeueReusableCell(withIdentifier: "ProjectListCell", for: indexPath)
        CELL.textLabel?.text = ProjectListArray[indexPath.row]
        CELL.textLabel?.textAlignment = .center
        CELL.accessoryType = .disclosureIndicator
        return CELL
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            performSegue(withIdentifier: "Contacts", sender: self)
        }
        if indexPath.row == 1{
             performSegue(withIdentifier: "FdCalculater", sender: self)
        }
        if indexPath.row == 2{
            performSegue(withIdentifier: "NumberToWord", sender: self)
        }
        if indexPath.row == 3{
            performSegue(withIdentifier: "ImagePicker", sender: self)
        }
        if indexPath.row == 4{
            performSegue(withIdentifier: "Canvas", sender: self)
        }
        if indexPath.row == 5{
            performSegue(withIdentifier: "Factorial", sender: self)
        }
        if indexPath.row == 6{
            performSegue(withIdentifier: "DataTransferToStorage", sender: self)
        }
        if indexPath.row == 7{
            performSegue(withIdentifier: "buttonLayout", sender: self)
        }
    }
    
    

}
