//
//  profileGifts.swift
//  iWish
//
//  Created by Ai Vong on 3/7/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import UIKit

class profileGifts: UITableViewController {
    var gifts = [WishListGift]()
    var events = [UserEvent]()
    
    @IBAction func featuredPressed(sender: UIBarButtonItem) {
        VerifyState.selectedGifts = true
        let queryGifts = "SELECT name from WishListGifts where user = '\(VerifyState.selectedUser)'"
        
        DatabaseConnection.GetGifts(queryGifts) { responseObject, error in
            if responseObject != nil {
                self.gifts = responseObject!
                self.tableView.reloadData()
            }
            else {
                self.alertUser("No Data", messageText: "Could not retrieve data", buttonText: "OK")
            }
        }

    }
    
    @IBAction func socialPressed(sender: UIBarButtonItem) {
        VerifyState.selectedGifts = false
        let queryEvents = "SELECT * from Events where userID = '\(VerifyState.selectedUser)'"
        //println(queryEvents)
        
        DatabaseConnection.GetEvents(queryEvents) { responseObject, error in
            if responseObject != nil {
                self.events = responseObject!
                //        println(self.events.count)
                self.tableView.reloadData()
            }
            else {
                self.alertUser("No Data", messageText: "Could not retrieve data", buttonText: "OK")
            }
        }

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        VerifyState.selectedGifts = true
        let queryGifts = "SELECT name from WishListGifts where user = '\(VerifyState.selectedUser)'"
        
        DatabaseConnection.GetGifts(queryGifts) { responseObject, error in
            if responseObject != nil {
                self.gifts = responseObject!
                self.tableView.reloadData()
            }
            else {
                self.alertUser("No Data", messageText: "Could not retrieve data", buttonText: "OK")
            }
        }
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
        if VerifyState.selectedGifts {
            return gifts.count
        }
        return events.count
    }
    
    func alertUser(titleText: String, messageText: String, buttonText: String){
        let alertController = UIAlertController(title: titleText, message: messageText, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("WishListGift", forIndexPath: indexPath) as UITableViewCell
        
        if VerifyState.selectedGifts {
            let data = gifts[indexPath.row]
            cell.textLabel?.text = data.name
            
            return cell
        }
        let data = events[indexPath.row]
        cell.textLabel?.text = data.name
        
        return cell
    }
    
    //    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //
    //        selectedGift = gifts[indexPath.row]
    //    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            var wlg = gifts[indexPath.row]
            DatabaseConnection.DeleteGift(wlg.databaseID){ responseObject, error in
                //Do something when gift finishes being deleted
            }
            gifts.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
    
    // Configure the cell...
    
    return cell
    }
    */
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
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
