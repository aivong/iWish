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
    let pastEvents = ["Luncheon"]
    //    let upcomingEvents = ["My Birthday", "Fathers Day", "Columbus Day", "Presidents Day", "Labor Day", "Mothers Day"]
    let myEvents = ["Party"]
    let requests = ["Bulls Game"]
    
    var upcomingEvents = [UserEvent]()
    
    @IBAction func cancelAddEvent(segue: UIStoryboardSegue){
        
    }
    
    @IBAction func saveEvent(segue: UIStoryboardSegue){
        let addEventVC = segue.sourceViewController as AddEventViewController
        let newEventName = addEventVC.eventName.text
        let newEventDate = addEventVC.eventDate.text
        let newEventDesc = addEventVC.eventDescription.text
        
        if newEventName == "" || newEventDate == "" || newEventDesc == ""{
            alertUser("Not Saved",  messageText: "Please fill in all fields", buttonText: "OK")
        }
        else if countElements(newEventName) > 20{
            alertUser("Warning!",  messageText: "Name must be no more than 20 characters", buttonText: "OK")
        }
        else if countElements(newEventDesc) > 500{
            alertUser("Warning!",  messageText: "Description is too long! 500 characters max", buttonText: "OK")
        }
        else{
            upcomingEvents.append(UserEvent(eventID: 1,eventName: newEventName,eventDate: newEventDate,eventDescription: newEventDesc));
            let query = "INSERT INTO Events (eventID, userID, name, date, description, guestListID) VALUES (NULL,'bohlin2', '\(newEventName)', '\(newEventDate)', '\(newEventDesc)', NULL)"
            DatabaseConnection.InsertEvent(query){ responseObject, error in
                self.getUsersFeaturedEvents()
            }
        }
        
    }
    
    func getUsersFeaturedEvents(){
        DatabaseConnection.GetEvents("SELECT * FROM Events ORDER BY name") { responseObject, error in print(error?.localizedDescription)
            if responseObject != nil {
                self.upcomingEvents = responseObject!
                self.tableView.reloadData()
            }
            else{
                self.alertUser("No Data", messageText: "Could not retrieve data", buttonText: "OK")
            }
        }
        
    }
    
    func alertUser(titleText: String, messageText: String, buttonText: String){
        let alertController = UIAlertController(title: titleText, message: messageText, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            var wlg = upcomingEvents[indexPath.row]
            DatabaseConnection.DeleteEvent(wlg.name){ responseObject, error in
                //Do something when Event finishes being deleted
            }
            upcomingEvents.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsersFeaturedEvents()
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
            cell.textLabel?.text = upcomingEvents[indexPath.row].name
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
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if(segue.destinationViewController.isKindOfClass(EventMenuViewController)){
            
            let vc = segue.destinationViewController as EventMenuViewController
            
            let path = self.tableView.indexPathForSelectedRow()!
            vc.event = upcomingEvents[path.row]
            
            //            vc.giftName = selectedGift.name
            //            vc.giftDescription = selectedGift.description
            //            vc.giftPrice = selectedGift.price
            
        }
    }
    
}
