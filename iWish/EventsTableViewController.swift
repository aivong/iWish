//
//  EventsViewController.swift
//  iWish
//
//  Created by Zachary Bohlin on 2/17/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import UIKit

class EventsTableViewController: UITableViewController {

    let headerNames = ["Requests", "My Events", "Past Events", "Upcoming Events"]
    let spaceHeaderNames = ["Requests", "", "", "", "My Events", "", "", "", "Past Events", "", "", "", "Upcoming Events"]
    let pastEvents = ["Luncheon", "Breakfast", "GF Birthday", "Lunar Solstice", "New Years", "Martin Luther King Birthday"]
    let upcomingEvents = ["My Birthday", "Fathers Day", "Columbus Day", "Presidents Day", "Labor Day", "Mothers Day"]
    let myEvents = ["Party", "Pregame", "Barcrawl", "Unofficial", "Beer Pong", "Ping Pong Tournament"]
    let requests = ["Bulls Game", "Hawks Game", "Cubs Game", "Bears Game"]
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
        return headerNames.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        switch(section){
        case 0:
            return requests.count
        case 1:
            return myEvents.count
        case 2:
            return pastEvents.count
        case 3:
            return upcomingEvents.count
        default:
            return 0
        }
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath) as UITableViewCell

        switch(indexPath.section){
        case 0:
            cell.textLabel?.text = requests[indexPath.row]
        case 1:
            cell.textLabel?.text = myEvents[indexPath.row]
        case 2:
            cell.textLabel?.text = pastEvents[indexPath.row]
        case 3:
            cell.textLabel?.text = upcomingEvents[indexPath.row]
        default:
            cell.textLabel?.text = ""
        }

        return cell
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerNames[section]
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        if title == ""{
            return -1
        }
        else{
            return find(headerNames, title)!
        }
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]! {
        return spaceHeaderNames
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
