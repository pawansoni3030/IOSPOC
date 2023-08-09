//
//  ContactModel.swift
//  PocCombineMajor
//
//  Created by Pawan on 02/02/23.
//

import Foundation
public struct ContactModel: Decodable {
  
  public struct Contact: Decodable {
    let Name: String?
    let Profile: String?
    let Phone: String?
    let Email: String?
    let ProfileImageUrl: String?
  }
  let ContactsData: [Contact]?
}

struct contactData: Codable{
    let userName: String?
    let userContact: String?
    let userEmail: String?
}
