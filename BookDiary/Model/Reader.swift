//
//  Reader.swift
//  BookDiary
//
//  Created by Quien on 2022/12/4.
//

import Foundation

struct Reader: Equatable, Codable {
  var firstName: String
  var lastName: String
  var nickName: String?
  var email: String
  var books: [Book]?
  
  static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
  static let archiveURL = documentsDirectory.appendingPathComponent("readers").appendingPathExtension("list")
  
  init(firstName: String, lastName: String, nickName: String? = nil, email: String, books: [Book]? = nil) {
    self.firstName = firstName
    self.lastName = lastName
    self.nickName = nickName
    self.email = email
    self.books = books
  }
  
  static func == (lhs: Reader, rhs: Reader) -> Bool {
    return lhs.email == rhs.email
  }
  
  static func loadSampleBooks() -> [Reader] {
    let book1 = Book(title: "book1", author: "author1", language: Language.English, review: "It's an amazing book.", publishDate: Date())
    let book2 = Book(title: "book2", author: "author2", language: Language.English, genres: Genres.Fantasy,  publishDate: Date())
    let book3 = Book(title: "book3", author: "author3", language: Language.English, review: "It's an amazing book.", publishDate: Date())
    let book4 = Book(title: "book4", author: "author4", language: Language.English, genres: Genres.Art,  publishDate: Date())
    let book5 = Book(title: "book5", author: "author5", language: Language.English, review: "It's an amazing book.", publishDate: Date())
    let book6 = Book(title: "book6", author: "author6", language: Language.English, genres: Genres.Science,  publishDate: Date())
    let book7 = Book(title: "book7", author: "author7", language: Language.English, review: "It's an amazing book.", publishDate: Date())
    let book8 = Book(title: "book8", author: "author8", language: Language.English, genres: Genres.Business,  publishDate: Date())
    let book9 = Book(title: "book9", author: "author9", language: Language.English, review: "It's an amazing book.", publishDate: Date())
    let reader1 = Reader(firstName: "reader1", lastName: "Liu", nickName: "Quien", email: "reader1@gmail.com", books: [book1, book2, book3, book4])
    let reader2 = Reader(firstName: "reader2", lastName: "Chen", email: "reader1@gmail.com", books: [book5, book6, book7, book8, book9])
    return [reader1, reader2]
  }
  
  static func loadBooks() -> [Reader]? {
    guard let codedBooks = try? Data(contentsOf: archiveURL) else { return nil }
    let propertyListDecoder = PropertyListDecoder()
    return try? propertyListDecoder.decode(Array<Reader>.self, from: codedBooks)
  }
  
  static func saveBooks(_ books: [Reader]) {
    let propertyListEncoder = PropertyListEncoder()
    let codedBooks = try? propertyListEncoder.encode(books)
    try? codedBooks?.write(to: archiveURL, options: .noFileProtection)
  }
}

