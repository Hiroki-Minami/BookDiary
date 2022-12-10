//
//  AccountTableViewController.swift
//  BookDiary
//
//  Created by Hiroki Minami on 2022-12-09.
//

import UIKit

class AccountTableViewController: UITableViewController {
  
  var user: User?

  @IBOutlet var firstNameTextField: UITextField!
  @IBOutlet var lastNameTextField: UITextField!
  @IBOutlet var nicknameTextField: UITextField!
  @IBOutlet var emailTextField: UITextField!
  @IBOutlet var passwordTextField: UITextField!
  @IBOutlet var passwordConfirmTextField: UITextField!
  
  @IBOutlet var saveButton: UIBarButtonItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    firstNameTextField.text = user?.firstName
    lastNameTextField.text = user?.lastName
    nicknameTextField.text = user?.userName
    emailTextField.text = user?.email
    passwordTextField.text = user?.passWord
    passwordConfirmTextField.text = user?.passWord
  }
  
  func changeSaveButtonStatus() {
    guard let _ = firstNameTextField.text, let _ = lastNameTextField.text, let _ = nicknameTextField.text, let _ = emailTextField.text, let _ = passwordTextField.text, let _ = passwordConfirmTextField.text else {
      saveButton.isEnabled = false
      return
    }
  }
  
  @IBAction func textFieldEditingChanged(_ sender: UITextField) {
    changeSaveButtonStatus()
  }
  
  override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    return validateUserInfo()
  }
  
  func validateUserInfo() -> Bool {
    guard let users = User.loadUsers() else { return false }
    
    for eachUser in users {
      
    }
    return false
  }
  
  func validatePassword() -> Bool {
    return passwordTextField.text! == passwordConfirmTextField.text!
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
