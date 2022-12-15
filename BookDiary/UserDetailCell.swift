//
//  UserDetailCell.swift
//  BookDiary
//
//  Created by 村上匡志 on 2022-12-09.
//

import UIKit
import SafariServices

protocol UserDetailCellDelegate: AnyObject {
  func searchOnTheInternet(_ viewControllerToPresent: UIViewController)
}

class UserDetailCell: UITableViewCell {
  
  weak var delegate: UserDetailCellDelegate?
  
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var authorLabel: UILabel!
  
  var post: Post?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  @IBAction func webSearchButtonTapped(_ sender: UIButton) {
    // TODO: get user setting
    guard let title = titleLabel.text, let url = URL(string: User.currentUser!.userSetting.browser.rawValue + title) else { return }
    let safariController = SFSafariViewController(url: url)
    delegate?.searchOnTheInternet(safariController)
  }

}
