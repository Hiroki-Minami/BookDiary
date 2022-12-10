//
//  GeneralType.swift
//  BookDiary
//
//  Created by Quien on 2022/12/4.
//

import Foundation


/// Language of book
/// Example:
///   if you type Language.English, then will get "English" of String,
public enum Language: String, CaseIterable, Codable {
  case English, Mandarin, Japanese, Korean
}

///  Genre of book
/// Example:
///   if you type Genres.Art, then will get "Art" of String,
public enum Genres: String, CaseIterable, Codable {
  case Art, Business, Fantasy, History, Horror, Psychology, Romance, Science
}

/// Kind of browser in Setting
/// Example:
///   if you type Browsers.Google, then will get "Google" of String,
///   if you type Browsers.Google.rawValue, then will get "https://www.google.com" of String
public enum Browsers: String, CaseIterable, Codable {
  case Google = "https://www.google.com"
  case Amazon = "https://www.amazon.com"
  
  public static func getInstance(name: String) -> Browsers {
    switch name {
    case "\(Browsers.Google)":
      return Browsers.Google
    case "\(Browsers.Amazon)":
      return Browsers.Amazon
    default:
      return Browsers.Google
    }
  }
}

/// This is used for filter the list.
/// Example:
///   if you type Completion.complete, then will get "complete" of String,
public enum Completion: String, CaseIterable, Codable {
  case complete, incomplete
}
