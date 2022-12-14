//
//  RatingAlertViewController.swift
//  BookDiary
//
//  Created by Quien on 2022/12/13.
//

import UIKit

class RatingAlertViewController: UIViewController, RatingViewDelegate {
  
  @IBOutlet weak var starRatingView: StarRatingView!
  
  var delegate: RatingAlertViewControllerDelegate!
  var ratingValue: Float = 0.0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    starRatingView.delegate = self
    starRatingView.ratingValue = ratingValue
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
  }
  
  func updateRatingFormatValue(_ value: Float) {
    if delegate != nil {
      delegate.updateRatingFormatValue(value)
    }
  }
  
}

protocol RatingAlertViewControllerDelegate {
  func updateRatingFormatValue(_ value: Float)
}
