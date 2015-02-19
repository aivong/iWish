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
    
    @IBAction func loginAction(sender: AnyObject) {
        
        let testDataUsers = [Users(username: "bohlin2", password: "pw")]
        
        for user in testDataUsers{
            
            if usernameTextField.text == user.username && passwordTextField.text == user.password{
                performSegueWithIdentifier("LoginSegue", sender: self)
            }
            
        }
        usernameTextField.text = ""
        passwordTextField.text = ""
        
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        performSegueWithIdentifier("LoginSegue", sender: self)
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
