//
//  UserTableViewController.swift
//  BookDiary
//
//  Created by 村上匡志 on 2022-12-08.
//

import UIKit

class UserTableViewController: UITableViewController {
  
  var user: User?

  override func viewDidLoad() {
    super.viewDidLoad()
    
  }


//  override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//    return user.count
//  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
    return 1
  }
  
//  override func tableView(_ tableView: UITableView, cellForRowwAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = tableView.dequeueReusableCell(withIdentifier: "UserDetailCell", for: indexPath) as! UserDetailCell
//
//    let user = user[indexPath.row]
//    cell.authorLabel?.text = user.
//  }
//
}
