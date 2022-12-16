//
//  MyShelfTableViewController.swift
//  BookDiary
//
//  Created by Quien on 2022/12/7.
//

import UIKit

class MyShelfTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate, MyShelfCellDelegate, RatingAlertViewControllerDelegate {
  
  var posts = [Post]()
  var shownPosts = [Post]()
  var otherPosts = [Post]()
  var ratingView: Float?
  
  // filters
  var genreIsShown: [Genres: Bool] = [:]
  var completionIsShown: [Completion: Bool] = [:]
  var rateFilter = 0
  
  @IBOutlet var searchBar: UISearchBar!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    searchBar.delegate = self
    navigationItem.leftBarButtonItem = editButtonItem
    if let savedPosts = Post.loadPosts() {
      posts = savedPosts
    } else {
      posts = Post.loadSamplePosts()
      Post.savePosts(posts)
    }
    otherPosts = posts.filter{ post in
      if let nickName = post.poster.nickName {
        return nickName != User.currentUser?.nickName
      } else {
        return post.poster.firstName != User.currentUser?.firstName
      }
    }
    posts = posts.filter{ post in
      if let nickName = post.poster.nickName {
        return nickName == User.currentUser?.nickName
      } else {
        return post.poster.firstName == User.currentUser?.firstName
      }
    }
    for genre in Genres.allCases {
      genreIsShown[genre] = true
    }
    for completion in Completion.allCases {
      completionIsShown[completion] = true
    }
    updateUI()
    setEndEditing()
  }
  
  @IBSegueAction func editPost(_ coder: NSCoder, sender: Any?) -> MyShelfDetailTableViewController? {
    let detailController = MyShelfDetailTableViewController(coder: coder)
    guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {
      return detailController
    }
    tableView.deselectRow(at: indexPath, animated: true)
    detailController?.post = shownPosts[indexPath.row]
    return detailController
  }
  
  func updateUI() {
    filteringBooks()
    tableView.reloadData()
  }
  
  func filteringBooks() {
    shownPosts = posts.filter({
      let genres = genreIsShown.filter { $1 == true }
      let isDone = $0.isComplete
      let flg = isDone ? completionIsShown[.complete]!: completionIsShown[.incomplete]!
      let postsGenre = $0.genres
      
      if let postsRate = $0.rates {
        return genres.keys.contains(postsGenre) && flg && postsRate >= Float(rateFilter)
      } else {
        return genres.keys.contains(postsGenre) && flg
      }
    })
    
    shownPosts = shownPosts.filter({
      guard !searchBar.text!.isEmpty else {
        return true
      }
      return $0.title.lowercased().contains(searchBar.text!.lowercased()) || $0.author.lowercased().contains(searchBar.text!.lowercased())
    })
  }
  
  @IBSegueAction func toSearchFilter(_ coder: NSCoder, sender: Any?) -> SearchFilterViewController? {
    let sfvc = SearchFilterViewController(coder: coder)
    sfvc?.genreIsShown = genreIsShown
    sfvc?.completionIsShown = completionIsShown
    sfvc?.rate = Float(rateFilter)
    sfvc?.sourceController = self
    return sfvc
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    updateUI()
  }
  
  @IBAction func unwindToMyShelfFromSearchFilter(segue: UIStoryboardSegue) {
    guard segue.identifier == "saveFilterToMyShelf", let sourceViewController = segue.source as? SearchFilterViewController else { return }
    
    self.genreIsShown = sourceViewController.genreIsShown
    self.completionIsShown = sourceViewController.completionIsShown
    rateFilter = Int(round(sourceViewController.rate))
    updateUI()
  }
  
  @IBAction func unwindToMyShelfCanceledFilter(segue: UIStoryboardSegue) {
  }
  
  @IBAction func unwindToPost(segue: UIStoryboardSegue) {
    guard segue.identifier == "saveUnwind" else { return }
    let sourceViewContoller = segue.source as! MyShelfDetailTableViewController
    
    if let post = sourceViewContoller.post {
      if let indexOfExistingTodo = shownPosts.firstIndex(of: post) {
        shownPosts[indexOfExistingTodo] = post
        tableView.reloadRows(at: [IndexPath(row: indexOfExistingTodo, section: 0)], with: .automatic)
        if let indexOfExistingTodoWholePosts = self.posts.firstIndex(of: post) {
          self.posts[indexOfExistingTodoWholePosts] = post
        }
      } else {
        let newIndexPath = IndexPath(row: shownPosts.count, section: 0)
        posts.append(post)
        shownPosts.append(post)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
        tableView.reloadData()
      }
    }
    Post.savePosts(posts+otherPosts)
  }
  
  // MARK: -
  func webSearchButtonTapped(sender: MyShelfTableViewCell) {
    if let indexPath = tableView.indexPath(for: sender) {
      let post = shownPosts[indexPath.row]
      let url = (User.currentUser?.userSetting.browser.rawValue)! + post.title.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
      if let url = URL(string: url) {
        UIApplication.shared.open(url)
      }
    }
  }
  
  func checkmarkTapped(sender: MyShelfTableViewCell) {
    if let indexPath = tableView.indexPath(for: sender) {
      var post = shownPosts[indexPath.row]
      post.isComplete.toggle()
      shownPosts[indexPath.row] = post
      tableView.reloadRows(at: [indexPath], with: .automatic)
      if let indexOfExistingTodo = self.posts.firstIndex(of: post) {
        self.posts[indexOfExistingTodo] = post
      }
      Post.savePosts(posts+otherPosts)
      if post.isComplete {
        showAlertController(indexPath: indexPath)
      }
    }
  }
  
  func showAlertController(indexPath: IndexPath) {
    var post = shownPosts[indexPath.row]
    
    let alertView = UIAlertController(title: "Rate The Book", message: "Tap the star to rate it.", preferredStyle: .alert )
    alertView.setViewController(title: "Rate The Book", message: "Tap the star to rate it.", ratingValue: post.rates!, delegate: self)
    alertView.addAlertAction(title: "Cancel") { (_) in
      post.isComplete.toggle()
      self.shownPosts[indexPath.row] = post
      self.tableView.reloadRows(at: [indexPath], with: .automatic)
      if let indexOfExistingTodo = self.posts.firstIndex(of: post) {
        self.posts[indexOfExistingTodo] = post
      }
      Post.savePosts(self.posts+self.otherPosts)
    }
    alertView.addAlertAction(title: "Done") { (_) in
      post.rates = self.ratingView
      self.shownPosts[indexPath.row] = post
      self.tableView.reloadRows(at: [indexPath], with: .automatic)
      if let indexOfExistingTodo = self.posts.firstIndex(of: post) {
        self.posts[indexOfExistingTodo] = post
      }
      Post.savePosts(self.posts+self.otherPosts)
    }
    present(alertView, animated: true, completion: nil)
  }
  
  func updateRatingFormatValue(_ value: Float) {
    ratingView = value
  }
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return shownPosts.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! MyShelfTableViewCell
    let post = shownPosts[indexPath.row]
    cell.dekegate = self
    cell.isCompleteButton.isSelected = post.isComplete
    cell.titleLabel.text = post.title
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let deletedPost = shownPosts.remove(at: indexPath.row)
      if let indexOfExistingTodo = posts.firstIndex(of: deletedPost) {
        posts.remove(at: indexOfExistingTodo)
      }
      tableView.deleteRows(at: [indexPath], with: .automatic)
      Post.savePosts(posts+otherPosts)
    }
  }
}
