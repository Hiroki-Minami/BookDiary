//
//  MyShelfTableViewController.swift
//  BookDiary
//
//  Created by Quien on 2022/12/7.
//

import UIKit

class MyShelfTableViewController: UITableViewController, MyShelfCellDelegate {
    
  var posts = [Post]()
  var otherPosts = [Post]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.leftBarButtonItem = editButtonItem

    if let savedPosts = Post.loadPosts() {
      posts = savedPosts
    } else {
      posts = Post.loadSamplePosts()
      Post.savePosts(posts)
    }
    otherPosts = posts.filter{ post in post.poster.nickName != "Quien" }
    posts = posts.filter{ post in post.poster.nickName == "Quien" }
  }
  
  @IBSegueAction func editPost(_ coder: NSCoder, sender: Any?) -> MyShelfDetailTableViewController? {
    let detailController = MyShelfDetailTableViewController(coder: coder)
    guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {
      return detailController
    }
    tableView.deselectRow(at: indexPath, animated: true)
    detailController?.post = posts[indexPath.row]
    return detailController
  }
  
  
  @IBAction func unwindToPost(segue: UIStoryboardSegue) {
    guard segue.identifier == "saveUnwind" else { return }
    let sourceViewContoller = segue.source as! MyShelfDetailTableViewController
    
    if let post = sourceViewContoller.post {
      if let indexOfExistingTodo = posts.firstIndex(of: post) {
        posts[indexOfExistingTodo] = post
        tableView.reloadRows(at: [IndexPath(row: indexOfExistingTodo, section: 0)], with: .automatic)
      } else {
        let newIndexPath = IndexPath(row: posts.count, section: 0)
        posts.append(post)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
      }
    }
    Post.savePosts(posts+otherPosts)
    print(posts.count)
    print(otherPosts.count)
  }
  
  // MARK: -
  func webSearchButtonTapped(sender: MyShelfTableViewCell) {
    if let indexPath = tableView.indexPath(for: sender) {
      let post = posts[indexPath.row]
      let url = Setting.browser.rawValue + post.title
      if let url = URL(string: url) {
        UIApplication.shared.open(url)
      }
    }
  }
  
  func checkmarkTapped(sender: MyShelfTableViewCell) {
    if let indexPath = tableView.indexPath(for: sender) {
      var post = posts[indexPath.row]
      post.isComplete.toggle()
      if post.isComplete {
        post.rates = ratingBookAlert()
      }
      posts[indexPath.row] = post
      tableView.reloadRows(at: [indexPath], with: .automatic)
      Post.savePosts(posts+otherPosts)
    }
  }
  
  func ratingBookAlert () -> Float {
    let alertController = UIAlertController(title: "Rate The Book", message: "Tap the star to rate it.", preferredStyle: .alert)
    
    let starRatingViewContainer = UIView()
    let starRatingView = StarRatingView()
    starRatingViewContainer.addSubview(starRatingView)
    alertController.view.addSubview(starRatingViewContainer)
    
    alertController.view.translatesAutoresizingMaskIntoConstraints = false
    alertController.view.heightAnchor.constraint(equalToConstant: 200).isActive = true
    
    starRatingViewContainer.translatesAutoresizingMaskIntoConstraints = false
    starRatingViewContainer.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 40).isActive = true
    starRatingViewContainer.rightAnchor.constraint(equalTo: alertController.view.rightAnchor, constant: -15).isActive = true
    starRatingViewContainer.leftAnchor.constraint(equalTo: alertController.view.leftAnchor, constant: 15).isActive = true
    starRatingViewContainer.bottomAnchor.constraint(equalTo: alertController.view.bottomAnchor, constant: -40).isActive = true
    
    starRatingView.translatesAutoresizingMaskIntoConstraints = false
    starRatingView.topAnchor.constraint(equalTo: starRatingViewContainer.topAnchor, constant: 0).isActive = true
    starRatingView.rightAnchor.constraint(equalTo: starRatingViewContainer.rightAnchor, constant: 0).isActive = true
    starRatingView.leftAnchor.constraint(equalTo: starRatingViewContainer.leftAnchor, constant: 0).isActive = true
    starRatingView.bottomAnchor.constraint(equalTo: starRatingViewContainer.bottomAnchor, constant: 0).isActive = true
    
    let okAction = UIAlertAction(title: "Done", style: .default) { [unowned alertController] _ in
//      let phone = alertController.textFields?[0].text
//      print(phone)
    }
    alertController.addAction(okAction)
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alertController.addAction(cancelAction)
    present(alertController, animated: true)
    return 3.0
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
      Post.savePosts(posts+otherPosts)
    }
  }
}