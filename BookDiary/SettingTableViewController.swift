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
    // TODO: get current user
    self.user = User.currentUser
    
    let closure = { (action: UIAction) in
      guard let currentUser = self.user else { return }
      currentUser.userSetting.browser = Browsers.getInstance(name: action.title)
      // save setting
      guard var users = User.loadUsers() else { return }
      for (index, eachUser) in users.enumerated() {
        if eachUser.email == self.user!.email {
          users[index] = currentUser
        }
      }
      User.saveUsers(users)
    }
    
    let google = UIAction(title: "\(Browsers.Google)", handler: closure)
    let amazon = UIAction(title: "\(Browsers.Amazon)", handler: closure)
    if user?.userSetting.browser == .Google {
      google.state = .on
    } else {
      amazon.state = .on
    }
                          
    browserButton.menu = UIMenu(children: [google, amazon])
    browserButton.showsMenuAsPrimaryAction = true
  }
  
  @IBAction func unwindToSettingViewController(segue: UIStoryboardSegue) {
    guard segue.identifier == "changeAccountInfo" else { return }
    let sourceViewController = segue.source as! AccountTableViewController
    
    self.user = sourceViewController.user
  }
  
  @IBSegueAction func goToAccountTableViewController(_ coder: NSCoder) -> UITableViewController? {
    let atvc =  AccountTableViewController(coder: coder)
    atvc?.user = self.user
    
    return atvc
  }
}
