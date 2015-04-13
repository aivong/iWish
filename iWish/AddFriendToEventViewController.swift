//
//  AddFriendToEventViewController.swift
//  iWish
//
//  Created by chutipo2 on 3/15/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import Foundation
import UIKit


class AddFriendToEventViewController: UITableViewController {

    var eventID : Int!
    var usersName: String!
    var friends = [Users]()
    var selectedFriend: Users!
    
    
    func refresh(){
        self.tableView.reloadData()
    }
    
    func alertUser(titleText: String, messageText: String, buttonText: String){
        let alertController = UIAlertController(title: titleText, message: messageText, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }
    
    override func viewDidAppear(animated: Bool) {
        selectedFriend = Users(username: "", password: "", fullname: "", email: "", gender: "", mailingaddress: "", birthday: "")
        refresh()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return friends.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Friends", forIndexPath: indexPath) as! UITableViewCell
        
        let data = friends[indexPath.row]
        cell.textLabel?.text = data.username
        
        return cell
    }
    
    //UPDATE  `cs429iwi_databases`.`WishListGifts` SET  `eventID` =  '5' WHERE  `WishListGifts`.`id` =21;
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedFriend = friends[indexPath.row]
        let query = "INSERT INTO Invites(inviter,invitee,eventID,status) VALUES ('\(usersName)', '\(selectedFriend.username)', \(eventID), 'pending')"
        println(query)
        DatabaseConnection.InviteFriend(query){ responseObject, error in
        //CHECK FOR ERRORS
            if responseObject != nil {
                self.friends.removeAtIndex(indexPath.row)
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }


}
