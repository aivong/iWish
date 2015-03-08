//
//  FriendsTableViewController.swift
//  iWish
//
//  Created by Zachary Bohlin on 2/26/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    let headerNames = ["Friend Requests", "Friends"]
    var requests = [Users]()
    var friends = [Users]()
    var usersName: String!
    
    @IBAction func unwindFromProfile(segue: UIStoryboardSegue){
        let svc = segue.sourceViewController as FriendsProfileViewController
        for i in 0..<friends.count{
            if(friends[i].username == svc.friendsName && svc.friendWasRemoved){
                friends.removeAtIndex(i)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let name = defaults.stringForKey("username")
        {
            usersName = name
        }
        println(usersName)
        
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
        DatabaseConnection.GetFriendRequestsForUser(usersName){responseObject, error in
            
            if responseObject != nil {
                self.requests = responseObject!
                self.tableView.reloadData()
            }
            
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
            return requests.count
        }
        else{
            return friends.count
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCellWithIdentifier("RequestCell", forIndexPath:indexPath) as UITableViewCell
            cell.textLabel?.text = requests[indexPath.row].username
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCellWithIdentifier("FriendCell", forIndexPath:indexPath) as UITableViewCell
            cell.textLabel?.text = friends[indexPath.row].username
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerNames[section]
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.section == 0{
            return true
        }
        else{
            return false
        }
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]?  {
        // 1
        let requestFrom = requests[indexPath.row]
        var acceptAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Accept" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            // 2
            let acceptMenu = UIAlertController(title: nil, message: "Are you sure you want to accept friend request from \"\(requestFrom.username)\"?", preferredStyle: .ActionSheet)
            
            let yesActionHandler = { (action:UIAlertAction!) -> Void in
                DatabaseConnection.AcceptOrRemoveFriendRequest(requestFrom.username, requestee: self.usersName, accept: true){
                    responseObject, error in
                    if responseObject != nil{
                        self.friends.append(requestFrom)
                        self.friends.sort({$0.username < $1.username})
                        self.requests.removeAtIndex(indexPath.row)
                        self.tableView.reloadData()
                        let alertMessage = UIAlertController(title: "Accepted!", message: "You are now friends with \(requestFrom.username)", preferredStyle: .Alert)
                        alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                        self.presentViewController(alertMessage, animated: true, completion: nil)
                    }
                    else{
                        let alertMessage = UIAlertController(title: "Cannot connect to internet", message: "Check your internet connection and try again", preferredStyle: .Alert)
                        alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                        self.presentViewController(alertMessage, animated: true, completion: nil)
                    }
                }
                
                
            }
            
            let yesAction = UIAlertAction(title: "Accept", style: UIAlertActionStyle.Default, handler: yesActionHandler)
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            
            acceptMenu.addAction(yesAction)
            acceptMenu.addAction(cancelAction)
            
            
            self.presentViewController(acceptMenu, animated: true, completion: nil)
        })
        // 3
        var rejectAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Reject" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            // 4
            let rejectMenu = UIAlertController(title: nil, message: "Are you sure you want to reject friend request from \"\(requestFrom.username)?\"", preferredStyle: .ActionSheet)
            
            let ryesActionHandler = { (action:UIAlertAction!) -> Void in
                DatabaseConnection.AcceptOrRemoveFriendRequest(requestFrom.username, requestee: self.usersName, accept: false){
                    responseObject, error in
                    if responseObject != nil{
                        self.requests.removeAtIndex(indexPath.row)
                        self.tableView.reloadData()
                        let alertMessage = UIAlertController(title: "Rejected!", message: "You just hurt \(requestFrom.username)'s feelings :(", preferredStyle: .Alert)
                        alertMessage.addAction(UIAlertAction(title: "Oh well", style: .Default, handler: nil))
                        self.presentViewController(alertMessage, animated: true, completion: nil)
                    }
                    else{
                        let alertMessage = UIAlertController(title: "Cannot connect to internet", message: "Check your internet connection and try again", preferredStyle: .Alert)
                        alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                        self.presentViewController(alertMessage, animated: true, completion: nil)
                    }
                }
            }
            
            let ryesAction = UIAlertAction(title: "Reject", style: UIAlertActionStyle.Default, handler: ryesActionHandler)
            let rcancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            
            rejectMenu.addAction(ryesAction)
            rejectMenu.addAction(rcancelAction)
            
            
            self.presentViewController(rejectMenu, animated: true, completion: nil)
        })
        
        acceptAction.backgroundColor = UIColor.greenColor()
        // 5
        return [rejectAction,acceptAction]
    }
    
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if segue.destinationViewController.isKindOfClass(FriendsProfileViewController){
            let destVC = segue.destinationViewController as FriendsProfileViewController
            destVC.friendsName = friends[self.tableView.indexPathForSelectedRow()!.row].username
        }
        else if (segue.destinationViewController.isKindOfClass(SearchUsersTableViewController)){
            let destVC = segue.destinationViewController as SearchUsersTableViewController
            destVC.usersName = self.usersName
        }
    }
    
    
}