//
//  LogInViewController.swift
//  BookDiary
//
//  Created by Hiroki Minami on 2022-12-08.
//

import UIKit

class LogInViewController: UIViewController {
  
  var user: User?
  
  @IBOutlet var emailTextField: UITextField!
  @IBOutlet var passwordTextField: UITextField!
  
  @IBOutlet var logInButton: UIButton!
  
  @IBOutlet var alertTextView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    // TODO: if there is data on local file this step will be skipped and navigate to home
    updateLogInButtonState()
    alertTextView.isHidden = false
  }
  
  func updateLogInButtonState() {
    guard let email = emailTextField.text, let password = passwordTextField.text else { logInButton.isEnabled = false
      return
    }
    logInButton.isEnabled = !email.isEmpty && !password.isEmpty
  }
  
  @IBAction func textFieldEditingChanged(_ sender: UITextField) {
    updateLogInButtonState()
  }
  
  /// this function is invoked when you tapped login button and are about to go to home view controller
  /// if the user data can't be find in the file loging in is failed
  func validateLogIn() -> Bool {
    guard let users = User.loadUsers() else {
      alertTextView.isHidden = false
      alertTextView.text = "Create your account at first."
      return false }
    for user in users {
      let email = emailTextField.text!
      let password = passwordTextField.text!
      if user.email == email && user.passWord == password {
        self.user = user
        return true
      }
    }
    alertTextView.isHidden = false
    alertTextView.text = "Email or password was wrong."
    return false
  }
  
  @IBAction func logInButtonTapped(_ sender: UIButton) {
    alertTextView.isHidden = true
    guard validateLogIn() else { return }
    
    let mainTabBarController = storyboard!.instantiateViewController(withIdentifier: "MainTabBarController")
    User.currentUser = user
    
    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
  }
  
  @IBAction func unwindToLogInViewController(segue: UIStoryboardSegue) {
    guard segue.identifier == "createAccount" || segue.identifier == "forgotPassword" else { return }
    if let sourceViewController = segue.source as? SignUpViewController {
      emailTextField.text = sourceViewController.emailTextField.text
      passwordTextField.text = sourceViewController.passwordTextField.text
    } else {
      let sourceViewController = segue.source as! ForgotPasswordViewController
      emailTextField.text = sourceViewController.emailTextField.text
      passwordTextField.text = sourceViewController.passwordTextField.text
    }
    updateLogInButtonState()
  }
}
