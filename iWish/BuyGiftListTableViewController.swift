//
//  ViewEventGiftsViewController.swift
//  iWish
//
//  Created by chutipo2 on 3/8/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import Foundation
import UIKit


import Foundation
import UIKit


class BuyGiftListTableViewController: UITableViewController {
    
    let headerNames = ["My Gifts", "Gift List"]
    var myGifts = [WishListGift]()
    var giftList = [WishListGift]()
    var selectedGift : WishListGift!
    var eventID : Int!
    var usersName: String!
    
    func getMyBoughtGifts(){
        DatabaseConnection.GetGifts("SELECT * FROM WishListGifts WHERE eventID=\(eventID) AND userBought='\(usersName)' ORDER BY name") { responseObject, error in
            if responseObject != nil {
                self.myGifts = responseObject!
                self.tableView.reloadData()
            }
        }
    }
    
    func getBuyFeaturedGifts(){
        DatabaseConnection.GetGifts("SELECT * FROM WishListGifts WHERE eventID=\(eventID) AND userBought IS NULL ORDER BY name") { responseObject, error in
            if responseObject != nil {
                self.giftList = responseObject!
                self.tableView.reloadData()
            }
        }
    }
    
    func alertUser(titleText: String, messageText: String, buttonText: String){
        let alertController = UIAlertController(title: titleText, message: messageText, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMyBoughtGifts()
        getBuyFeaturedGifts()
    }
    
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
            return myGifts.count
        case 1:
            return giftList.count
        default:
            return 0
        }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        switch(indexPath.section){
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("BoughtGiftCell", forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = myGifts[indexPath.row].name
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("BuyGiftCell", forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = giftList[indexPath.row].name
        default:
            cell.textLabel?.text = ""
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            selectedGift = giftList[indexPath.row]
            let query = "UPDATE WishListGifts SET userBought='\(usersName)' WHERE id=\(selectedGift.databaseID)"
            
            DatabaseConnection.HandleGift(query){ responseObject, error in
                //CHECK FOR ERRORS
                if responseObject != nil {
                    self.getMyBoughtGifts()
                    self.getBuyFeaturedGifts()
                    self.giftList.removeAtIndex(indexPath.row)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.section == 0{
            return true
        }
        else{
            return false
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerNames[section]
    }
    
    override func viewDidAppear(animated: Bool) {
        selectedGift = WishListGift(giftID: 0, giftName: "None", giftDescription: "None", giftPrice: 0.00, giftEvent: 99999)
        getBuyFeaturedGifts()
    }
    
    // Override to support editing thje table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section==0{
            print(indexPath.section)
            if editingStyle == .Delete{
                // Delete the row from the data source
                var wlg = myGifts[indexPath.row]
                let query = "UPDATE WishListGifts SET userBought=NULL WHERE id=\(wlg.databaseID)"
                DatabaseConnection.HandleGift(query){ responseObject, error in
                    //Do something when Event finishes being deleted
                    self.myGifts.removeAtIndex(indexPath.row)
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                    self.getMyBoughtGifts()
                    self.getBuyFeaturedGifts()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if(segue.destinationViewController.isKindOfClass(ViewEventGiftDetailViewController)){
    
    let vc = segue.destinationViewController as ViewEventGiftDetailViewController
    
    let path = self.tableView.indexPathForSelectedRow()!
    vc.gift = gifts[path.row]
    
    //            vc.giftName = selectedGift.name
    //            vc.giftDescription = selectedGift.description
    //            vc.giftPrice = selectedGift.price
    
    }
    if(segue.destinationViewController.isKindOfClass(AddGiftToEventViewController)){
    
    let vc = segue.destinationViewController as AddGiftToEventViewController
    
    vc.eventID = eventID
    }
    }*/
    
    
}
