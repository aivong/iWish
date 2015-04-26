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
                print("test")
                self.myGifts = responseObject!
                self.tableView.reloadData()
            }
        }
        DatabaseConnection.GetGifts("SELECT * FROM WishListGifts WHERE pooling = 1 ORDER BY name") { responseObject, error in
            if responseObject != nil {
                let pooledGifts = responseObject!
                for pooledGift in pooledGifts {
                    
                    let query = "SELECT * FROM GiftPooling WHERE giftID=\(pooledGift.databaseID) AND pooledUser='\(self.usersName)'"
                    
                    DatabaseConnection.ExistsPooledGift(query){ responseObject, error in
                        //CHECK FOR ERRORS
                        if responseObject != nil {
                            
                            let existsGift = responseObject!
                            if existsGift == true {
                                var giftAdded = false
                                for index in stride(from: self.myGifts.count - 1, through: 0, by: -1) {
                                    if self.myGifts[index].databaseID == pooledGift.databaseID {
                                        giftAdded = true
                                    }
                                }
                                if pooledGift.eventID == self.eventID && giftAdded == false {
                                    self.myGifts.append(pooledGift)
                                }
                            }
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    func getBuyFeaturedGifts(){
        DatabaseConnection.GetGifts("SELECT * FROM WishListGifts WHERE eventID=\(eventID) AND userBought IS NULL AND pooling = 0 ORDER BY name") { responseObject, error in
            if responseObject != nil {
                self.giftList = responseObject!
                self.tableView.reloadData()
            }
        }
        DatabaseConnection.GetGifts("SELECT * FROM WishListGifts WHERE pooling = 1 ORDER BY name") { responseObject, error in
            if responseObject != nil {
                let pooledGifts = responseObject!
                for pooledGift in pooledGifts {
                    
                    let query = "SELECT * FROM GiftPooling WHERE giftID=\(pooledGift.databaseID) AND pooledUser='\(self.usersName)'"
                    
                    DatabaseConnection.ExistsPooledGift(query){ responseObject, error in
                        //CHECK FOR ERRORS
                        if responseObject != nil {
                            //print("test")
                            let existsGift = responseObject!
                            if existsGift == false {
                                var giftAdded = false
                                for index in stride(from: self.giftList.count - 1, through: 0, by: -1) {
                                    if self.giftList[index].databaseID == pooledGift.databaseID {
                                        giftAdded = true
                                    }
                                }
                                if pooledGift.eventID == self.eventID && giftAdded == false {
                                    self.giftList.append(pooledGift)
                                }
                            }
                            self.tableView.reloadData()
                        }
                    }
                }
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
        
        iWishStylingTool.addStyleToTableViewCell(cell)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerNames[section]
    }
    
    override func viewDidAppear(animated: Bool) {
        selectedGift = WishListGift(giftID: 0, giftName: "None", giftDescription: "None", giftPrice: 0.00, giftEvent: 99999, giftPooling:false)
        getBuyFeaturedGifts()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addStyleToView()
    }
    
    
    func addStyleToView() {
        iWishStylingTool.addStyleToSubviewsOfView(self.view)
        self.tableView.separatorColor = UIColor(red: 252.0/255.0, green: 80.0/255.0, blue:80.0/255.0, alpha: 1.0)
    }
    
    // Override to support editing thje table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section==0{
            print(indexPath.section)
            if editingStyle == .Delete{
                // Delete the row from the data source
                var wlg = myGifts[indexPath.row]
                let poolingQuery = "SELECT pooling FROM WishListGifts WHERE id=\(wlg.databaseID)"
                DatabaseConnection.GetGiftPoolingOption(poolingQuery){responseObject, error in
                    if responseObject != nil {
                        let poolingOption = responseObject!
                        if poolingOption == 0 {
                            let query = "UPDATE WishListGifts SET userBought=NULL WHERE id=\(wlg.databaseID)"
                            
                            DatabaseConnection.HandleGift(query){ responseObject, error in
                                //CHECK FOR ERRORS
                                if responseObject != nil {
                                    self.getMyBoughtGifts()
                                    self.getBuyFeaturedGifts()
                                    self.myGifts.removeAtIndex(indexPath.row)
                                    self.tableView.reloadData()
                                }
                            }
                        }
                        else {
                            let query = "DELETE FROM GiftPooling WHERE giftID=\(wlg.databaseID) AND pooledUser='\(self.usersName)'"
                            
                            DatabaseConnection.DeletePooledGift(query){ responseObject, error in
                                if responseObject != nil {
                                    self.getMyBoughtGifts()
                                    self.getBuyFeaturedGifts()
                                    self.myGifts.removeAtIndex(indexPath.row)
                                    self.tableView.reloadData()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]?  {
        // 1
        if indexPath.section == 1 {
            let giftToAdd = giftList[indexPath.row]
            var buyAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Buy" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
                // 2
                let buyMenu = UIAlertController(title: nil, message: "Are you sure you want to buy \"\(giftToAdd.name)\"?", preferredStyle: .ActionSheet)
                
                let buyActionHandler = { (action:UIAlertAction!) -> Void in
                    let poolingQuery = "SELECT pooling FROM WishListGifts WHERE id=\(giftToAdd.databaseID)"
                    DatabaseConnection.GetGiftPoolingOption(poolingQuery){responseObject, error in
                        if responseObject != nil {
                            let poolingOption = responseObject!
                            if poolingOption == 0 {
                                let query = "UPDATE WishListGifts SET userBought='\(self.usersName)' WHERE id=\(giftToAdd.databaseID)"
                                
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
                            else {
                                let query = "INSERT INTO GiftPooling (giftID, pooledUser) VALUES (\(giftToAdd.databaseID), '\(self.usersName)')"
                                
                                DatabaseConnection.InsertPooledGift(query){ responseObject, error in
                                    if responseObject != nil {
                                        self.getMyBoughtGifts()
                                        self.getBuyFeaturedGifts()
                                        self.giftList.removeAtIndex(indexPath.row)
                                        self.tableView.reloadData()
                                    }
                                }
                            }
                        }
                    }
                    
                }
                
                let buyAction = UIAlertAction(title: "Accept", style: UIAlertActionStyle.Default, handler: buyActionHandler)
                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
                
                buyMenu.addAction(buyAction)
                buyMenu.addAction(cancelAction)
                
                
                self.presentViewController(buyMenu, animated: true, completion: nil)
            })
            
            buyAction.backgroundColor = UIColor.yellowColor()
            // 5
            return [buyAction]
        }
        return nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if(segue.destinationViewController.isKindOfClass(BuyGiftDetailViewController)){
            
            let vc = segue.destinationViewController as BuyGiftDetailViewController
            
            let path = self.tableView.indexPathForSelectedRow()!
            if(path.section == 0) {
                vc.gift = myGifts[path.row]
            }
            else {
                vc.gift = giftList[path.row]
            }
        }
    }
    
    
}
