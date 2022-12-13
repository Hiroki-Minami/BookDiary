//
//  HomeTableViewController.swift
//  BookDiary
//
//  Created by 村上匡志 on 2022-12-06.
//

import UIKit

protocol HomeTableViewControllerDelegate {
  func titleButtonTapped(_ sender: Any) 
}

class HomeTableViewController: UITableViewController, HomeTableViewControllerDelegate {
  
  var bookCell = [Post]()
  var tappedPost: Post?
  var tappedCellIndexPath: IndexPath?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let savedBooks = Post.loadPosts() {
      bookCell = savedBooks
    } else {
      bookCell = Post.loadSamplePosts()
    }
    
  }

  // The number of cells that are displayed at home screen
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return bookCell.count
  }

  // path the date 
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCellIdentifier", for: indexPath) as! HomeBookCellTableViewCell
    let book = bookCell[indexPath.row]
    cell.titleButton?.setTitle("\(book.title)", for: .normal)
    cell.userButton?.setTitle("\(book.poster)", for: .normal)
    cell.post = book
    cell.delegate = self
    
    return cell
  }
  
  
  @IBSegueAction func eachBookDetail(_ coder: NSCoder, sender: Any?) -> EachBookViewController? {
    let detailcontroller = EachBookViewController(coder: coder)
    detailcontroller!.eachBook = tappedPost
    // guard let cell = sender as? HomeBookCellTableViewCell, let indexPath = tableView.indexPath(for: cell) else {
    //   return detailcontroller
    // }
    tableView.deselectRow(at: tappedCellIndexPath!, animated: true)
    detailcontroller?.eachBook = tappedPost
    // detailcontroller?.eachBook = bookCell[indexPath.row]
    return detailcontroller
  }

  func titleButtonTapped(_ sender: Any) {
    guard let cell = sender as? HomeBookCellTableViewCell, let indexPath = tableView.indexPath(for: cell) else { return }
    tappedPost = cell.post
    tappedCellIndexPath = indexPath
  }
  
//  func titleButtonTapped(sender: HomeBookCellTableViewCell) {
//    print(#function)
//    if let indexPath = tableView.indexPath(for: sender) {
//      var book = bookCell[indexPath.row]
//      bookCell[indexPath.row] = book
//      tableView.reloadRows(at: [indexPath], with: .automatic)
//    }
//  }
  
//  @IBAction func toEachBook(segue: UIStoryboardSegue) {
//    guard segue.identifier == "toEachBook" else {return}
//    let souceViewCntroller = segue.source as! EachBookViewController
//  }
//
//  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if segue.identifier == "toEachBook" {
//      if let indexPath = tableView.indexPathForSelectedRow {
//        guard let destination = segue.destination as? EachBookViewController else {return}
//        destination.eachBook = bookCell[indexPath.row]
//      }
//
//    }
//  }
//
}




