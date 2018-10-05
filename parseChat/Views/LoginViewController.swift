//
//  LoginViewController.swift
//  parseChat
//
//  Created by Neil Shah on 9/21/18.
//  Copyright © 2018 Neil Shah. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onClickSignupButton(_ sender: Any) {
        let newUser = PFUser()

        if((userNameTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)!){
            let title = "Need Info"
            let message = "Please enter your desired Username and Password before clicking on Sign Up"
            self.callAlertDismiss(title: title, message: message)
        }
        else {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            newUser.username = userNameTextField.text
            newUser.password = passwordTextField.text
        
            // call sign up function on the object
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if let error = error {
                    print(error.localizedDescription)
                    let title = "Error in Signup"
                    let message = error.localizedDescription
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.callAlertDismiss(title: title, message: message)
                } else {
                    print("User Registered successfully")
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }
            }
        }
    }
    
    @IBAction func onClickLoginButton(_ sender: Any) {
        if((userNameTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)!){
            let title = "Need Info"
            let message = "Please enter your Username and Password before clicking on Login"
            self.callAlertDismiss(title: title, message: message)
        }
        else {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            let username = userNameTextField.text
            let password = passwordTextField.text
            
            PFUser.logInWithUsername(inBackground: username!, password: password!) { (user: PFUser?, error: Error?) in
                if let error = error {
                    print("User log in failed: \(error.localizedDescription)")
                    let title = "User Login Failed"
                    let message = error.localizedDescription
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.callAlertDismiss(title: title, message: message)
                } else {
                    print("User logged in successfully")
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }
            }
        }
    }
    
    func callAlertDismiss(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel) {(action) in}
        alertController.addAction((dismissAction))
        self.present(alertController, animated: true) {
        }
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
