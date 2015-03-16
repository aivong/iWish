//
//  SearchUsersTableViewController.swift
//  iWish
//
//  Created by Zachary Bohlin on 2/24/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import UIKit

class SearchUsersTableViewController: UITableViewController, UISearchBarDelegate {

    var allUsers = [Users]()
    var filteredUsers = [Users]()
    var resultSearchController = UISearchController()
    var usersName: String!
    
    @IBOutlet weak var searchAllUsers: UISearchBar!
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        filteredUsers = allUsers.filter({(user: Users) -> Bool in
            return user.username.lowercaseString.rangeOfString(searchBar.text.lowercaseString) != nil
        })
        self.tableView.reloadData()
    }
    
    func alertUser(titleText: String, messageText: String, buttonText: String){
        let alertController = UIAlertController(title: titleText, message: messageText, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Query will only return names of people user is not friends with
        DatabaseConnection.GetUser("SELECT DISTINCT Users.username as username, Users.password as password FROM Users, Friends WHERE (username != '\(usersName)' AND ((Friends.requester = '\(usersName)' AND Friends.requestee != username) OR (Friends.requester != username AND Friends.requestee = '\(usersName)') OR (Friends.requester != '\(usersName)' AND Friends.requestee != '\(usersName)'))) ORDER BY username") { responseObject, error in
            
            if responseObject != nil {
                println(responseObject)
                self.allUsers = responseObject!
                self.tableView.reloadData()
            }
            else {
                self.alertUser("Cannot retrieve data", messageText: "Data could not be loaded. Check connection to internet", buttonText: "OK")
            }
        }
        
        // Reload the table
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
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUsers.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = filteredUsers[indexPath.row].username
        return cell
    }


    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]?  {
        // 1
        var acceptAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Add Friend" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            let friendName = self.filteredUsers[indexPath.row].username
            let acceptMenu = UIAlertController(title: nil, message: "Send friend request?", preferredStyle: .ActionSheet)
            
            let yesActionHandler = { (action:UIAlertAction!) -> Void in
                self.filteredUsers.removeAtIndex(indexPath.row)
                self.tableView.reloadData()
                DatabaseConnection.AddFriendRequest(self.usersName, requestee: friendName) { responseObject, error in
                    println("Done")
                }
                tableView.setEditing(false, animated: true)
            }
            
            let yesAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: yesActionHandler)
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            
            acceptMenu.addAction(yesAction)
            acceptMenu.addAction(cancelAction)
            
            
            self.presentViewController(acceptMenu, animated: true, completion: nil)
        })

        
        acceptAction.backgroundColor = UIColor.greenColor()
        // 5
        return [acceptAction]
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
