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
    
    @IBOutlet weak var poolingSwitch: UISwitch!
    
    let giftEditSavedSegueIdentifier = "GiftEditSavedSegue"
    
    var gift: WishListGift!
    
    var poolSw = "0"
    
    var array = [MCOSMTPSendOperation]()
    
    var invites = [Invite]()
    var users = [Users]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameLabel.text = gift.name
        self.priceLabel.text = String(format:"$%.2f", gift.price)
        self.descriptionTextView.editable = true
        self.descriptionTextView.text = gift.description
        self.poolingSwitch.userInteractionEnabled = false;
        
        if(gift.allowPooling == true)
        {
            poolSw = "1"
        }
        
        let query = "SELECT userBought FROM WishListGifts WHERE id=\(self.gift.databaseID)"
        
        DatabaseConnection.ExistsUserBought(query){ responseObject, error in
            let existsUserBought = responseObject!
            
            if existsUserBought == true {
                self.poolingSwitch.on = self.gift.allowPooling
                self.poolingSwitch.userInteractionEnabled = false;
            }
            else {
                self.poolingSwitch.userInteractionEnabled = true
                self.poolingSwitch.on = self.gift.allowPooling
            }
        }
        
        let saveButton = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: "savePressed:")
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "cancelPressed:")
        
        self.navigationItem.rightBarButtonItem = saveButton
        self.navigationItem.leftBarButtonItem = cancelButton
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addStyleToView()
    }
    
    
    func addStyleToView() {
        iWishStylingTool.addStyleToSubviewsOfView(self.view)
    }
    
    private func poolConfirmation(giftname: String, email: String) {
        var smtpSession:MCOSMTPSession = MCOSMTPSession()
        smtpSession.hostname = "smtp.gmail.com";
        smtpSession.port = 465;
        smtpSession.username = "iWishlegit@gmail.com";
        smtpSession.password = "iwishiwish";
        smtpSession.connectionType = MCOConnectionType.TLS;
        
        var builder:MCOMessageBuilder = MCOMessageBuilder();
        builder.header.from = MCOAddress(mailbox: "iWish.legit@gmail.com")
        //builder.header.to = [MCOAddress(mailbox: "auserthatisnotreal@gmail.com")]
        builder.header.to = [MCOAddress(mailbox: email)]
        builder.header.subject = "iWish Pool Confirmation"
        builder.htmlBody = "<h1>Giftpooling has been enabled for " + giftname + ".</h1>"
        
        let rfc822Data:NSData = builder.data()
        
        array.append(smtpSession.sendOperationWithData(rfc822Data))
        
        array[0].start({ (error:NSError!) -> Void
            in
            println("Sent")
        })
        
        array.removeLast()
    }
    
    func savePressed(sender: AnyObject) {
        
        if self.validInputs() {
            
            self.stripInputs()
            
            var poolingString = "0"
            
            if self.poolingSwitch.on {
                poolingString = "1"
                if(poolSw != "1"){
                    DatabaseConnection.GetGuestsForEvent(self.gift.eventID, status:"confirmed")
                        { responseObject, error in
                            if responseObject != nil
                            {
                                self.invites = responseObject!
                            }
                            for index in stride(from: self.invites.count - 1, through: 0, by: -1)
                            {
                                println(index)
                                let query = "SELECT * FROM Users WHERE username = '\(self.invites[index].invitee)'"
                                DatabaseConnection.GetUser(query)
                                    { responseObject, error in
                                        //CHECK FOR ERRORS
                                        if responseObject != nil
                                        {
                                            self.users = responseObject!
                                            println(self.users[0].email)
                                            self.poolConfirmation(self.gift.name, email: self.users[0].email)
                                        }
                                }
                                
                            }
                            println("RESPONSE HERE")
                            
                            
                    }
                }
            }
            
            let query = "UPDATE WishListGifts SET name='\(self.gift.name)', description='\(self.gift.description)', price=\(self.gift.price), pooling='\(poolingString)' WHERE id=\(self.gift.databaseID)"
            
            println("\(query)")
            
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
            self.stripInputs()
        }
    }
    
    private func stripInputs() {
        
        self.gift.name = self.nameLabel.text
        self.gift.description = self.descriptionTextView.text
        var s = self.priceLabel.text as NSString
        s = s.stringByReplacingOccurrencesOfString("$", withString: "")
        self.gift.price = s.doubleValue
        self.gift.allowPooling = self.poolingSwitch.on
    }
}
