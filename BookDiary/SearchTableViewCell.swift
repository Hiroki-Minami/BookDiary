//
//  SearchTableViewCell.swift
//  BookDiary
//
//  Created by Hiroki Minami on 2022-12-06.
//

import UIKit
import SafariServices

protocol searchTableViewCellDelegate: AnyObject {
  func searchOnTheInternet(_ viewControllerToPresent: UIViewController)
  func titleButtonTapped(_ sender: Any)
  func userButtonTapped(_ sender: Any)
}

class SearchTableViewCell: UITableViewCell {
  
  weak var delegate: searchTableViewCellDelegate?
  var post: Post?
  
  @IBOutlet var titleButton: UIButton!
  @IBOutlet var userButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  @IBAction func titleButtonTapped(_ sender: UIButton) {
    delegate?.titleButtonTapped(post!)
  }
  
  
  @IBAction func userButtonTapped(_ sender: UIButton) {
    delegate?.userButtonTapped(post!)
  }
  
  @IBAction func webSearchButtonTapped(_ sender: UIButton) {
    // TODO: get user setting
    guard let title = titleButton.titleLabel?.text, let url = URL(string: User.currentUser!.userSetting.browser.rawValue + title) else { return }
    let safariController = SFSafariViewController(url: url)
    delegate?.searchOnTheInternet(safariController)
  }
}
