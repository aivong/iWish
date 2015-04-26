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
    
    var array = [MCOSMTPSendOperation]()

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

    @IBAction func registerAccount(sender: UIButton) {
        if self.validInputs() {
            let query = "INSERT INTO Users (username, password, gender, birthday, fullname, email, mailaddress) VALUES ('\(username.text)', '\(password.text)', '\(gender.text)', '\(birthday.text)', '\(fullname.text)', '\(email.text)', '\(mailingaddress.text)')"
            
            DatabaseConnection.InsertUser(query){ responseObject, error in
                //CHECK FOR ERRORS
                self.userSuccessfullyAdded()
            }

            
        }
    }
    
    private func sendConfirmaton() {
        var smtpSession:MCOSMTPSession = MCOSMTPSession()
        smtpSession.hostname = "smtp.gmail.com";
        smtpSession.port = 465;
        smtpSession.username = "iWishlegit@gmail.com";
        smtpSession.password = "";
        smtpSession.connectionType = MCOConnectionType.TLS;
        
        var builder:MCOMessageBuilder = MCOMessageBuilder();
        builder.header.from = MCOAddress(mailbox: "iWish.legit@gmail.com")
        //builder.header.to = [MCOAddress(mailbox: "auserthatisnotreal@gmail.com")]
        builder.header.to = [MCOAddress(mailbox: email.text)]
        builder.header.subject = "iWish Account Confirmation"
        builder.htmlBody = "<h1>HI " + fullname.text +  " :D :D</h1>" + "<p>username: " +  username.text + "</p>" + "<p>password: " + password.text + "</p>" +
            "<p>╲╲╭━━━━━━━╮╱╱<br>" +
            "╲╭╯╭━╮┈╭━╮╰╮╱<br>" +
            "╲┃┈┃┈▊┈┃┈▊┈┃╱<br>"    +
            "╲┃┈┗━┛┈┗━┛┈┃╱<br>"    +
            "╱┃┈┏━━━━━┓┈┃╲<br>"    +
            "╱┃┈┃┈┈╭━╮┃┈┃╲<br>"    +
            "╱╰╮╰━━┻━┻╯╭╯╲<br>"    +
            "╱╱╰━━━━━━━╯╲╲</p>"    +
            //"</br>"                +
            "<p>╲╲╭━━━━╮╲╲<br>"    +
            "╭╮┃▆┈┈▆┃╭╮<br>"    +
            "┃╰┫▽▽▽▽┣╯┃<br>"    +
            "╰━┫△△△△┣━╯<br>"    +
            "╲╲┃┈┈┈┈┃╲╲<br>"    +
            "╲╲┃┈┏┓┈┃╲╲<br>"    +
        "▔▔╰━╯╰━╯▔▔</p>"
        
        
        let rfc822Data:NSData = builder.data()
        
        array.append(smtpSession.sendOperationWithData(rfc822Data))
        
        array[0].start({ (error:NSError!) -> Void
            in
            println("Sent")
        })
    }
    
    private func userSuccessfullyAdded() {
        self.sendConfirmaton()
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addStyleToView()
    }
    
    
    func addStyleToView() {
        iWishStylingTool.addStyleToSubviewsOfView(self.view)
    }


}
