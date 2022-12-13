//
//  UserDetailCell.swift
//  BookDiary
//
//  Created by 村上匡志 on 2022-12-09.
//

import UIKit

class UserDetailCell: UITableViewCell {
  
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var authorLabel: UILabel!
  

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
