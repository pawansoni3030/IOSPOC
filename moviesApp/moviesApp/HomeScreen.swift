//
//  ViewController.swift
//  moviesApp
//
//  Created by Pawan on 03/07/23.
//

import UIKit

class HomeScreen: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var homeTableView: UITableView!
    
    @IBOutlet weak var homeBgView: UIView!
    let headerTitles = ["","CHANT PUNJAB","SAGA HITS"]
    var dataArray: [String: AnyObject]?
    var movie: Array<Array<Dictionary<String,Any>>>?
    var SectionArray: Array<Array<Dictionary<String,Any>>>?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let data = getData().loadJson(filename: "basic_movies2")
          if data != nil{
              // do task
              sortDataFromObj(data: data)
          }
        homeTableView.allowsSelection = false
        homeTableView.dataSource = self
        homeTableView.delegate = self
        self.homeTableView.separatorStyle = .none
    }
    
    func sortDataFromObj(data: [String: AnyObject]?){
        dataArray = data
        movie = dataArray?["movies"] as? Array<Array<Dictionary<String,Any>>>
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return movie?.count ?? 0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerTitles[section]
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = #colorLiteral(red: 0.01629633456, green: 0.1933651268, blue: 0.251481086, alpha: 1)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 300
        }
        else{
            return 145
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if indexPath.section == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as? customTableViewCell else{
                return UITableViewCell()
            }
            cell.bannerTextLabel.text = "LIVE TV CHANNAELS"
            cell.bannerTextLabel.backgroundColor = .white
//            cell.textContainerView.layer.cornerRadius = 50
            cell.textContainerView.layer.cornerRadius = 15
            cell.textContainerView.layer.shadowColor = UIColor.gray.cgColor
            cell.textContainerView.layer.shadowOffset = CGSize.zero
            cell.textContainerView.layer.shadowOpacity = 1.0
            cell.textContainerView.layer.shadowRadius = 7.0
            cell.textContainerView.layer.masksToBounds =  false
            cell.textContainerView.clipsToBounds = true
            cell.setUpTableViewUiAndData(data: (movie?[indexPath.section] as? Array<Dictionary<String, Any>>)!)
            cell.myBackgroundView.bounds.size.height = 300
            cell.myBackgroundView.addBottomRoundedEdge(desiredCurve: 9)
            cell.myBackgroundView.backgroundColor = .systemRed
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell") as?  basicTableViewCell else {
                return UITableViewCell()}

            cell.setUpTableViewUiAndData(data: movie?[indexPath.section] as? Array<Dictionary<String, Any>>, style: false)
            return cell
        }
    }
}

