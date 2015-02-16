//
//  WishListTableViewController.swift
//  iWish
//
//  Created by Zachary Bohlin on 2/12/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import UIKit

class WishListTableViewController: UITableViewController {

    let testData = [WishListGift(giftID: 0, giftName: "Hot Wheels", giftDescription: "Fun little car", giftPrice: 2.00), WishListGift(giftID: 1, giftName: "GI Joe", giftDescription: "Action Figure", giftPrice: 4.99)]
    
    var gifts = [WishListGift]()
    var selectedGift = WishListGift(giftID: 0, giftName: "None", giftDescription: "None", giftPrice: 0.00)
    @IBAction func cancelAddGift(segue: UIStoryboardSegue){
        
    }
    
    @IBAction func saveGift(segue: UIStoryboardSegue){
        let addGiftVC = segue.sourceViewController as AddGiftViewController
        let newGiftName = addGiftVC.giftName.text
        let newGiftPrice = addGiftVC.giftPrice.text
        let newGiftDesc = addGiftVC.giftDescription.text
        
        if newGiftName == "" || newGiftPrice == "" || newGiftDesc == ""{
            alertUser("Not Saved",  messageText: "Please fill in all fields", buttonText: "OK")
        }
        else if countElements(newGiftName) > 20{
            alertUser("Warning!",  messageText: "Name must be no more than 20 characters", buttonText: "OK")
        }
        else if countElements(newGiftDesc) > 500{
            alertUser("Warning!",  messageText: "Description is too long! 500 characters max", buttonText: "OK")
        }
        else{
            let query = "INSERT INTO WishListGifts (user, name, description, price) VALUES ('bohlin2', '\(newGiftName)', '\(newGiftDesc)', \(newGiftPrice))"
            DatabaseConnection.InsertGift(query){ responseObject, error in
                self.getUsersFeaturedGifts()
            }
        }
        
    }
    
    func getUsersFeaturedGifts(){
        DatabaseConnection.GetGifts("SELECT * FROM WishListGifts ORDER BY name") { responseObject, error in
            if responseObject != nil {
                self.gifts = responseObject!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsersFeaturedGifts()
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedGift = gifts[indexPath.row]
        performSegueWithIdentifier("GiftDetailSegue", sender: self)
        
    }


    
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if(segue.identifier == "GiftDetailSegue"){
            let navVC = segue.destinationViewController as UINavigationController
            let gVC = navVC.viewControllers.first as? GiftDetailViewController
            gVC?.giftName = selectedGift.name
            gVC?.giftDescription = selectedGift.description
            gVC?.giftPrice = selectedGift.price
            println(selectedGift.price)
        }
    }


}
