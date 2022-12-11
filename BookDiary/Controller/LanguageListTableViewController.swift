//
//  LanguageListTableViewController.swift
//  BookDiary
//
//  Created by Quien on 2022/12/10.
//

import UIKit

protocol LanguageListDelegate {
    func didSelect(language: Language)
}

class LanguageListTableViewController: UITableViewController {
  
  var delegate: LanguageListDelegate?
  var language: Language?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("language = \(language)")
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Language.allCases.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier:
       "languageCell", for: indexPath)
    let language = Language.allCases[indexPath.row].rawValue
    cell.textLabel?.text = language
    if language == self.language?.rawValue {
        cell.accessoryType = .checkmark
    } else {
        cell.accessoryType = .none
    }
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    language = Language.allCases[indexPath.row]
    delegate?.didSelect(language: language!)
    tableView.reloadData()
  }
}
