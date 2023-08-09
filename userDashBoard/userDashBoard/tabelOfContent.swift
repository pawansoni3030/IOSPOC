//
//  tabelOfContent.swift
//  userDashBoard
//
//  Created by Pawan on 17/01/23.
//

import UIKit

class tabelOfContent: UITableView,UITableViewDataSource {
    tableView.delegate = self
    tableView.datasource = self
    
    
    var dataSource = ["index1","index2"]
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    

    

}
