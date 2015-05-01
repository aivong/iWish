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
        
        DatabaseConnection.GetProperUsers(self.usersName){responseObject, error in
            let ps = self.properStringSQL(responseObject!)
            
            //Query will only return names of people user is not friends with
            DatabaseConnection.GetUser("SELECT DISTINCT Users.username as username, Users.password as password FROM Users, Friends WHERE (username != '\(self.usersName)' AND ((Friends.requester = '\(self.usersName)' AND Friends.requestee != username) OR (Friends.requester != username AND Friends.requestee = '\(self.usersName)') OR (Friends.requester != '\(self.usersName)' AND Friends.requestee != '\(self.usersName)'))) AND username IN \(ps) ORDER BY username") { responseObject, error in
                
                if responseObject != nil {
                    println(responseObject)
                    self.allUsers = responseObject!
                    
                    
                }
                else {
                    self.alertUser("Cannot retrieve data", messageText: "Data could not be loaded. Check connection to internet", buttonText: "OK")
                }
            }
        }
    
        self.tableView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addStyleToView()
    }
    
    
    func addStyleToView() {
        iWishStylingTool.addStyleToSubviewsOfView(self.view)

        self.tableView.separatorColor = UIColor(red: 252.0/255.0, green: 80.0/255.0, blue:80.0/255.0, alpha: 1.0)
    }
    
    func properStringSQL(names: [String]) -> String{
        var ret = "("
        for i in 0..<names.count{
            if i != names.count-1{
                ret += "'" + names[i] + "',"
            }
            else{
                ret += "'" + names[i] + "')"
            }
        }
        return ret
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
        
        iWishStylingTool.addStyleToTableViewCell(cell)
        
        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]?  {

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

        return [acceptAction]
    }
    
    
}