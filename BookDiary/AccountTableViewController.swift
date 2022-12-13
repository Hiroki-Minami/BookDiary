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
  
  var previousEmail: String?
  var userIndex: Int?
  
  @IBOutlet var saveButton: UIBarButtonItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    firstNameTextField.text = user?.firstName
    lastNameTextField.text = user?.lastName
    nicknameTextField.text = user?.userName
    emailTextField.text = user?.email
    passwordTextField.text = user?.passWord
    passwordConfirmTextField.text = user?.passWord
    
    for (index, savedUser) in User.loadUsers()!.enumerated() {
      if savedUser.email == user?.email {
        previousEmail = user?.email
        self.userIndex = index
      }
    }
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
    if validateUserInfo() {
      user = User(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, userName: nicknameTextField.text!, passWord: passwordTextField.text!, email: emailTextField.text!, userSetting: user!.userSetting)
      
      var users = User.loadUsers()!
      users[userIndex!] = user!
      User.saveUsers(users)
      
      return true
    }
    return false
  }
  
  func validateUserInfo() -> Bool {
    guard let users = User.loadUsers() else { return false }
    
    if previousEmail != emailTextField.text! {
      for eachUser in users {
        if eachUser.email == emailTextField.text! {
          // TODO: show alert message
          let alertController = UIAlertController(title: "This email is already used by someone.", message: nil, preferredStyle: .alert)
          present(alertController, animated: true)
          return false
        }
      }
      return true
    } else {
      return validatePassword()
    }
  }
  
  func validatePassword() -> Bool {
    if passwordTextField.text! == passwordConfirmTextField.text! {
      return true
    } else {
      let alertController = UIAlertController(title: "This email is already used by someone.", message: nil, preferredStyle: .alert)
      present(alertController, animated: true)
      return false
    }
  }
}
