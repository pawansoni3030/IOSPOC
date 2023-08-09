//
//  ContactListViewController.swift
//  PocCombineMajor
//
//  Created by Pawan on 19/01/23.
//

import UIKit

class ContactListViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
   
    @IBOutlet weak var ContactListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ContactListTableView.dataSource = self
        ContactListTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }


}
