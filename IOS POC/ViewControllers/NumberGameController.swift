//
//  NumberGameController.swift
//  PocCombineMajor
//
//  Created by Pawan on 27/01/23.
//

import UIKit

class NumberGameController: UIViewController {
    
    @IBOutlet weak var NumberTextField: UITextField!
    @IBOutlet weak var ResultBoxTextField: UILabel!
    @IBOutlet weak var ConvertButton: UIButton!
    
    struct Numbers{
        var NumberInDigit: Int?
        var NumberInWords: String?
    }
    var NumberArray:[Numbers] = [Numbers(NumberInDigit: 0, NumberInWords: "Zero"),Numbers(NumberInDigit: 1, NumberInWords: "one"),Numbers(NumberInDigit: 2, NumberInWords: "Two"),Numbers(NumberInDigit: 3, NumberInWords: "Three"),Numbers(NumberInDigit: 4, NumberInWords: "Four"),Numbers(NumberInDigit: 5, NumberInWords: "Five"),Numbers(NumberInDigit: 6, NumberInWords: "Six"),Numbers(NumberInDigit: 7, NumberInWords: "Seven"),Numbers(NumberInDigit: 8, NumberInWords: "Eight"),Numbers(NumberInDigit: 9, NumberInWords: "Nine")]
  
    override func viewDidLoad() {
        super.viewDidLoad()
        ResultBoxTextField.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func OnClickCovertButton(_ sender: Any) {
        var FinalResult : String? = nil
        
        if NumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)==""{
            ResultBoxTextField.text = "type some thing Damme It!!!"
            ResultBoxTextField.isHidden = false
        }
//        else if NumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)=="0"{
//            ResultBoxTextField.text = "Zero"
//            ResultBoxTextField.isHidden = false
//        }
        else {
            ResultBoxTextField.text! = ""
            var Result = Int(String(NumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)))!
            if Result <= 0{
                ResultBoxTextField.text = NumberArray[0].NumberInWords
                FinalResult = NumberArray[0].NumberInWords
            }
    
                while Result > 0{
                    let NumberValueToPrint = Result % 10
                    Result = Result/10
//                    if Result == 0{
//                        FinalResult = NumberArray[0].NumberInWords
//                        
//                    }
                    print("1",NumberValueToPrint)
                    for Numbers in NumberArray where Numbers.NumberInDigit == NumberValueToPrint{
                        print("2",Numbers.NumberInWords!)
                        let GameLastString = Numbers.NumberInWords
                        if FinalResult != nil{
                            
                            FinalResult = GameLastString! + "," + FinalResult!
                            print("3",FinalResult!)
                        } else {
                            
                            FinalResult = GameLastString!
                            print("4",FinalResult!)
                        }  }  }
                ResultBoxTextField.text! = FinalResult!
                ResultBoxTextField.isHidden = false
            
            
        }
        
    }
}
