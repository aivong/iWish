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
    
    
    
    
    @IBAction func logInPushed(sender: AnyObject) {
        
        let testDataUsers = [Users(username: "bohlin2", password: "pw")]
        
        for user in testDataUsers{
            
            if usernameTextField.text == user.username && passwordTextField.text == user.password{
                performSegueWithIdentifier("LoginSegue", sender: self)
            }
            
        }
        
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func registerPushed(sender: AnyObject) {
        
        let alert = UIAlertView(title: "Not Implemented", message: "Registration is not yet implemented", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }
    
    override func viewDidAppear(animated: Bool) {
        performSegueWithIdentifier("LoginSegue", sender: self)
        usernameTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
