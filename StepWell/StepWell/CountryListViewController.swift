//
//  CountryListViewController.swift
//  StepWell
//
//  Created by Pawan on 03/02/23.
//

import UIKit

class CountryListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var countryDigitCodeSearchBar: UISearchBar!
    @IBOutlet weak var countryListTableView: UITableView!
    var countryData:[CountryData.Country]?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJsonFile()
        countryListTableView.delegate = self
        countryListTableView.dataSource = self }
    func loadJsonFile(){
        guard let path = Bundle.main.path(forResource: "CountryData", ofType: "json") else{return}
        let url = URL(fileURLWithPath: path)
        do{
            let data = try Data(contentsOf: url)
            print(data)
            let country = try
            JSONDecoder().decode(CountryData.self, from: data)
            print("i am 1st one to call")
            self.countryData = country.countryData
        } catch{ print(error) } }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("i am 2nd to print")
        return countryData!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        Cell.textLabel?.text = countryData![indexPath.row].dial_code
        Cell.textLabel?.textAlignment = .center
        return Cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    
}
