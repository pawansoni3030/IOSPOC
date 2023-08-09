//
//  FactorialViewController.swift
//  PocCombineMajor
//
//  Created by Pawan on 30/01/23.
//

import UIKit

class FactorialViewController: UIViewController {
    
    @IBOutlet weak var Submitbutton: UIButton!
    @IBOutlet weak var ResultBoxLabel: UILabel!
    @IBOutlet weak var NumberTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onClickFindFactorial(_ sender: Any) {
        if NumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            ResultBoxLabel.text = "enter valid number"
            return
        }
        let number = Int(NumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines))
        let result = String(findFactorial(number!))
        ResultBoxLabel.text = result
        
        
    }
    func findFactorial(_ number: Int) -> Int {
        if number <= 1 {
            return 1
        }
        return number * findFactorial(number - 1)
    }
}
