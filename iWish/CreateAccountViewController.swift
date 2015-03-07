//
//  CreateAccountViewController.swift
//  iWish
//
//  Created by Ai Vong on 2/22/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var birthday: UITextField!
    @IBOutlet weak var mailingaddress: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    @IBAction func cancelRegistration(sender: UIButton) {
        performSegueWithIdentifier("LoginSegue2", sender: self)
    }
    
    @IBAction func registerAccount(sender: UIButton) {
        if self.validInputs() {
            let query = "INSERT INTO Users (username, password, gender, birthday, fullname, email, mailaddress) VALUES ('\(username.text)', '\(password.text)', '\(gender.text)', '\(birthday.text)', '\(fullname.text)', '\(email.text)', '\(mailingaddress.text)')"
            
            DatabaseConnection.InsertUser(query){ responseObject, error in
                //CHECK FOR ERRORS
                self.userSuccessfullyAdded()
            }

            
        }
    }
    
    private func userSuccessfullyAdded() {
        //performSegueWithIdentifier("LoginSegue2", sender: self)
        self.navigationController?.popViewControllerAnimated(true)
    }

    private func validInputs() -> Bool {
        var alertTitle = ""
        var alertBody = ""
        
        if (fullname.text == "" || username.text == "" || password.text == "" || email.text == "" || gender.text == "" || birthday.text == "" || mailingaddress.text == "") {
            alertTitle = "Empty Fields"
            alertBody = "Please fill in all fields"
        } else if countElements(birthday.text) != 10 {
            alertTitle = "Invalid Birthday"
            alertBody = "Please enter birthday in the format YYYY-MM-DD"
        } else if countElements(username.text) > 255 {
            alertTitle = "Invalid Username"
            alertBody = "Description must be 255 or fewer characters"
        }
    
        if alertTitle == "" {
            return true
        } else {
            let alertView = UIAlertView(title: alertTitle, message: alertBody, delegate: nil, cancelButtonTitle: "OK")
            alertView.show()
            return false
        }

    }
}
