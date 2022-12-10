//
//  GeneralType.swift
//  BookDiary
//
//  Created by Quien on 2022/12/4.
//

import Foundation


/// Language of book
/// Example:
///   if you type Language.English.rawValue, then will get "English" of String,
public enum Language: String, CaseIterable, Codable {
  case English, Mandarin, Japanese, Korean
}

///  Genre of book
/// Example:
///   if you type Genres.Art.rawValue, then will get "Art" of String,
public enum Genres: String, CaseIterable, Codable {
  case Art, Business, Fantasy, History, Horror, Psychology, Romance, Science
}

/// Kind of browser in Setting
/// Example:
///   if you type Browsers.Google.description, then will get "Google" of String,
///   if you type Browsers.Google.rawValue, then will get "https://www.google.com" of String
public enum Browsers: String, CaseIterable, Codable {
  case Google = "https://www.google.com/search?q="
  case Amazon = "https://www.amazon.ca/s?k="
  
  var description: String {
    return "\(self)"
  }
}
