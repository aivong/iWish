//
//  AddGiftToEventViewController.swift
//  iWish
//
//  Created by chutipo2 on 3/7/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import Foundation
import UIKit


class AddGiftToEventViewController: UITableViewController {
    
    var gifts = [WishListGift]()
    var selectedGift : WishListGift!
    var eventID : Int!
    
    func getUsersFeaturedGifts(){
        DatabaseConnection.GetGifts("SELECT * FROM WishListGifts WHERE eventID=99999 AND user = '\(VerifyState.username)' ORDER BY name") { responseObject, error in
            if responseObject != nil {
                self.gifts = responseObject!
                self.tableView.reloadData()
            }
            else {
                self.alertUser("No Data", messageText: "Could not retrieve data", buttonText: "OK")
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
        getUsersFeaturedGifts()
    }
    
    override func viewDidAppear(animated: Bool) {
        selectedGift = WishListGift(giftID: 0, giftName: "None", giftDescription: "None", giftPrice: 0.00, giftEvent: 99999)
        getUsersFeaturedGifts()
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
        return gifts.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WishListGift", forIndexPath: indexPath) as UITableViewCell
        
        let data = gifts[indexPath.row]
        cell.textLabel?.text = data.name
        
        return cell
    }
    
    //UPDATE  `cs429iwi_databases`.`WishListGifts` SET  `eventID` =  '5' WHERE  `WishListGifts`.`id` =21;
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedGift = gifts[indexPath.row]
        let query = "UPDATE WishListGifts SET eventID=\(eventID) WHERE id=\(selectedGift.databaseID)"
        
        DatabaseConnection.HandleGift(query){ responseObject, error in
            //CHECK FOR ERRORS
            if responseObject != nil {
                self.getUsersFeaturedGifts()
                self.tableView.reloadData()
            }
        }        
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    
    
    
}