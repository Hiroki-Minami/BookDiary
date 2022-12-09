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
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
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
        return false
      }
    }
    return validatePassword()
  }
  
  func validatePassword() -> Bool {
    return passwordTextField.text! == passwordConfirmTextField.text!
  }
  
  @IBAction func doneButtonTapped(_ sender: UIButton) {
    guard validate() else { return }
    
    let newUser = User(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, userName: nicknameTextField.text!, passWord: passwordTextField.text!, email: emailTextField.text!, userSetting: UserSetting())
    
    if var users = User.loadUsers() {
      users.append(newUser)
      User.saveUsers(users)
    } else {
      User.saveUsers([newUser])
    }
  }
}
