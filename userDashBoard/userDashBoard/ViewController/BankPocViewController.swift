//
//  BankPocViewController.swift
//  userDashBoard
//
//  Created by Pawan on 17/01/23.
//

import UIKit

class BankPocViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var CalculateFdResult: UIButton!
    
    @IBOutlet weak var timePeriodTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var BankDropDownButton: UIButton!
    
    @IBOutlet weak var resultBoxLabel: UILabel!
    @IBOutlet weak var BankDropDownTabel: UITableView!
    public static var indexAtRow: Int? = nil
    var resultIntrest: Double? = nil
    
    struct Bank{
        var name : String
        var descrition : String
        var interestRate : Float
        var image : UIImage?
 }
//
    var BanksArray: [Bank] = [Bank(name: "ICIC", descrition: "WE PROVIDE BEST SERVICE", interestRate: 5.5, image: #imageLiteral(resourceName: "WhatsApp Image 2023-01-10 at 5.15.36 PM.jpeg")),Bank(name: "BOI", descrition: "WE ARE FASTEST BANK", interestRate: 6.7, image: nil),Bank(name: "SBI", descrition: "BAAD MEIN AANA ABHI LUNCH TIME HAI", interestRate: 7, image: nil), Bank(name: "Kotak", descrition: "We Provide 911", interestRate: 7.5),Bank(name: "HDFC", descrition: "WE ARE HIGN ON DEMAND", interestRate: 5.9,image: nil)]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
               BankDropDownTabel.isHidden = true
        BankDropDownTabel.dataSource = self
        BankDropDownTabel.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        BanksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell =  tableView.dequeueReusableCell(withIdentifier: "BANKS", for: indexPath)
//        Cell.textLabel?.text = BanksArray[indexPath.row].name
        Cell.textLabel?.text = BanksArray[indexPath.row].name
        Cell.imageView?.image = BanksArray[indexPath.row].image

                Cell.textLabel?.textAlignment = .center
        return Cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        BankDropDownTabel.isHidden = true
        print("testing indexpath \(indexPath) indexpathrow \(indexPath.row)")
         BankPocViewController.indexAtRow = indexPath.row
         BankDropDownButton.titleLabel?.text = BanksArray[BankPocViewController.indexAtRow!].name


    }
    func getBankNameAndRatefromTabel() -> Float? {
        let BankName = BanksArray[BankPocViewController.indexAtRow!].name
        let BankrateofIntrest = BanksArray[BankPocViewController.indexAtRow!].interestRate
        BankDropDownButton.titleLabel?.text = BankName
        return BankrateofIntrest
    }

    @IBAction func onClickSelectBank(_ sender: Any) {
        
        if  BankDropDownTabel.isHidden == false {BankDropDownTabel.isHidden = true} else {BankDropDownTabel.isHidden = false}
        
        
    }
    func CalculateResult(Amount: Int, Timeperiod: Int, BankrateofIntrest: Float) -> Double? {
        resultIntrest = Double((Float(Amount) + (( Float(Amount) * BankrateofIntrest) * Float(Timeperiod)  )/100) )
        return resultIntrest
    }
    
    @IBAction func onClickCalculateIntrest(_ sender: Any) {
        let AmountInRs = Int(amountTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines))
        let Duration = Int(timePeriodTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines))
        let RateofIntrest = getBankNameAndRatefromTabel()
        let resultIntrest = CalculateResult(Amount: AmountInRs!, Timeperiod: Duration!, BankrateofIntrest: RateofIntrest!)
        let resultString = String(resultIntrest!)
        resultBoxLabel.text = resultString
    }
    
    
    
}
