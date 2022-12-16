//
//  UserTableViewController.swift
//  BookDiary
//
//  Created by 村上匡志 on 2022-12-08.
//

import UIKit

class UserTableViewController: UITableViewController, UserDetailCellDelegate {
  
  var poster: Poster?
  var posts: [Post] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    if let nickName = poster?.nickName {
      navigationItem.title = nickName + "'s posts"
    } else {
      navigationItem.title = (poster?.firstName)! + "'s posts"
    }
    if let savedPosts = Post.loadPosts() {
      posts = savedPosts
    } else {
      posts = Post.loadSamplePosts()
    }
    posts = posts.filter({
      guard let nickName = $0.poster.nickName else {
        return $0.poster.firstName == self.poster?.firstName
      }
      return nickName == self.poster?.nickName
    })
    
  }


  // The number of cells that are displayed at home screen
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return posts.count
  }
  
  // path the date
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "UserDetailCell", for: indexPath) as! UserDetailCell
    let post = posts[indexPath.row]
    cell.titleLabel.text = post.title
    cell.authorLabel.text = post.author
    cell.post = post
    cell.delegate = self
    
    return cell
  }
  
  /// this function is invoked when you tap the icon located right side of each cell
  /// viewControllerPresent: SFSafariViewController
  func searchOnTheInternet(_ viewControllerToPresent: UIViewController) {
    present(viewControllerToPresent, animated: true, completion: nil)
  }
  
  @IBSegueAction func toEachBook(_ coder: NSCoder, sender: Any?) -> EachBookViewController? {
    let detailController = EachBookViewController(coder: coder)
    guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {
      return detailController
    }
    tableView.deselectRow(at: indexPath, animated: true)
    detailController?.eachBook = posts[indexPath.row]
    return detailController
  }
}
