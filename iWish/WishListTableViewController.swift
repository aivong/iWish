//
//  WishListTableViewController.swift
//  iWish
//
//  Created by Zachary Bohlin on 2/12/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import UIKit

class WishListTableViewController: UITableViewController {
//    
//    let testData = [WishListGift(giftID: 0, giftName: "Hot Wheels", giftDescription: "Fun little car", giftPrice: 2.00), WishListGift(giftID: 1, giftName: "GI Joe", giftDescription: "Action Figure", giftPrice: 4.99)]
    
    var gifts = [WishListGift]()
    var selectedGift : WishListGift!
    
    //let query = "SELECT * FROM Users WHERE username = '\(usernameTextField.text)'"
   // SELECT name from WishListGifts where user = '\(VerifyState.selectedUser)'
    
    func getUsersFeaturedGifts(){
        DatabaseConnection.GetGifts("SELECT * FROM WishListGifts WHERE user = '\(VerifyState.username)' ORDER BY name") { responseObject, error in
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
    
    override func viewDidLayoutSubviews() {
        addStyleToView()
    }
    
    func addStyleToView() {
        iWishStylingTool.addStyleToSubviewsOfView(self.view)
        
        self.tableView.separatorColor = UIColor(red: 252.0/255.0, green: 80.0/255.0, blue:80.0/255.0, alpha: 1.0)
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 252.0/255.0, green: 80.0/255.0, blue:80.0/255.0, alpha: 1.0)
        
        let font = UIFont(name: "Heiti SC", size: 18.0)
        if let font = font {
            self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : font, NSForegroundColorAttributeName : UIColor.whiteColor()]
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        selectedGift = WishListGift(giftID: 0, giftName: "None", giftDescription: "None", giftPrice: 0.00, giftEvent: 9999, giftPooling:false)
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
        
        iWishStylingTool.addStyleToTableViewCell(cell)
        
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
        if(segue.destinationViewController.isKindOfClass(GiftDetailViewController)){
            
            let vc = segue.destinationViewController as GiftDetailViewController
            
            let path = self.tableView.indexPathForSelectedRow()!
            vc.gift = gifts[path.row]
        }
    }
    
    
}
