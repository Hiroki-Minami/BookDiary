//
//  File.swift
//  BookDiary
//
//  Created by Quien on 2022/12/13.
//

import UIKit

extension UIAlertController {
 
  func addAlertAction(title: String, style: UIAlertAction.Style = .default, handler: ((UIAlertAction) -> Void)? = nil) {
    let action = UIAlertAction(title: title, style: style, handler: handler)
    addAction(action)
  }
  
  func setViewController(title: String, message: String, ratingValue: Float, delegate: RatingAlertViewControllerDelegate) {
    let sb = UIStoryboard(name: "Main", bundle: nil)
    guard let vc = sb.instantiateViewController(withIdentifier: "RatingAlertViewController") as? RatingAlertViewController else { return }
    vc.delegate = delegate
    vc.ratingValue = ratingValue
    setValue(vc, forKey: "contentViewController")
  }

}
