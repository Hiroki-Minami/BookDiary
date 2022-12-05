//
//  GeneralType.swift
//  BookDiary
//
//  Created by Quien on 2022/12/4.
//

import Foundation


/// Language of books
public enum Language: String, CaseIterable {
  case English, Mandarin, Japanese, Korean
}

///  Genre of books
public enum Genres: String, CaseIterable {
  case Art, Business, Fantasy, History, Horror, Psychology, Romance, Science
}
