//
//  ForgotPasswordViewController.swift
//  BookDiary
//
//  Created by Hiroki Minami on 2022-12-09.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
  
  @IBOutlet var emailTextField: UITextField!
  @IBOutlet var passwordTextField: UITextField!
  @IBOutlet var passwordConfirmTextField: UITextField!
  
  @IBOutlet var doneButton: UIButton!
  
  @IBOutlet var alertTextView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    alertTextView.isHidden = false
    updateDoneButtonState()
  }
  
  func updateDoneButtonState() {
    guard let email = emailTextField.text, let password = passwordTextField.text, let passwordConfirm = passwordConfirmTextField.text else { doneButton.isEnabled = false
      return
    }
    doneButton.isEnabled =  !email.isEmpty && !password.isEmpty && !passwordConfirm.isEmpty
  }
  
  @IBAction func textFieldEditingChanged(_ sender: UITextField) {
    updateDoneButtonState()
  }
  
  func validate() -> Bool {
    // usercheck
    guard let users = User.loadUsers() else { return false }
    
    for user in users {
      if emailTextField.text! == user.email {
        return validatePassword()
      }
    }
    alertTextView.isHidden = false
    alertTextView.text = "There is no user using this email address."
    return false
  }
  
  func validatePassword() -> Bool {
    if passwordTextField.text! == passwordConfirmTextField.text! {
      return true
    } else {
      alertTextView.isHidden = false
      alertTextView.text = "2 passwords are different. Write same password."
      return false
    }
  }
  
  override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    alertTextView.isHidden = true
    guard validate() else { return false }
    
    guard var users = User.loadUsers() else { return false }
    for (index, user) in users.enumerated() {
      if emailTextField.text! == user.email {
        let newUser = User(firstName: user.firstName, lastName: user.lastName, userName: user.nickName ?? "", passWord: passwordTextField.text!, email: emailTextField.text!, userSetting: user.userSetting)
        
        users[index] = newUser
      }
    }
    User.saveUsers(users)
    return true
  }
  
}
