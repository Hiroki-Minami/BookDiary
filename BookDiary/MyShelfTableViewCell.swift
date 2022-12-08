//
//  MyShelfTableViewCell.swift
//  BookDiary
//
//  Created by Quien on 2022/12/7.
//

import UIKit

class MyShelfTableViewCell: UITableViewCell {
  
  @IBOutlet weak var isCompleteButton: UIButton!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var searchButton: UIButton!
  
  var dekegate: MyShelfCellDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
  @IBAction func completeButtonTapped(_ sender: UIButton) {
    dekegate?.checkmarkTapped(sender: self)
  }
  
  @IBAction func searchButtonTapped(_ sender: UIButton) {
//    guard let url = URL(string: "http://www.google.com") else {
//      return //be safe
//    }
//
//    if #available(iOS 10.0, *) {
//        UIApplication.shared.open(url, options: [:], completionHandler: nil)
//    } else {
//        UIApplication.shared.openURL(url)
//    }
    let url = URL(string: Setting.browser.rawValue)!
    if UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        //If you want handle the completion block than
        UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
             print("Open url : \(success)")
        })
    }
  }
  
  
}

protocol MyShelfCellDelegate: AnyObject {
  func checkmarkTapped(sender: MyShelfTableViewCell)
}
