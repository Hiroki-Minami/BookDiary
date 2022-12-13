//
//  EachBookViewController.swift
//  BookDiary
//
//  Created by 村上匡志 on 2022-12-09.
//

import UIKit

class EachBookViewController: UIViewController {
  
  
  @IBOutlet var authorLabel: UILabel!
  @IBOutlet var genreLabel: UILabel!
  @IBOutlet var image: UIImageView!
  @IBOutlet var userButton: UIButton!
  
  var eachBook: Post?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    authorLabel.text = eachBook?.author
//    genreLabel.text = eachBook?.genres
    
  }
  
  
}
    
    
    
//    guard segue.identifier == "toEachBook" else {return}
    
//    let author = authorLabel.text!
//    let genreLabel = genreLabel.text!

//    if eachBook != nil {
//      if let eachBook = eachBook {
//        authorLabel.text = eachBook.author
//      }
//    }
//  }
  
    


