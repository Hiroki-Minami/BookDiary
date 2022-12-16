//
//  UITableViewController+Extensions.swift
//  BookDiary
//
//  Created by Quien on 2022/12/15.
//

import UIKit

extension UITableViewController: UITextFieldDelegate {
  
  func setEndEditing() {
    let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
}
