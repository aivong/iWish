//
//  AddGiftViewController.swift
//  iWish
//
//  Created by Zachary Bohlin on 2/15/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import UIKit

class AddGiftViewController: UIViewController {

    @IBOutlet weak var giftName: UITextField!
    @IBOutlet weak var giftPrice: UITextField!
    @IBOutlet weak var giftDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        giftDescription.layer.borderWidth = 1
        giftDescription.layer.borderColor = UIColor.blackColor().CGColor
        


    }
    
    
    @IBAction func cancelPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func savePressed(sender: AnyObject) {
        
        if self.validInputs() {
            
            let query = "INSERT INTO WishListGifts (user, name, description, price) VALUES ('bohlin2', '\(giftName.text)', '\(giftDescription.text)', \(giftPrice.text))"
            
            DatabaseConnection.InsertGift(query){ responseObject, error in
                //CHECK FOR ERRORS
                self.giftSuccessfullyAdded()
            }
        }
    }
    
    private func giftSuccessfullyAdded() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    private func validInputs() -> Bool {
        
        var alertTitle = ""
        var alertBody = ""
        
        if (giftName.text == "" || giftPrice.text == "" || giftDescription.text == "") {
            alertTitle = "Empty Fields"
            alertBody = "Please fill in all fields"
        } else if countElements(giftName.text) > 20 {
            alertTitle = "Invalid Name"
            alertBody = "Name must be 20 or fewer characters"
        } else if countElements(giftDescription.text) > 500 {
            alertTitle = "Invalid Description"
            alertBody = "Description must be 500 or fewer characters"
        }
        
        if alertTitle == "" {
            return true
        } else {
            let alertView = UIAlertView(title: alertTitle, message: alertBody, delegate: nil, cancelButtonTitle: "OK")
            alertView.show()
            return false
        }
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
