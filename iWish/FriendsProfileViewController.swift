//
//  FriendsProfileViewController.swift
//  iWish
//
//  Created by Zachary Bohlin on 2/26/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import UIKit

class FriendsProfileViewController: UIViewController {
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var mailingAddress: UILabel!
    
    var friendsName: String!
    var usersName: String!
    var friendWasRemoved: Bool!
    var profileImage: UIImage!
    var users = [Users]()
    var file: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        if let name = defaults.stringForKey("username")
        {
            usersName = name
        }
        self.title = friendsName
        VerifyState.selectedUser = friendsName
        friendWasRemoved = false
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        
        
        let queryProfile = "SELECT * FROM Users WHERE username = '\(friendsName)'"
        
        
        DatabaseConnection.GetUserSettings(friendsName){ro, er in
            let us = ro!


            DatabaseConnection.GetUser(queryProfile) { responseObject, error in
                //CHECK FOR ERRORS
                if responseObject != nil {
                    println("SEA: \(us.showEmailAddress.boolValue)")
                    println("SB: \(us.showBirthday.boolValue)")
                    self.users = responseObject!
                    self.fullName.text = self.users[0].fullname
                    
                    if us.showBirthday.boolValue{
                        self.birthday.text = self.users[0].birthday
                    }
                    else{
                        self.birthday.text = "PRIVATE"
                    }
                    self.gender.text = self.users[0].gender
                    if us.showEmailAddress.boolValue{
                        self.email.text = self.users[0].email
                    }
                    else{
                        self.email.text = "PRIVATE"
                    }
                    self.mailingAddress.text = self.users[0].mailingaddress
                    
                }
            }
        }
        let queryImage = "SELECT * FROM pictures WHERE username = '\(VerifyState.selectedUser)'"
        
        DatabaseConnection.GetImage(queryImage) { responseObject, error in
            //CHECK FOR ERRORS
            if responseObject != nil {
                
                let profileImage : UIImage = UIImage(named: "/Users/aivong/Desktop/iWishimage/" + VerifyState.selectedPic)!
                let imageview = UIImageView(image: profileImage)
                imageview.frame = CGRectMake(31, 26, 172, 191)
                self.view.addSubview(imageview)
                
                self.file = responseObject!
            }
        }

        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addStyleToView()
    }
    
    
    func addStyleToView() {
        iWishStylingTool.addStyleToSubviewsOfView(self.view)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alertUser(titleText: String, messageText: String, buttonText: String){
        let alertController = UIAlertController(title: titleText, message: messageText, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func friendsProfileOptionsClicked(sender: AnyObject) {
        let friendOptionsMenu = UIAlertController(title: nil, message: "Options for \"\(self.friendsName)\"", preferredStyle: .ActionSheet)
        
        let removeFriendActionHandler = { (action:UIAlertAction!) -> Void in
            DatabaseConnection.RemoveFriend(self.usersName, friendBeingRemoved: self.friendsName){ responseObject, error in
                self.friendWasRemoved = true
                self.performSegueWithIdentifier("FriendsProfileUnwind", sender: self)
            }
        }
        
        let sendMessageActionHandler = {(action:UIAlertAction!) -> Void in
            self.alertUser("Not Implemented", messageText: "This function not implemented yet, if ever", buttonText: "Fine")
        }
        
        let sendMessageAction = UIAlertAction(title: "Send Message", style: UIAlertActionStyle.Default, handler: sendMessageActionHandler)
        
        let removeFriendAction = UIAlertAction(title: "Remove Friend", style: UIAlertActionStyle.Default, handler: removeFriendActionHandler)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
        friendOptionsMenu.addAction(sendMessageAction)
        friendOptionsMenu.addAction(removeFriendAction)
        friendOptionsMenu.addAction(cancelAction)
        
        
        self.presentViewController(friendOptionsMenu, animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }
    
    
}