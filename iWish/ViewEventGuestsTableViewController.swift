//
//  ViewEventGuestsTableViewController.swift
//  iWish
//
//  Created by Aleksey K on 3/14/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import Foundation
import UIKit


    
class ViewEventGuestsTableViewController: UITableViewController {
    
    
    let headerNames = ["Pending", "Confirmed"]
    var selectedGuest : Invite!
    var eventID : Int!
    var guests = [Invite]()
    var invited = [Invite]()
    var friends = [Users]()
    var unInvitedFriends = [Users]()
    var usersName: String!
    
    
    func getEventGuests(){
        DatabaseConnection.GetGuestsForEvent(eventID, status:"confirmed"){ responseObject, error in
            if responseObject != nil {
               self.guests = responseObject!
               self.tableView.reloadData()
            }
            else {
                //DATA NOT RETURNED
            }
            
        }
        println("Event GUEST: \(eventID) ID and \(guests.count) number")
    }
    
    func getPendingGuests(){
        DatabaseConnection.GetGuestsForEvent(eventID, status:"pending"){ responseObject, error in
            if responseObject != nil {
                self.invited = responseObject!
                self.tableView.reloadData()
            }
            else {
                //DATA NOT RETURNED
            }
            
        }
        println("Pending GUEST: \(eventID) ID and \(invited.count) number")
    }
    
    func getUserFriends(){
        DatabaseConnection.GetFriendsForUser(usersName){ responseObject, error in
            if responseObject != nil {
                self.friends = responseObject!
                self.friends.sort({$0.username < $1.username})
                self.tableView.reloadData()
            }
            else {
                //DATA NOT RETURNED
            }
            
        }
        println("FRIENDS: \(friends.count)")
        getPendingGuests()
        getUninvitedFriends()
    }
    
    func getUninvitedFriends(){
        
        var Friend: Users!
        var flag: Bool!
        var tempUninvite = [Users]()
        for i in 0..<self.friends.count{
            let Friend = self.friends[i]
            flag = false
            for j in 0..<self.guests.count{
                println("COMPARING \(self.guests[j].invitee) and \(Friend.username)")
                if self.guests[j].invitee == Friend.username{
                    flag = true
                }
            }
            for k in 0..<self.invited.count{
                println("COMPARING \(self.invited[k].invitee) and \(Friend.username)")
                if self.invited[k].invitee == Friend.username{
                    flag = true
                }
            }
            if flag == false{
                tempUninvite.append(Friend)
            }
        }
        unInvitedFriends = tempUninvite
        println("SIZE OF UNINVITED: \(unInvitedFriends.count)")
    }
    
    func alertUser(titleText: String, messageText: String, buttonText: String){
        let alertController = UIAlertController(title: titleText, message: messageText, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        println("ENTER VIEW DID LOAD")
        super.viewDidLoad()
        getEventGuests()
        getUserFriends()
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        println("ENTER VIEW DID APPEAR")
        selectedGuest = Invite(inviter: "", invitee: "", eventID: 0, status: "")
        getEventGuests()
        getUserFriends()
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if section == 0{
            return invited.count
        }
        else{
            return guests.count
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCellWithIdentifier("Pending", forIndexPath:indexPath) as! UITableViewCell
            cell.textLabel?.text = invited[indexPath.row].invitee
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCellWithIdentifier("Confirmed", forIndexPath:indexPath) as! UITableViewCell
            cell.textLabel?.text = guests[indexPath.row].invitee
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerNames[section]
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if(segue.destinationViewController.isKindOfClass(AddFriendToEventViewController)){
            
            let vc = segue.destinationViewController as! AddFriendToEventViewController
            
            vc.eventID = eventID
            vc.usersName = usersName
            vc.friends = unInvitedFriends
            
        }
    }
    
    
}
