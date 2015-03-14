//
//  EventMenuViewController.swift
//  iWish
//
//  Created by chutipo2 on 3/8/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import UIKit

class EventMenuViewController: UITableViewController {
    
    let options = ["Event Detail", "Wish List", "Guest List"]
    //    let upcomingEvents = ["My Birthday", "Fathers Day", "Columbus Day", "Presidents Day", "Labor Day", "Mothers Day"]
    
    
    var upcomingEvents = [UserEvent]()
    var event: UserEvent!
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
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
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        switch(section){
        case 0:
            return options.count
        default:
            return 0
        }
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        if indexPath.row == 0{
            cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath) as UITableViewCell
        }
        else {
            cell = tableView.dequeueReusableCellWithIdentifier("WishlistCell", forIndexPath: indexPath) as UITableViewCell
        }
        switch(indexPath.section){
        case 0:
            cell.textLabel?.text = options[indexPath.row]
            
        default:
            cell.textLabel?.text = ""
        }
        
        return cell
    }
    
    //UPDATE  `cs429iwi_databases`.`WishListGifts` SET  `eventID` =  '5' WHERE  `WishListGifts`.`id` =21;
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    
    
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
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.destinationViewController.isKindOfClass(EventDetailViewController)) {
            let vc = segue.destinationViewController as EventDetailViewController
            vc.event = event
        }
        else if(segue.destinationViewController.isKindOfClass(ViewEventGiftsViewController)) {
            let vc = segue.destinationViewController as ViewEventGiftsViewController
            vc.eventID = event.eventID
        }
        else {
            println("Noting")
        }
        
    }
    
}



