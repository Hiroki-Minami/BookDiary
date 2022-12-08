//
//  Books.swift
//  BookDiary
//
//  Created by Quien on 2022/12/4.
//

import Foundation

struct Post: Equatable, Codable {
  var id: UUID
  var title: String
  var img: String?
  var isComplete: Bool
  var author: String
  var rates: Float?
  var language: Language
  var genres: Genres?
  var review: String?
  var postedDate: Date
  var poster: Poster
  
  private static let archiveURL = FileManager.pathToDoucumentsDirectory(with: "posts")
  
  init(title: String, img: String? = nil, isComplete: Bool = false, author: String, rates: Float? = nil, language: Language, genres: Genres? = nil, review: String? = nil, postedDate: Date, poster: Poster) {
    self.id = UUID()
    self.title = title
    self.img = img
    self.isComplete = isComplete
    self.author = author
    self.rates = rates
    self.language = language
    self.genres = genres
    self.review = review
    self.postedDate = postedDate
    self.poster = poster
  }
  
  static func == (lhs: Post, rhs: Post) -> Bool {
    return lhs.id == rhs.id
  }
  
  /// load all Posts info from file
  /// - Returns: array of Post
  static func loadPosts() -> [Post]? {
    guard let codedPosts = try? Data(contentsOf: archiveURL) else { return nil }
    let propertyListDecoder = PropertyListDecoder()
    return try? propertyListDecoder.decode(Array<Post>.self, from: codedPosts)
  }
  
  /// save all Posts info in file
  /// - Parameter readers: array of Post
  static func savePosts(_ posts: [Post]) {
    let propertyListEncoder = PropertyListEncoder()
    let codedPosts = try? propertyListEncoder.encode(posts)
    try? codedPosts?.write(to: archiveURL, options: .noFileProtection)
  }
  
  /// static Posts data
  /// - Returns: array of Reader
  static func loadSamplePosts() -> [Post] {
    let poster1 = Poster(firstName: "poster1", nickName: "Quien")
    let poster2 = Poster(firstName: "poster2")
    let poster3 = Poster(firstName: "poster3", nickName: "Henry")
    let poster4 = Poster(firstName: "poster4")
    
    let post1 = Post(title: "book1", author: "author1", language: Language.English, genres: Genres.Fantasy, review: "It's an amazing book.", postedDate: Date(), poster: poster1)
    let post2 = Post(title: "book2", author: "author2", language: Language.Mandarin, genres: Genres.Art, review: "It's an amazing book.", postedDate: Date(), poster: poster1)
    let post3 = Post(title: "book3", author: "author3", language: Language.English, genres: Genres.Business, review: "It's an amazing book.", postedDate: Date(), poster: poster2)
    let post4 = Post(title: "book4", author: "author4", language: Language.English, genres: Genres.Fantasy, review: "It's an amazing book.", postedDate: Date(), poster: poster2)
    let post5 = Post(title: "book5", author: "author5", language: Language.Japanese, genres: Genres.Science, review: "It's an amazing book.", postedDate: Date(), poster: poster2)
    let post6 = Post(title: "book6", author: "author6", language: Language.English, genres: Genres.Fantasy, review: "It's an amazing book.", postedDate: Date(), poster: poster2)
    let post7 = Post(title: "book7", author: "author7", language: Language.English, genres: Genres.Art, review: "It's an amazing book.", postedDate: Date(), poster: poster3)
    let post8 = Post(title: "book8", author: "author8", language: Language.Korean, genres: Genres.Fantasy, review: "It's an amazing book.", postedDate: Date(), poster: poster4)
    let post9 = Post(title: "book9", author: "author9", language: Language.English, genres: Genres.Business, review: "It's an amazing book.", postedDate: Date(), poster: poster4)
    let post10 = Post(title: "book10", author: "author10", language: Language.English, genres: Genres.Fantasy, review: "It's an amazing book.", postedDate: Date(), poster: poster1)
    
    return [post1, post2, post3, post4, post5, post6, post7, post8, post9, post10]
  }
}
