//
//  MyShelfTableViewController.swift
//  BookDiary
//
//  Created by Quien on 2022/12/7.
//

import UIKit

class MyShelfTableViewController: UITableViewController, MyShelfCellDelegate {
  
  var posts = [Post]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.leftBarButtonItem = editButtonItem
    
    if let savedPosts = Post.loadPosts() {
      posts = savedPosts
    } else {
      posts = Post.loadSamplePosts()
      Post.savePosts(posts)
    }
    
  }
  
  func checkmarkTapped(sender: MyShelfTableViewCell) {
    if let indexPath = tableView.indexPath(for: sender) {
      var post = posts[indexPath.row]
      post.isComplete.toggle()
      posts[indexPath.row] = post
      tableView.reloadRows(at: [indexPath], with: .automatic)
    }
  }
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return posts.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! MyShelfTableViewCell
    let post = posts[indexPath.row]
    cell.dekegate = self
    cell.isCompleteButton.isSelected = post.isComplete
    cell.titleLabel.text = post.title
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      posts.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
}
