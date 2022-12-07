//
//  Setting.swift
//  BookDiary
//
//  Created by Quien on 2022/12/4.
//

import Foundation


/// For login and setting
class UserInfo: Codable {
  var firstName: String
  var lastName: String
  var nickName: String?
  var userName: String
  var passWord: String
  var email: String
  var browser: Browsers
  
  static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
  static let archiveURL = documentsDirectory.appendingPathComponent("userInfo").appendingPathExtension("plist")

  init(firstName: String, lastName: String, nickName: String? = nil, userName: String, passWord: String, email: String, browser: Browsers = Browsers.Google) {
    self.firstName = firstName
    self.lastName = lastName
    self.nickName = nickName
    self.userName = userName
    self.passWord = passWord
    self.email = email
    self.browser = browser
  }
  
  static func loadSetting() -> UserInfo? {
    guard let codedUserInfo = try? Data(contentsOf: archiveURL) else { return nil }
    let propertyListDecoder = PropertyListDecoder()
    return try? propertyListDecoder.decode(UserInfo.self, from: codedUserInfo)
  }
  
  static func saveSetting(_ userInfo: UserInfo) {
    let propertyListEncoder = PropertyListEncoder()
    let codedUserInfo = try? propertyListEncoder.encode(userInfo)
    try? codedUserInfo?.write(to: archiveURL, options: .noFileProtection)
  }
}

