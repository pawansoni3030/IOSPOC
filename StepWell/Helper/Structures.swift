//
//  CountryCodeDataSoucre.swift
//  StepWell
//
//  Created by Pawan on 30/01/23.
//
import Foundation
import UIKit
struct CountryData: Decodable {
    struct Country: Decodable{
        var name: String?
        var flag: String?
        var code: String?
        var dial_code: String?
    }
    var countryData: [Country]
}



