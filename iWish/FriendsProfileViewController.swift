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
    @IBOutlet weak var imageview: UIImageView!
    var file: String!
    var profileImage: UIImage!
    var users =  [Users]()
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
        
        let queryImage = "SELECT * FROM pictures WHERE username = '\(self.friendsName)'"
        // Do any additional setup after loading the view.
        
        
        let queryProfile = "SELECT * FROM Users WHERE username = '\(self.friendsName)'"
        
        
        
        DatabaseConnection.GetUser(queryProfile) { responseObject, error in
            //CHECK FOR ERRORS
            if responseObject != nil {
                self.users = responseObject!
                self.fullName.text = self.users[0].fullname
                self.birthday.text = self.users[0].birthday
                self.gender.text = self.users[0].gender
                self.email.text = self.users[0].email
                self.mailingAddress.text = self.users[0].mailingaddress
                
            }
        }
        
        println(queryImage)
        DatabaseConnection.GetImage(queryImage) { responseObject, error in
            //CHECK FOR ERRORS
            if responseObject != nil {
                
                let profileImage : UIImage = UIImage(named: "/Users/aivong/Desktop/iWishimage/" + VerifyState.selectedPic)!
                let imageview = UIImageView(image: profileImage)
                imageview.frame = CGRectMake(75, 77, 245, 191)
                self.view.addSubview(imageview)
                
                self.file = responseObject!
            }
        }
        
        
        
        
        
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
    
    @IBAction func friendOptionsClicked(sender: AnyObject) {
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
        // Get the new view controller using segue.destinationViewController.
        /*let vc = segue.destinationViewController
        if vc.isKindOfClass(FriendsTableViewController){
            let ftvc = vc as FriendsTableViewController
            if (self.friendWasRemoved != nil){
                let nu = Users(username: friendsName, password: "")
                var index = -1
                for i in 0..<ftvc.friends.count{
                    if(ftvc.friends[i].username == friendsName){
                        index = i
                    }
                }
                if index >= 0{
                    ftvc.friends.removeAtIndex(index)
                }
            }
        }*/
    }
    

}
