//
//  GeneralType.swift
//  BookDiary
//
//  Created by Quien on 2022/12/4.
//

import Foundation


/// Language of books
/// Example:
///   if you type Language.English, then will get "English" of String,
public enum Language: String, CaseIterable {
  case English, Mandarin, Japanese, Korean
}

///  Genre of books
/// Example:
///   if you type Genres.Art, then will get "Art" of String,
public enum Genres: String, CaseIterable {
  case Art, Business, Fantasy, History, Horror, Psychology, Romance, Science
}

/// Kind of browser in Setting
/// Example:
///   if you type Browsers.Google, then will get "Google" of String,
///   if you type Browsers.Google.rawValue, then will get "https://www.google.com" of String
public enum Browsers: String, CaseIterable {
  case Google = "https://www.google.com"
  case Amazon = "https://www.amazon.com"
}
