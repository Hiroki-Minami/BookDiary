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
  
  @IBAction func webSearchButtonTapped(_ sender: UIButton) {
    dekegate?.webSearchButtonTapped(sender: self)
  }
  
}

protocol MyShelfCellDelegate: AnyObject {
  func checkmarkTapped(sender: MyShelfTableViewCell)
  func webSearchButtonTapped(sender: MyShelfTableViewCell)
}
