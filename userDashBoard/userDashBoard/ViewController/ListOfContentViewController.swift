//
//  ListOfContentViewController.swift
//  userDashBoard
//
//  Created by Pawan on 17/01/23.
//

import UIKit

class ListOfContentViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{


    @IBOutlet weak var ListOfProject: UITableView!
    
    var ProjectListArray  = ["Dashboard","BankFD"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ListOfProject.delegate = self
        ListOfProject.dataSource = self
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ProjectListArray.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        cell.textLabel?.text = ProjectListArray[indexPath.row]
                cell.textLabel?.textAlignment = .center
                return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            performSegue(withIdentifier: "UserDashBoard", sender: self)
                    } else if indexPath.row == 1 {
                        //another VC
                        performSegue(withIdentifier: "BankFDCalaculater", sender: self)
                    } else if indexPath.row == 2 {
                        //Another VC
                        performSegue(withIdentifier: "UserDashBoard", sender: self)
                    }
       

   

    }

                
                

    
    

   

}
