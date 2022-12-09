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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    // TODO: if there is data on local file this step will be skipped and navigate to home
    updateLogInButtonState()
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
    guard let users = User.loadUsers() else { return false }
    for user in users {
      let email = emailTextField.text!
      let password = passwordTextField.text!
      if user.email == email && user.passWord == password {
        self.user = user
        return true
      }
    }
    return false
  }
  
  @IBAction func logInButtonTapped(_ sender: UIButton) {
    guard validateLogIn() else { return }
    
    let mainTabBarController = storyboard!.instantiateViewController(withIdentifier: "MainTabBarController")
    
    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
  }
  
  @IBAction func unwindToLogInViewController(segue: UIStoryboardSegue) {
    guard segue.identifier == "creteAccount" else { return }
    let sourceViewController = segue.source as! SignUpViewController
    
    emailTextField.text = sourceViewController.emailTextField.text
    passwordTextField.text = sourceViewController.passwordTextField.text
    updateLogInButtonState()
  }
}
