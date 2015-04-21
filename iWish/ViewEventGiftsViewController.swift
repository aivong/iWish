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


class ViewEventGiftsViewController: UITableViewController {
    
    var gifts = [WishListGift]()
    var selectedGift : WishListGift!
    var eventID : Int!
    
    func getUsersFeaturedGifts(){
        DatabaseConnection.GetGifts("SELECT * FROM WishListGifts WHERE eventID=\(eventID) ORDER BY name") { responseObject, error in
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
        selectedGift = WishListGift(giftID: 0, giftName: "None", giftDescription: "None", giftPrice: 0.00, giftEvent: 99999, giftPooling:false)
        getUsersFeaturedGifts()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addStyleToView()
    }
    
    
    func addStyleToView() {
        iWishStylingTool.addStyleToSubviewsOfView(self.view)
        self.tableView.separatorColor = UIColor(red: 252.0/255.0, green: 80.0/255.0, blue:80.0/255.0, alpha: 1.0)
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
        
        iWishStylingTool.addStyleToTableViewCell(cell)
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            selectedGift = gifts[indexPath.row]
            let query = "UPDATE WishListGifts SET eventID=99999 WHERE id=\(selectedGift.databaseID)"
            //println("UPDATE WishListGifts SET eventID=99999 WHERE id=\(selectedGift.databaseID)")
            DatabaseConnection.HandleGift(query){ responseObject, error in
                //CHECK FOR ERRORS
                // println("GIFT REMOVED FROM EVENT")
                if responseObject != nil {
                    self.getUsersFeaturedGifts()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
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
    }
    
    
}
