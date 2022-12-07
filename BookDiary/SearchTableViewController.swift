//
//  SearchTableViewController.swift
//  BookDiary
//
//  Created by Hiroki Minami on 2022-12-06.
//

import UIKit

class SearchTableViewController: UITableViewController, searchTableViewCellDelegate {
  
  var books: [Book] = []
  var filters = Settings.filters~~
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem
    // TODO: getting default filter setting
    // TODO: getting book with filter and assign them into book
    
    updateUI()
  }
  
  func updateUI() {
    
  }
  
  func filteringBooks() {
    
  }
  
  @IBAction func unwindToSearchTableView(segue: UIStoryboardSegue) {
    guard segue.identifier == "saveFilter" else { return }
    let sourceViewController = segue.source as! SearchFilterViewController
    
    filters = sourceViewController.genreChecked
    updateUI()
  }
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    // TODO: counting the number of array after filtering something
    return books.count
  }
  
  func searchOnTheInternet(_ viewControllerToPresent: UIViewController) {
    present(viewControllerToPresent, animated: true, completion: nil)
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableViewCell
    cell.delegate = self
    cell.book = books[indexPath.row]
    
    // TODO: need to be fixed
    cell.titleButton.setTitle(books[indexPath.row].title, for: .normal)
    cell.userButton.setTitle(books[indexPath.row].title, for: .normal)
    // Configure the cell...
    
    return cell
  }
  
  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
  
  /*
   // Override to support editing the table view.
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
   if editingStyle == .delete {
   // Delete the row from the data source
   tableView.deleteRows(at: [indexPath], with: .fade)
   } else if editingStyle == .insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }
   }
   */
  
  /*
   // Override to support rearranging the table view.
   override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
   
   }
   */
  
  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
