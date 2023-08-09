//
//  JsonSetupCode.swift
//  PocCombineMajor
//
//  Created by Pawan on 24/01/23.
//

import Foundation
//Create a local path
guard let jsonURl = Bundle(for: type(of: self)).path(forResource: "companyData", ofType: "json") else {
    return
}

//Convert PathURL to string
guard let jsonString = try? String(contentsOf: URL(fileURLWithPath: jsonURL), encoding: String.encoding.utf8) else {
   return
}
