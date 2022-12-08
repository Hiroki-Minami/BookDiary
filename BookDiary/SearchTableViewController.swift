//
//  SearchTableViewController.swift
//  BookDiary
//
//  Created by Hiroki Minami on 2022-12-06.
//

import UIKit

class SearchTableViewController: UITableViewController, searchTableViewCellDelegate {
  
  var allPosts: [Post] = []
  var shownPosts: [Post] = []
  
  // filters
  var genreIsShown: [Genres: Bool] = [:]
  var completionIsShown: [Completion: Bool] = [:]
  var rateFilter = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // getting default filter setting
    for genre in Genres.allCases {
      genreIsShown[genre] = true
    }
    for completion in Completion.allCases {
      completionIsShown[completion] = true
    }
    allPosts = Post.loadSamplePosts()
    updateUI()
  }
  
  func updateUI() {
    filteringBooks()
    tableView.reloadData()
  }
  
  func filteringBooks() {
    shownPosts = allPosts.filter({
      let genres = genreIsShown.filter { $1 == true }
      let isDone = $0.isComplete
      let flg = isDone ? completionIsShown[.complete]: completionIsShown[.incomplete]
      
      return genres.keys.contains($0.genres!) && flg! && $0.rates! > Float(rateFilter)
    })
  }
  
  @IBAction func unwindToSearchTableView(segue: UIStoryboardSegue) {
    guard segue.identifier == "saveFilter" else { return }
    let sourceViewController = segue.source as! SearchFilterViewController
    
    self.genreIsShown = sourceViewController.genreIsShown
    self.completionIsShown = sourceViewController.completionIsShown
    rateFilter = Int(round(sourceViewController.rateSlider.value))
    updateUI()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return shownPosts.count
  }
  
  /// this function is invoked when you tap the icon located right side of each cell
  /// viewControllerPresent: SFSafariViewController
  func searchOnTheInternet(_ viewControllerToPresent: UIViewController) {
    present(viewControllerToPresent, animated: true, completion: nil)
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableViewCell
    cell.delegate = self
    cell.post = shownPosts[indexPath.row]
    cell.titleButton.setTitle(shownPosts[indexPath.row].title, for: .normal)
    cell.userButton.setTitle(shownPosts[indexPath.row].title, for: .normal)
    
    return cell
  }
}
