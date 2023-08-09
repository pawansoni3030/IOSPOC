//
//  FDCalculationViewController.swift
//  PocCombineMajor
//
//  Created by Pawan on 22/01/23.
//

import UIKit

class FDCalculationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var BankDropdownButton: UIButton!
    @IBOutlet weak var AmountTextField: UITextField!
    @IBOutlet weak var CalculateFdResult: UIButton!
    @IBOutlet weak var ResultBoxlabel: UILabel!
    @IBOutlet weak var TimeDurationTextField: UITextField!
    
    @IBOutlet weak var BankDropDownTable: UITableView!
    public static var indexAtRow: Int? = nil
    var Result: Double? = nil
    
    var BankDataArray: [Bank] = [Bank(bankName: "SBI", fdRate: 5.7, BankDiscription: "We are Best", BankImage: nil),Bank(bankName: "HDFC", fdRate: 5.5, BankDiscription: "We are GOAT", BankImage: nil),Bank(bankName: "Kotak", fdRate: 5.5, BankDiscription: "We are best at stock exchange", BankImage: nil)]
    override func viewDidLoad() {
        super.viewDidLoad()
        BankDropDownTable.delegate = self
        BankDropDownTable.dataSource = self
        ResultBoxlabel.alpha = 0
        BankDropDownTable.isHidden = true
        // Do any additional setup after loading the view.
    }
    func getRateOfIntrest() -> Float {
        let rateOfIntrest = BankDataArray[FDCalculationViewController.indexAtRow!].fdRate
        return rateOfIntrest!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        BankDataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "BankCell", for: indexPath)
        Cell.textLabel?.text = BankDataArray[indexPath.row].bankName
        Cell.textLabel?.textAlignment = .center
        return Cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        BankDropDownTable.isHidden = true
        
        FDCalculationViewController.indexAtRow = indexPath.row
        // remove befor deployment
        print("testing indexpath \(indexPath) indexpathrow \(indexPath.row) indexatRow \(String(describing: FDCalculationViewController.indexAtRow))")
        
        BankDropdownButton.titleLabel?.text = BankDataArray[indexPath.row].bankName
        BankDropdownButton.titleLabel?.textAlignment = .center
    }
    
    @IBAction func onClickCalculateResult(_ sender: Any) {
        if AmountTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)=="" || TimeDurationTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)=="" {
            let EmpityFieldsAlert = UIAlertController(title: "Warning", message: "fill all fields", preferredStyle: UIAlertController.Style.alert)
            EmpityFieldsAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default))
            self.present(EmpityFieldsAlert, animated: true, completion: nil)
            
            //            ResultBoxlabel.text = "Fill all fields"
            //            ResultBoxlabel.textColor = .red
            //            ResultBoxlabel.alpha = 1
        } else{
            let timePeriod = Int((TimeDurationTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!)
            let amount = Int((AmountTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!)
            let rateOfIntrest = getRateOfIntrest()
            //        var result = amount + ( amount * (timePeriod/100) * rateOfIntrest)
            Result = ResultCalculation(Amount: amount!, rateOfIntrest: rateOfIntrest, timePeriod: timePeriod!)
            let ResultString = String(Result!)
            ResultBoxlabel.textColor = .green
            ResultBoxlabel.text = ResultString
            
            
        }
    }
    func ResultCalculation(Amount: Int , rateOfIntrest: Float, timePeriod: Int) ->  Double? {
        let result = Double(Float(Amount) + ( Float(Amount) * (Float(timePeriod) / 100) * rateOfIntrest))
        return result
    }
    
    @IBAction func onClickSelectBank(_ sender: Any) {
        BankDropDownTable.isHidden = false
    }
    
    
    
    
}
