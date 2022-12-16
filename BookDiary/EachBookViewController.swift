//
//  EachBookViewController.swift
//  BookDiary
//
//  Created by 村上匡志 on 2022-12-09.
//

import UIKit

class EachBookViewController: UIViewController {
  
  
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var bookLabel: UILabel!
  @IBOutlet var authorLabel: UILabel!
  @IBOutlet var genreLabel: UILabel!
  @IBOutlet var starRatingView: StarRatingView!
  @IBOutlet var notesTextView: UITextView!
  @IBOutlet var userButton: UIButton!
  
  
  var eachBook: Post?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bookLabel.text = eachBook?.title
    imageView.image = Post.loadImage(imageName: eachBook?.img)
    authorLabel.text = eachBook?.author
    genreLabel.text = "\(eachBook!.genres)"
    userButton.setTitle(eachBook!.poster.nickName != nil ? eachBook!.poster.nickName : eachBook!.poster.firstName, for: .normal)
    notesTextView.text = eachBook?.review
    starRatingView.ratingValue = eachBook?.rates ?? 0
    starRatingView.changeable = false
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "eachBookToUserDetail" {
      let userDetail = segue.destination as! UserTableViewController
      userDetail.poster = eachBook?.poster
    }
  }
  
}
  
    


