//
//  HomeTableViewController.swift
//  BookDiary
//
//  Created by 村上匡志 on 2022-12-06.
//

import UIKit

protocol HomeTableViewControllerDelegate {
  func titleButtonTapped(_ sender: Any)
  func userButtonTapped(_ sender: Any)
}

class HomeTableViewController: UITableViewController, HomeTableViewControllerDelegate {
  
  var bookCell = [Post]()
  var tappedPost: Post?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let savedPosts = Post.loadPosts() {
      bookCell = savedPosts
    } else {
      bookCell = Post.loadSamplePosts()
    }
    bookCell = bookCell.filter{ post in
      if let nickName = post.poster.nickName {
        return nickName != User.currentUser?.nickName && post.isComplete
      } else {
        return post.poster.firstName != User.currentUser?.firstName  && post.isComplete
      }
    }
  }
  
  // The number of cells that are displayed at home screen
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return bookCell.count
  }
  
  // path the date
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeBookCellTableViewCell
    let book = bookCell[indexPath.row]
    cell.titleButton?.setTitle("\(book.title)", for: .normal)
    if let nickName = book.poster.nickName {
      cell.userButton?.setTitle("\(nickName)", for: .normal)
    } else {
      cell.userButton?.setTitle("\(book.poster.firstName)", for: .normal)
    }
    cell.post = book
    cell.starRatingView.ratingValue = book.rates ?? 0.0
    cell.starRatingView.changeable = false
    cell.delegate = self
    
    return cell
  }
  
  func titleButtonTapped(_ sender: Any) {
    guard let cell = sender as? HomeBookCellTableViewCell, let indexPath = tableView.indexPath(for: cell) else { return }
    tappedPost = cell.post
    
    tableView.deselectRow(at: indexPath, animated: true)
    performSegue(withIdentifier: "toEachBook", sender: self)
  }
  
  func userButtonTapped(_ sender: Any) {
    guard let cell = sender as? HomeBookCellTableViewCell, let indexPath = tableView.indexPath(for: cell) else { return }
    tappedPost = cell.post
    
    tableView.deselectRow(at: indexPath, animated: true)
    performSegue(withIdentifier: "toUserDetail", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toEachBook" {
      let eachBookView = segue.destination as! EachBookViewController
      eachBookView.eachBook = tappedPost
    } else if segue.identifier == "toUserDetail" {
      let userdetailView = segue.destination as! UserTableViewController
      userdetailView.poster = tappedPost?.poster
    }
  }
}




