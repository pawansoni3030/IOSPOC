//
//  Functions.swift
//  StepWell
//
//  Created by Pawan on 22/02/23.
//

import Foundation
import UIKit


extension UIViewController{
    func showAlert(alertTitle:String,_ message:String){
        let Alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        Alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(Alert, animated: true, completion: nil)

    }
}
extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

