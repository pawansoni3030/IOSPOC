//
//  NumberToWordGameViewController.swift
//  PocCombineMajor
//
//  Created by Pawan on 27/01/23.
//

import UIKit

class NumberToWordGameViewController: UIViewController {

    @IBOutlet weak var NumberTextField: UITextField!
    
    @IBOutlet weak var ResultBox: UILabel!
    
    @IBOutlet weak var ConvertButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ResultBox.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func OnClickConevrt(_ sender: Any) {
        if NumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)==""{
            ResultBox.text = "Enter Number to Conver"
            ResultBox.isHidden = false
        }
        else if Int(NumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines))! == 0{
            ResultBox.text = "Zero"
            ResultBox.isHidden = false
        }
        else if Int(NumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines))! > 0{
            let result = Int(NumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines))!
            print("1", result)
            ShowResult(number: result)
            }
        
    }
    
    var mapNumbers: [Int : String] = [0 : "Zero" ,
                                      1 : "One" ,
                                      2 : "Two",
                                      3 : "Three",
                                      4 : "Four",
                                      5 : "Five",
                                      6 : "Six",
                                      7 : "Seven",
                                      8 : "Eight",
                                      9 : "Nine"
                                      
    ]
    
    func ShowResult(number: Int){
        let lastResultValue = CovertNumberToWord(number: number)
        print("4",lastResultValue)
        ResultBox.text = lastResultValue
        ResultBox.isHidden = false
//
    }
    
    
    
    func CovertNumberToWord(number: Int) -> String {
        var result:String = ""
        var digits:Int = number
    
        repeat {
            let digit=digits%10
            let numberValue=mapNumbers[digit]
            let strAppend = result == "" ?"":", "
            result = numberValue!+strAppend + result
//            result = numberValue! + ", " + result
            digits=digits/10;
        }while(digits > 0);
    
        
        
        return result
    }

}
