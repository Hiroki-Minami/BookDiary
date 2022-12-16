//
//  Books.swift
//  BookDiary
//
//  Created by Quien on 2022/12/4.
//

import Foundation
import UIKit

struct Post: Equatable, Codable {
  var id: UUID
  var title: String
  var img: String?
  var isComplete: Bool
  var author: String
  var rates: Float?
  var genres: Genres
  var review: String?
  var postedDate: Date
  var poster: Poster
  
  private static let archiveURL = FileManager.pathToDoucumentsDirectory(with: "posts")
  
  init(title: String, img: String? = nil, isComplete: Bool = false, author: String, rates: Float? = 0.0, genres: Genres, review: String? = nil, postedDate: Date, poster: Poster) {
    self.id = UUID()
    self.title = title
    self.img = img
    self.isComplete = isComplete
    self.author = author
    self.rates = rates
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
  
  static func loadImage(imageName: String?) -> UIImage? {
    if let img = imageName {
      if let imageData = try? Data(contentsOf: FileManager.pathToImagesDirectory(with: img)) {
        return UIImage(data: imageData)
      } else {
        return nil
      }
    } else {
      return nil
    }
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
    let poster1 = Poster(firstName: "Masa", nickName: "Masa")
    let poster2 = Poster(firstName: "Hiroki")
    let poster3 = Poster(firstName: "Tsung Hsun", nickName: "Quien")
    let poster4 = Poster(firstName: "Steven")
    let poster5 = Poster(firstName: "Henry")
    
    let post1 = Post(title: "A WORLD OF CURIOSITIES: A NOVEL", author: "Louise Penny", genres: Genres.Fiction, postedDate: Date(), poster: poster1)
    let post2 = Post(title: "TOMORROW, AND TOMORROW, AND TOMORROW: A NOVEL", isComplete: true, author: "Gabrielle Zevin", rates: 5.0, genres: Genres.Art, review: "This book was well-written but it seemed to meander sometimes and the author occasionally lacked creativity to solve problems for her characters. It was well-written and enjoyable though.", postedDate: Date(), poster: poster2)
    let post3 = Post(title: "THE STORIED LIFE OF A. J. FIKRY", isComplete: true, author: "Gabrielle Zevin", rates: 5.0, genres: Genres.Fiction, review: "A.J Fikry was a wonderful character I really enjoyed watching him grow and learn as a person through out the story. I think Maya was my favorite character, having children of my own she definitely held a special place in my heart. Her personality and actions was so true to how real and honest kids can be and how they see the world in ways I wish I could see it again. All the characters brought something to the story and I think this is the first book I have read in a while where there wasn't one I disliked or was annoyed by.\r\nThis book is about love, learning, trials and tribulations. I am a big believer in everything happens for a reason and this book shows what good things can come out bad situations. It just gives me that warm cozy feeling, and I plan on purchasing this book and re-reading it time and time again.\r\nThis is my first Gabrielle Zevin novel, I do own Elsewhere by her but have not yet read it. I loved her writing style it was so easy to enjoy and read I flew through this book in no time at all. She captivated me without me even knowing it. I recommend this book to anyone and everyone that loves reading!", postedDate: Date(), poster: poster3)
    let post4 = Post(title: "Atomic Habits: An Easy & Proven Way To Build Good Habits & Break Bad Ones.", isComplete: true, author: "James Clear", rates: 3.0, genres: Genres.Business, review: "This book can help you change your bad habits into good ones by slowly but mindfully changing them. It has helped me ALOT as well so I would definitely recommend this book to EVERYONE not just anyone.", postedDate: Date(), poster: poster4)
    let post5 = Post(title: "VIRGIL ABLOH. NIKE. ICONS", isComplete: true, author: "Virgil Abloh", rates: 4.0, genres: Genres.Art, review: "This is more a piece of artwork than a book. The spine isn’t connected to the cover making it easy to read. The photography is amazing and the story of Nike is fascinating. I bought as a gift for my son who is a huge Nike fan. He loved it and I highly recommend it as a gift for any Nike fan.", postedDate: Date(), poster: poster5)
    let post6 = Post(title: "THERE AND BACK: PHOTOGRAPHS FROM THE EDGE", isComplete: true, author: "Jimmy Chin", rates: 3.0, genres: Genres.Art, review: "Beautiful chronicle of adventures around the world.", postedDate: Date(), poster: poster3)
    let post7 = Post(title: "Wally Koval", isComplete: true, author: "Wally Koval", rates: 5.0, genres: Genres.Art, review: "I've always been an armchair traveller - even more so now with the appearance of Covid. I love 'visiting' out of the way, off the beaten track and unusual locations and attractions etc. The newly released Accidentally Wes Anderson by Wally Koval is a compilation of those.\r\nNow, you may be wondering about the title. Accidentally Wes Anderson began as as a travel bucket list for Koval and his wife. Specifically places that embodied the style of filmmaker Wes Anderson. As they started to document their travels, others started weighing in with their own pictures. Things grew and there are now over one million Adventurers seeking out and sharing locations on Accidentally Wes Anderson (AWA)\r\nThe real Wes Anderson provides a forward. The book is divided into nine chapters that circle the globe. Each entry has a full color photograph, location and year and a detailed entry on the place. This is one of those coffee table kind of books that if you leave out, people will inevitably pick and peruse. Normally I would have done that, but I decided to travel along with the layout starting with North America.\r\nThe pictures are what first catch your eye, the stark simplicity, the colors, the almost 'otherworldliness' of them. Set into a single shot, they almost feel not real and do indeed bring Anderson's films to mind. Think 'The Grand Budapest Hotel.' And then there's the story about the location. This for me, was absolutely fascinating.\r\nA favorite? I can't pick one but the striped bungalows in Portugal, launderettes in England, a viewfinder in Iceland, fishing huts in Canada, typewriters in New York were a few of them. There are many, many more and each is just as wonderful\r\nFans of Atlas Obscura will love this book. And it would make a great gift. Accidentally Wes Anderson is a unique and captivating look at jewels out in plain sight - if you only knew where - and how - to look.", postedDate: Date(), poster: poster3)
    let post8 = Post(title: "The Bomber Mafia: A Dream, A Temptation, And The Longest Night Of The Second World War", author: "Malcolm Gladwell", genres: Genres.History, postedDate: Date(), poster: poster3)
    let post9 = Post(title: "Mythology (75th Anniversary Illustrated Edition): Timeless Tales Of Gods And Heroes", isComplete: true, author: "Edith Hamilton", rates: 3.0, genres: Genres.History, postedDate: Date(), poster: poster1)
    let post10 = Post(title: "BREATH: THE NEW SCIENCE OF A LOST ART", author: "James Nestor", genres: Genres.Science, postedDate: Date(), poster: poster3)
    let post11 = Post(title: "Immune: A Journey Into The Mysterious System That Keeps You Alive", isComplete: true, author: "Philipp Dettmer", rates: 5.0, genres: Genres.Science, review: "It's a good book.", postedDate: Date(), poster: poster2)
    let post12 = Post(title: "THE CHOICE: THE DRAGON HEART LEGACY, BOOK 3", isComplete: true, author: "Nora Roberts", rates: 3.0, genres: Genres.Fantasy, review: "It's a good book.", postedDate: Date(), poster: poster4)
    let post13 = Post(title: "Babel: Or The Necessity Of Violence: An Arcane History Of The Oxford Translators' Revolution", isComplete: true, author: "James Nestor", rates: 4.0, genres: Genres.Fantasy, review: "I went into this book thinking it was going to be your average dark academia/pro-institutionalist book. However, this books dismantles academia with such deeps and raw words. It’s the best book I’ve read this year and the end had me sobbing uncontrollably.", postedDate: Date(), poster: poster5)
    
    return [post1, post2, post3, post4, post5, post6, post7, post8, post9, post10, post11, post12, post13]
  }
}
