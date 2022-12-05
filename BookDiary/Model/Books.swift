//
//  Books.swift
//  BookDiary
//
//  Created by Quien on 2022/12/4.
//

import Foundation

struct Books {
  let id = UUID()
  var title: String
  var img: String
  var isComplete: Bool
  var author: String
  var rates: Float
  var language: Language
  var genres: Genres?
  var pages: Int?
}


