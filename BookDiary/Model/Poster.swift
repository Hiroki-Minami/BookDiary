//
//  Reader.swift
//  BookDiary
//
//  Created by Quien on 2022/12/4.
//

import Foundation


struct Poster: Codable {
  var firstName: String
  var nickName: String?
  
  init(firstName: String, nickName: String? = nil) {
    self.firstName = firstName
    self.nickName = nickName
  }
  
}

