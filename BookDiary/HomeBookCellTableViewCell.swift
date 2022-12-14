//
//  HomeBookCellTableViewCell.swift
//  BookDiary
//
//  Created by 村上匡志 on 2022-12-06.
//

import UIKit


class HomeBookCellTableViewCell: UITableViewCell {
  
  @IBOutlet var titleButton: UIButton!
  @IBOutlet var userButton: UIButton!
  
  var delegate: HomeTableViewControllerDelegate?
  var post: Post?
  
  override func awakeFromNib() {
    super.awakeFromNib()
        // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
        // Configure the view for the selected state
  }
  
  @IBAction func titleButtonTapped(_ sender: UIButton) {
    delegate?.titleButtonTapped(self)
  }
  
  
}



