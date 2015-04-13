//
//  LoginViewController.swift
//  iWish
//
//  Created by Zachary Bohlin on 2/11/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var registerButton: UIView!
    @IBOutlet weak var usernamePasswordView: UIView!
    @IBOutlet weak var logInContainerView: UIView!
    @IBOutlet weak var passwordImage: UIImageView!
    @IBOutlet weak var usernameImage: UIImageView!
    var blurEffect: UIBlurEffect!
    var blurView: UIVisualEffectView!
    let cornerRadius : CGFloat = 10
    var users = [Users]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        logInContainerView.backgroundColor = UIColor.clearColor()
        
        
        logInContainerView.layer.cornerRadius = cornerRadius
        usernamePasswordView.layer.cornerRadius = cornerRadius
        logInButton.layer.cornerRadius = cornerRadius
        logInContainerView.clipsToBounds = true
        
        blurEffect = UIBlurEffect(style: .Light)
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = logInContainerView.bounds
        
        logInContainerView.insertSubview(blurView, atIndex: 0)
    }
    
    
    
    
    @IBAction func logInPushed(sender: UIButton) {
        
        //        let testDataUsers = [Users(username: "bohlin2", password: "pw")]
        //
        //        for user in testDataUsers{
        //
        //            if usernameTextField.text == user.username && passwordTextField.text == user.password{
        //                performSegueWithIdentifier("LoginSegue", sender: self)
        //            }
        //
        //        }
        //
        //performSegueWithIdentifier("LoginSegue", sender: self)
        if self.validInputs() {
                //let query = "SELECT * FROM Users WHERE username = '\(usernameTextField.text)' AND password = '\(passwordTextField.text)')"
                let query = "SELECT * FROM Users WHERE username = '\(usernameTextField.text)'"
                DatabaseConnection.GetUser(query) { responseObject, error in
                    //CHECK FOR ERRORS
                    if responseObject != nil {
                        self.users = responseObject!
                        if(self.users[0].username == self.usernameTextField.text && self.users[0].password == self.passwordTextField.text) {
                            VerifyState.userVerified = true
                            VerifyState.username = self.users[0].username
                            VerifyState.selectedUser = self.users[0].username
                            VerifyState.email = self.users[0].email
                            let nsud = NSUserDefaults.standardUserDefaults()
                            nsud.setObject(self.users[0].username, forKey: "username")
  
                        }
                        if VerifyState.userVerified && VerifyState.username == self.users[0].username {
                            self.performSegueWithIdentifier("loginSuccess", sender: self)
                        }
                    }
                    if self.users.count == 0 {
                        var alertTitle = ""
                        var alertBody = ""
                        alertTitle = "Incorrect Credentials"
                        alertBody = "Please enter the correct username/password combination"
                        self.usernameTextField.text = ""
                        self.passwordTextField.text = ""
                        let alertView = UIAlertView(title: alertTitle, message: alertBody, delegate: nil, cancelButtonTitle: "OK")
                        alertView.show()
                    }
                }
        }
        
    }
    
    private func validInputs() -> Bool {
        var alertTitle = ""
        var alertBody = ""
        if (usernameTextField.text == "" || passwordTextField.text == "") {
            alertTitle = "Empty Fields"
            alertBody = "Please fill in all fields"
        }
        if alertTitle == "" {
            return true
        } else {
            let alertView = UIAlertView(title: alertTitle, message: alertBody, delegate: nil, cancelButtonTitle: "OK")
            alertView.show()
            return false
        }
    }
    
    
    @IBAction func registerPushed(sender: UIView) {
        performSegueWithIdentifier("RegisterSegue", sender: self)
    }
    
    override func viewDidAppear(animated: Bool) {
        //performSegueWithIdentifier("LoginSegue", sender: self)
        usernameTextField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
        DatabaseConnection.GetUserSettings(usernameTextField.text){responseObject, error in
            let nsud = NSUserDefaults.standardUserDefaults()
            nsud.setObject(responseObject?.notifications, forKey: "notificationsAllowed")
            nsud.setObject(responseObject?.allowSystemEmails, forKey: "systemEmailsAllowed")
            nsud.setObject(responseObject?.showEmailAddress, forKey: "showEmailAllowed")
            nsud.setObject(responseObject?.showBirthday, forKey: "showBirthdayAllowed")
            nsud.setObject(responseObject?.allowSearchByUsername, forKey: "searchUsernameAllowed")
        }
    }

    
}
