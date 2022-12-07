//
//  Reader.swift
//  BookDiary
//
//  Created by Quien on 2022/12/4.
//

import Foundation

struct Poster: Equatable, Codable {
  var firstName: String
  var lastName: String
  var nickName: String?
  var email: String
  
  init(firstName: String, lastName: String, nickName: String? = nil, email: String) {
    self.firstName = firstName
    self.lastName = lastName
    self.nickName = nickName
    self.email = email
  }
  
  static func == (lhs: Poster, rhs: Poster) -> Bool {
    return lhs.email == rhs.email
  }
  
}

