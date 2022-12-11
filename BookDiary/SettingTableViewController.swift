//
//  SettingTableViewController.swift
//  BookDiary
//
//  Created by Hiroki Minami on 2022-12-09.
//

import UIKit

class SettingTableViewController: UITableViewController {
  
  var user: User?
  
//  let accountDetailIndexPath = IndexPath(row: 0, section: 0)
//  let browseDetailIndexPath = IndexPath(row: 0, section: 1)
  
  @IBOutlet var browserButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.user = User(firstName: "test", lastName: "test", userName: "test", passWord: "test", email: "test@gmail.com", userSetting: UserSetting())
    
    let closure = { (action: UIAction) in
      guard let currentUser = self.user else { return }
      currentUser.userSetting.browser = Browsers.getInstance(name: action.title)
      // save setting
    }
    browserButton.menu = UIMenu(children: [
      UIAction(title: "\(Browsers.Google)", handler: closure),
      UIAction(title: "\(Browsers.Amazon)", handler: closure)
    ])
    browserButton.showsMenuAsPrimaryAction = true
  }
  
  @IBSegueAction func goToAccountTableViewController(_ coder: NSCoder) -> UITableViewController? {
    let atvc =  AccountTableViewController(coder: coder)
    atvc?.user = self.user
    
    return atvc
  }
  
  @IBAction func unwindSetting(segue: UIStoryboardSegue) {
    
  }
}
