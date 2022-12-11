//
//  GenreListTableViewController.swift
//  BookDiary
//
//  Created by Quien on 2022/12/10.
//

import UIKit

protocol GenreListDelegate {
    func didSelect(genre: Genres)
}

class GenreListTableViewController: UITableViewController {
  
  var delegate: GenreListDelegate?
  var genre: Genres?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return Genres.allCases.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier:
       "genreCell", for: indexPath)
    let genre = Genres.allCases[indexPath.row].rawValue
    cell.textLabel?.text = genre
    if genre == self.genre?.rawValue {
        cell.accessoryType = .checkmark
    } else {
        cell.accessoryType = .none
    }
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    genre = Genres.allCases[indexPath.row]
    delegate?.didSelect(genre: genre!)
    tableView.reloadData()
  }

}
