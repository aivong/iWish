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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DatabaseConnection.GetUser("SELECT * FROM Users ORDER BY username") { responseObject, error in
            if responseObject != nil {
                self.allUsers = responseObject!
                self.tableView.reloadData()
            }
            else {
                //DO SOMETHING WHEN DATA CAN'T BE RETRIEVED
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
