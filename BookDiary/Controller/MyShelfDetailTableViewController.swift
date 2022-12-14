//
//  MyShelfDetailTableViewController.swift
//  BookDiary
//
//  Created by Quien on 2022/12/9.
//

import UIKit

class MyShelfDetailTableViewController: UITableViewController, RatingViewDelegate, GenreListDelegate {
  
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var AutherTextField: UITextField!
  @IBOutlet weak var ratesView: StarRatingView!
  @IBOutlet weak var reviewTextView: UITextView!
  @IBOutlet weak var genreLabel: UILabel!
  @IBOutlet weak var genreCountLabel: UILabel!
  @IBOutlet weak var saveButton: UIBarButtonItem!
  
  var post: Post?
  var rates: Float = 0.0
  var language: Language?
  var genre: Genres?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    ratesView.delegate = self
    updateView()
    updateSaveButtonState()
  }
  
  @IBSegueAction func selectGenre(_ coder: NSCoder, sender: Any?) -> GenreListTableViewController? {
    let detailController = GenreListTableViewController(coder: coder)
    detailController?.genre = Genres(rawValue: genreLabel.text!)
    return detailController
  }
  
  @IBAction func titleEditingChanged(_ sender: Any) {
    updateSaveButtonState()
  }
  
  @IBAction func autherEditingChanged(_ sender: Any) {
    updateSaveButtonState()
  }
  
  func updateView() {
    if let post = post {
      navigationItem.title = "Edit Post"
      titleTextField.text = post.title
      AutherTextField.text = post.author
      ratesView.ratingValue = post.rates!
      reviewTextView.text = post.review!
      genreLabel.text = post.genres.rawValue
      genre = post.genres
    }
    genreCountLabel.text = String(Genres.allCases.count)
  }
  
  func updateSaveButtonState() {
    let notYet = "Not Yet"
    let shouldEnableSaveButton =
    (titleTextField.text?.isEmpty == false) &&
    (AutherTextField.text?.isEmpty == false) &&
    (genreLabel.text?.isEmpty == false) &&
    !notYet.contains(genreLabel.text!)
    saveButton.isEnabled = shouldEnableSaveButton
  }
  
  // MARK: - Delegate
  
  func updateRatingFormatValue(_ value: Float) {
    rates = value
  }
  
  func didSelect(genre: Genres) {
    self.genre = genre
    genreLabel.text = genre.rawValue
    updateSaveButtonState()
  }
  
  // MARK: -
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "saveUnwind" {
      let title = titleTextField.text!
      let auther = AutherTextField.text!
      let review = reviewTextView.text
      
      if post != nil {
        post?.title = title
        post?.author = auther
        post?.rates = rates
        post?.review = review
        post?.genres = genre!
      } else {
        post = Post(title: title, author: auther, rates: rates, genres: Genres(rawValue: genre!.rawValue)!, review: review, postedDate: Date(), poster: Poster(firstName: "Quien", nickName: "Quien"))
      }
    } else if segue.identifier == "selectGenre" {
      let destinationViewController = segue.destination as? GenreListTableViewController
      destinationViewController?.delegate = self
      destinationViewController?.genre = genre
    } else {
      return
    }
  }
  
}
