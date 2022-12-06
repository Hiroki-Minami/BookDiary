//
//  Books.swift
//  BookDiary
//
//  Created by Quien on 2022/12/4.
//

import Foundation

struct Book: Equatable, Codable {
  var id: UUID
  var title: String
  var img: String?
  var isComplete: Bool
  var author: String
  var rates: Float?
  var language: Language
  var genres: Genres?
  var review: String?
  var publishDate: Date
  
  init(title: String, img: String? = nil, author: String, rates: Float? = nil, language: Language, genres: Genres? = nil, review: String? = nil, publishDate: Date) {
    self.id = UUID()
    self.title = title
    self.img = img
    self.isComplete = false
    self.author = author
    self.rates = rates
    self.language = language
    self.genres = genres
    self.review = review
    self.publishDate = publishDate
  }
  
  static func == (lhs: Book, rhs: Book) -> Bool {
    return lhs.id == rhs.id
  }
}
