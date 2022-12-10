//
//  MyShelfDetailTableViewController.swift
//  BookDiary
//
//  Created by Quien on 2022/12/9.
//

import UIKit

class MyShelfDetailTableViewController: UITableViewController, RatingViewDelegate {
  
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var AutherTextField: UITextField!
  @IBOutlet weak var ratesView: StarRatingView!
  @IBOutlet weak var reviewTextView: UITextView!
  
  var post: Post?
  var rates: Float = 0.0
  var selectedGenre = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateView()
    ratesView.delegate = self
  }
  
  func updateView() {
    if let post = post {
      navigationItem.title = "Edit Post"
      titleTextField.text = post.title
      AutherTextField.text = post.author
      ratesView.ratingValue = post.rates!
      reviewTextView.text = post.review!
    }
  }
  
  func updateRatingFormatValue(_ value: Float) { rates = value }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == "saveUnwind" else { return }
    let title = titleTextField.text!
    let auther = AutherTextField.text!
    let review = reviewTextView.text
    
    if post != nil {
      post?.title = title
      post?.author = auther
      post?.rates = rates
      post?.review = review
    } else {
      post = Post(title: title, author: auther, rates: rates, language: Language.English, genres: Genres(rawValue: selectedGenre), review: review, postedDate: Date(), poster: Poster(firstName: "Quien"))
    }
  }
  
}
