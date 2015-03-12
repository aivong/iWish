//
//  EditGiftViewController.swift
//  iWish
//
//  Created by Kevin French on 3/12/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import UIKit

class EditGiftViewController: UIViewController {

    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var priceLabel: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    let giftEditSavedSegueIdentifier = "GiftEditSavedSegue"
        
    var gift: WishListGift!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameLabel.text = gift.name
        self.priceLabel.text = String(format:"$%.2f", gift.price)
        self.descriptionTextView.editable = true
        self.descriptionTextView.text = gift.description
        
        let saveButton = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: "savePressed:")
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "cancelPressed:")
        
        self.navigationItem.rightBarButtonItem = saveButton
        self.navigationItem.leftBarButtonItem = cancelButton

        // Do any additional setup after loading the view.
    }
    
    func savePressed(sender: AnyObject) {
        
        if self.validInputs() {
            
            let query = "UPDATE WishListGifts SET name='\(nameLabel.text)', description='\(descriptionTextView.text)', price=\(priceLabel.text) WHERE id=\(self.gift.databaseID)"
            
            DatabaseConnection.InsertGift(query){ responseObject, error in
                //CHECK FOR ERRORS
                self.giftSuccessfullyAdded()
            }
        }
    }
    
    private func giftSuccessfullyAdded() {
        self.performSegueWithIdentifier(giftEditSavedSegueIdentifier, sender: self)
    }
    
    private func validInputs() -> Bool {
        
        var alertTitle = ""
        var alertBody = ""
        
        if (nameLabel.text == "" || priceLabel.text == "" || descriptionTextView.text == "") {
            alertTitle = "Empty Fields"
            alertBody = "Please fill in all fields"
        } else if countElements(nameLabel.text) > 20 {
            alertTitle = "Invalid Name"
            alertBody = "Name must be 20 or fewer characters"
        } else if countElements(descriptionTextView.text) > 500 {
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
    
    func cancelPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == giftEditSavedSegueIdentifier {
            self.gift.name = self.nameLabel.text
            self.gift.description = self.descriptionTextView.text
            self.gift.price = (self.priceLabel.text as NSString).doubleValue
        }
    }
}
