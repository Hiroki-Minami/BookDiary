//
//  SearchTableViewController.swift
//  BookDiary
//
//  Created by Hiroki Minami on 2022-12-06.
//

import UIKit

class SearchTableViewController: UITableViewController, searchTableViewCellDelegate, UISearchBarDelegate, UISearchDisplayDelegate {

  var allPosts: [Post] = []
  var shownPosts: [Post] = []
  
  // filters
  var genreIsShown: [Genres: Bool] = [:]
  var completionIsShown: [Completion: Bool] = [:]
  var rateFilter = 0
  
  @IBOutlet weak var searchBar: UISearchBar!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    searchBar.delegate = self
    // getting default filter setting
    for genre in Genres.allCases {
      genreIsShown[genre] = true
    }
    for completion in Completion.allCases {
      completionIsShown[completion] = true
    }
    allPosts = Post.loadSamplePosts()
    updateUI()
    setEndEditing()
  }
  
  func updateUI() {
    filteringBooks()
    tableView.reloadData()
  }
  
  func filteringBooks() {
    shownPosts = allPosts.filter({
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
      if let nickName = $0.poster.nickName {
        return $0.title.lowercased().contains(searchBar.text!.lowercased()) || nickName.lowercased().contains(searchBar.text!.lowercased())
      }
      return $0.title.lowercased().contains(searchBar.text!.lowercased()) || $0.poster.firstName.lowercased().contains(searchBar.text!.lowercased())
    })
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    updateUI()
  }
  
  @IBAction func unwindToSearchTableView(segue: UIStoryboardSegue) {
    guard segue.identifier == "saveFilter" else { return }
    let sourceViewController = segue.source as! SearchFilterViewController
    
    self.genreIsShown = sourceViewController.genreIsShown
    self.completionIsShown = sourceViewController.completionIsShown
    rateFilter = Int(round(sourceViewController.rate))
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
    let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchTableViewCell
    cell.delegate = self
    cell.post = shownPosts[indexPath.row]
    cell.titleButton.setTitle(shownPosts[indexPath.row].title, for: .normal)
    if let nickName = shownPosts[indexPath.row].poster.nickName {
      cell.userButton.setTitle(nickName, for: .normal)
    } else {
      cell.userButton.setTitle(shownPosts[indexPath.row].poster.firstName, for: .normal)
    }
    return cell
  }
  
  func titleButtonTapped(_ sender: Any) {
    performSegue(withIdentifier: "searchToEachbook", sender: sender)
  }
  
  func userButtonTapped(_ sender: Any) {
    performSegue(withIdentifier: "searchToUserDetail", sender: sender)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let post = sender as? Post else { return }
    if segue.identifier == "searchToEachbook" {
      let eachBookView = segue.destination as! EachBookViewController
      eachBookView.eachBook = post
    } else if segue.identifier == "searchToUserDetail" {
      let userdetailView = segue.destination as! UserTableViewController
      userdetailView.poster = post.poster
    }
  }
  
  @IBSegueAction func goToSearchFilterViewController(_ coder: NSCoder) -> SearchFilterViewController? {
    let sfvc = SearchFilterViewController(coder: coder)
    sfvc?.genreIsShown = genreIsShown
    sfvc?.completionIsShown = completionIsShown
    sfvc?.rate = Float(rateFilter)
    sfvc?.sourceController = self
    return sfvc
  }
  
}
