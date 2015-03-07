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
    let requests = ["jdog4", "yoohoo443", "yesss99"]
    let friends = ["kbrenc2", "haha7", "justin1", "mitch5", "alex743", "astronaut567", "widewhite82"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            cell.textLabel?.text = requests[indexPath.row]
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCellWithIdentifier("FriendCell", forIndexPath:indexPath) as UITableViewCell
            cell.textLabel?.text = friends[indexPath.row]
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
        var acceptAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Accept" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            // 2
            let acceptMenu = UIAlertController(title: nil, message: "Are you sure you want to accept?", preferredStyle: .ActionSheet)
            
            let yesActionHandler = { (action:UIAlertAction!) -> Void in
                let alertMessage = UIAlertController(title: "Accepted!", message: "Not fully implemented yet", preferredStyle: .Alert)
                alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                self.presentViewController(alertMessage, animated: true, completion: nil)
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
            let rejectMenu = UIAlertController(title: nil, message: "Are you sure you want to reject?", preferredStyle: .ActionSheet)
            
            let ryesActionHandler = { (action:UIAlertAction!) -> Void in
                let alertMessage = UIAlertController(title: "Accepted!", message: "Not fully implemented yet", preferredStyle: .Alert)
                alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                self.presentViewController(alertMessage, animated: true, completion: nil)
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
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
