//
//  SignUpViewController.swift
//  BookDiary
//
//  Created by Hiroki Minami on 2022-12-08.
//

import UIKit

class SignUpViewController: UIViewController {
  
  @IBOutlet var firstNameTextField: UITextField!
  @IBOutlet var lastNameTextField: UITextField!
  @IBOutlet var nicknameTextField: UITextField!
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
  
  @IBAction func textFieldEditingChanged(_ sender: UITextField) {
    updateDoneButtonState()
  }
  
  func updateDoneButtonState() {
    guard let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let nickname = nicknameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, let passwordConfirm = passwordConfirmTextField.text else { doneButton.isEnabled = false
      return
    }
    doneButton.isEnabled = !firstName.isEmpty && !lastName.isEmpty && !nickname.isEmpty && !email.isEmpty && !password.isEmpty && !passwordConfirm.isEmpty
  }
  
  func validate() -> Bool {
    // usercheck
    guard let users = User.loadUsers() else { return validatePassword() }
    
    for user in users {
      if emailTextField.text! == user.email {
        alertTextView.isHidden = false
        alertTextView.text = "There is already a user using the email address."
        return false
      }
    }
    return validatePassword()
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
    
    let newUser = User(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, nickName: nicknameTextField.text!, passWord: passwordTextField.text!, email: emailTextField.text!.lowercased(), userSetting: UserSetting())
    
    if var users = User.loadUsers() {
      users.append(newUser)
      User.saveUsers(users)
    } else {
      User.saveUsers([newUser])
    }
    return true
  }
}
