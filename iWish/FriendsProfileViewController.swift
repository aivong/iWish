//
//  FriendsProfileViewController.swift
//  iWish
//
//  Created by Zachary Bohlin on 2/26/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import UIKit

class FriendsProfileViewController: UIViewController {
    
    
    var friendsName: String!
    var usersName: String!
    var friendWasRemoved: Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        if let name = defaults.stringForKey("username")
        {
            usersName = name
        }
        self.title = friendsName
        friendWasRemoved = false
        // Do any additional setup after loading the view.
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