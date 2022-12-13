//
//  Setting.swift
//  BookDiary
//
//  Created by Quien on 2022/12/4.
//

import Foundation


/// For login and setting
class User: Codable {
  
  static var currentUser: User?
  
  var firstName: String
  var lastName: String
  var nickName: String?
  var passWord: String
  var email: String
  var userSetting: UserSetting
  
  private static let archiveURL = FileManager.pathToDoucumentsDirectory(with: "users")
  
  init(firstName: String, lastName: String, nickName: String? = nil, passWord: String, email: String, userSetting: UserSetting) {
    self.firstName = firstName
    self.lastName = lastName
    self.nickName = nickName
    self.passWord = passWord
    self.email = email
    self.userSetting = userSetting
  }
  
  static func loadUsers() -> [User]? {
    guard let codedUser = try? Data(contentsOf: archiveURL) else { return nil }
    let propertyListDecoder = PropertyListDecoder()
    return try? propertyListDecoder.decode(Array<User>.self, from: codedUser)
  }
  
  static func saveUsers(_ users: [User]) {
    let propertyListEncoder = PropertyListEncoder()
    let codedUser = try? propertyListEncoder.encode(users)
    try? codedUser?.write(to: archiveURL, options: .noFileProtection)
  }

}

struct UserSetting: Codable {
  var browser: Browsers = Browsers.Google
}
