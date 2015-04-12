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
    //    let myEvents = ["My Birthday", "Fathers Day", "Columbus Day", "Presidents Day", "Labor Day", "Mothers Day"]
    //let requests = ["Bulls Game"]
    var usersName: String!
    
    var myEvents = [UserEvent]()
    var eventRequests = [UserEvent]()
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
            myEvents.append(UserEvent(eventID: 1,eventName: newEventName,eventDate: newEventDate,eventDescription: newEventDesc));
            let query = "INSERT INTO Events (eventID, userID, name, date, description, guestListID) VALUES (NULL,'\(usersName)', '\(newEventName)', '\(newEventDate)', '\(newEventDesc)', NULL)"
            DatabaseConnection.InsertEvent(query){ responseObject, error in
                self.getUsersFeaturedEvents()
            }
        }
        
    }
    
    func getUsersFeaturedEvents(){
 //       println("SELECT * FROM Events WHERE userID='\(usersName)' ORDER BY name")
        DatabaseConnection.GetEvents("SELECT * FROM Events WHERE userID='\(usersName)' ORDER BY name") { responseObject, error in print(error?.localizedDescription)
            if responseObject != nil {
                self.myEvents = responseObject!
                self.addUpcomingEventNotifications()
                self.tableView.reloadData()
            }
            else{
                self.alertUser("No Data", messageText: "Could not retrieve data", buttonText: "OK")
            }
        }
        
    }
    
    func getUsersEventRequests(){
        DatabaseConnection.GetEventRequests("SELECT Events.eventID AS eventID, Events.date AS date, Events.name AS name, Events.description AS description FROM Events INNER JOIN Invites ON Events.eventID=Invites.eventID WHERE Invites.status='pending' AND Invites.invitee='\(usersName)' ORDER BY Events.name") { responseObject, error in print(error?.localizedDescription)
            if responseObject != nil {
                self.eventRequests = responseObject!
                self.tableView.reloadData()
            }
            else{
                self.alertUser("No Data", messageText: "Could not retrieve data", buttonText: "OK")
            }
        }
    }
    
    func getUsersUpcomingEvents(){
        DatabaseConnection.GetUpcomingEvents("SELECT Events.eventID AS eventID, Events.date AS date, Events.name AS name, Events.description AS description FROM Events INNER JOIN Invites ON Events.eventID=Invites.eventID WHERE Invites.status='confirmed' AND Invites.invitee='\(usersName)' ORDER BY Events.name") { responseObject, error in print(error?.localizedDescription)
            if responseObject != nil {
                self.upcomingEvents = responseObject!
                self.tableView.reloadData()
            }
            else{
                self.alertUser("No Data", messageText: "Could not retrieve data", buttonText: "OK")
            }
        }
    }
    
    func addUpcomingEventNotifications() {
        
        for event in self.myEvents {
        
            let dayNotification = event.dayEventNotification()
            let weekNotifcation = event.weekEventNotification()
            
            if let goodDayNotification = dayNotification {
                self.scheduleNotificationIfNotAlreadyScheduled(goodDayNotification)
            }
            
            if let goodWeekNotification = weekNotifcation {
                self.scheduleNotificationIfNotAlreadyScheduled(goodWeekNotification)
            }
        }
    }
    
    func scheduleNotificationIfNotAlreadyScheduled(newNotification: UILocalNotification) {
        
        let scheduledLocalNotifications =  UIApplication.sharedApplication().scheduledLocalNotifications
    
        for scheduledLocalNotification in scheduledLocalNotifications {
            
            let sameText = (newNotification.alertBody == scheduledLocalNotification.alertBody)
            let sameDate = (newNotification.fireDate == scheduledLocalNotification.fireDate)
            
            if sameText && sameDate {
                return
            }
        }
        
        UIApplication.sharedApplication().scheduleLocalNotification(newNotification)
    }
    
    func alertUser(titleText: String, messageText: String, buttonText: String){
        let alertController = UIAlertController(title: titleText, message: messageText, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // Override to support editing thje table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            var wlg = myEvents[indexPath.row]
            DatabaseConnection.DeleteEvent(wlg.eventID){ responseObject, error in
                //Do something when Event finishes being deleted
            }
            myEvents.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usersName = VerifyState.username
        
        println("\(UIApplication.sharedApplication().scheduledLocalNotifications.count)")
        
        for notifcation in UIApplication.sharedApplication().scheduledLocalNotifications {
            println("\(notifcation.alertBody)")
            println("\(notifcation.fireDate)")
        }
    
//        let defaults = NSUserDefaults.standardUserDefaults()
//        if let name = defaults.stringForKey("username")
//        {
//            usersName = name
//            //usersName = VerifyState.username
//        }
        getUsersFeaturedEvents()
        getUsersEventRequests()
        getUsersUpcomingEvents()
        
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
            return eventRequests.count
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
        var cell: UITableViewCell!
        
        switch(indexPath.section){
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("RequestCell", forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = eventRequests[indexPath.row].name
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = myEvents[indexPath.row].name
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("PastCell", forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = pastEvents[indexPath.row]
        case 3:
            cell = tableView.dequeueReusableCellWithIdentifier("UpcomingCell", forIndexPath: indexPath) as UITableViewCell
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
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.section == 0 || indexPath.section == 1{
            return true
        }
        else{
            return false
        }
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]?  {
        // 1
        if indexPath.section == 0 {
            let eventRequest = eventRequests[indexPath.row]
            var acceptAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Accept" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
                // 2
                let acceptMenu = UIAlertController(title: nil, message: "Are you sure you want to accept event request to \"\(eventRequest.name)\"?", preferredStyle: .ActionSheet)
                
                let yesActionHandler = { (action:UIAlertAction!) -> Void in
                    DatabaseConnection.AcceptOrRemoveEventRequest(self.usersName, eventID: eventRequest.eventID, accept: true){
                        responseObject, error in
                        if responseObject != nil{
                            //self.friends.append(requestFrom)
                            //self.friends.sort({$0.username < $1.username})
                            self.eventRequests.removeAtIndex(indexPath.row)
                            self.tableView.reloadData()
                            self.getUsersUpcomingEvents()
                            //let alertMessage = UIAlertController(title: "Accepted!", message: "You are now friends with \(requestFrom.username)", preferredStyle: .Alert)
                            //alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                            //self.presentViewController(alertMessage, animated: true, completion: nil)
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
                let rejectMenu = UIAlertController(title: nil, message: "Are you sure you want to reject friend request from \"\(eventRequest.name)?\"", preferredStyle: .ActionSheet)
                
                let ryesActionHandler = { (action:UIAlertAction!) -> Void in
                    DatabaseConnection.AcceptOrRemoveEventRequest(self.usersName, eventID: eventRequest.eventID, accept: false){
                        responseObject, error in
                        if responseObject != nil{
                            self.eventRequests.removeAtIndex(indexPath.row)
                            self.tableView.reloadData()
                            //let alertMessage = UIAlertController(title: "Rejected!", message: "You just hurt \(requestFrom.username)'s feelings :(", preferredStyle: .Alert)
                            //alertMessage.addAction(UIAlertAction(title: "Oh well", style: .Default, handler: nil))
                            //self.presentViewController(alertMessage, animated: true, completion: nil)
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
        return nil
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
            vc.event = myEvents[path.row]
            vc.usersName = VerifyState.username
            //            vc.giftName = selectedGift.name
            //            vc.giftDescription = selectedGift.description
            //            vc.giftPrice = selectedGift.price
        }
        if(segue.destinationViewController.isKindOfClass(RequestDetailViewController)){
                
                let vc = segue.destinationViewController as RequestDetailViewController
                
                let path = self.tableView.indexPathForSelectedRow()!
                vc.event = eventRequests[path.row]
                //            vc.giftName = selectedGift.name
                //            vc.giftDescription = selectedGift.description
                //            vc.giftPrice = selectedGift.price
                
        }
        if(segue.destinationViewController.isKindOfClass(BuyGiftListTableViewController)){
            
            let vc = segue.destinationViewController as BuyGiftListTableViewController
            
            let path = self.tableView.indexPathForSelectedRow()!
            vc.eventID = upcomingEvents[path.row].eventID
            vc.usersName = VerifyState.username
            //            vc.giftName = selectedGift.name
            //            vc.giftDescription = selectedGift.description
            //            vc.giftPrice = selectedGift.price
            
        }
    }
    
}
