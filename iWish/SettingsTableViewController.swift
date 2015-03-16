//
//  SettingsTableViewController.swift
//  iWish
//
//  Created by Zachary Bohlin on 3/10/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var systemEmailSwitch: UISwitch!
    @IBOutlet weak var showEmailSwitch: UISwitch!
    @IBOutlet weak var showBirthdaySwitch: UISwitch!
    @IBOutlet weak var allowSearchSwitch: UISwitch!

    @IBAction func notificationSwitchChanged(sender: AnyObject) {
        let nsud = NSUserDefaults.standardUserDefaults()
        nsud.setObject(notificationSwitch.on, forKey: "notificationsAllowed")
    }
    
    @IBAction func systemEmailSwitchChanged(sender: AnyObject) {
        let nsud = NSUserDefaults.standardUserDefaults()
        nsud.setObject(systemEmailSwitch.on, forKey: "systemEmailsAllowed")
    }
    
    @IBAction func showEmailSwitchChanged(sender: AnyObject) {
        let nsud = NSUserDefaults.standardUserDefaults()
        nsud.setObject(showEmailSwitch.on, forKey: "showEmailAllowed")
    }
    
    @IBAction func showBirthdayChanged(sender: AnyObject) {
        let nsud = NSUserDefaults.standardUserDefaults()
        nsud.setObject(showBirthdaySwitch.on, forKey: "showBirthdayAllowed")
    }
    
    @IBAction func allowSearchByUsernameChanged(sender: AnyObject) {
        let nsud = NSUserDefaults.standardUserDefaults()
        nsud.setObject(allowSearchSwitch.on, forKey: "searchUsernameAllowed")
    }
    
    @IBAction func saveSettings(sender: AnyObject) {
        let nsud = NSUserDefaults.standardUserDefaults()
        let usern = nsud.stringForKey("username")
        let ns = notificationSwitch.on
        let sea = systemEmailSwitch.on
        let showea = showEmailSwitch.on
        let sba = showBirthdaySwitch.on
        let sua = allowSearchSwitch.on
        let us = UserSettings(user: usern!, notifications: ns, allowSystemEmails: sea, showEmailAddress: showea, allowSearchByUsername: sua, showBirthday: sba)
        
        DatabaseConnection.SetUserSettings(us){ responseObject, error in
            nsud.setObject(ns, forKey: "notificationsAllowed")
            nsud.setObject(sea, forKey: "systemEmailsAllowed")
            nsud.setObject(showea, forKey: "showEmailAllowed")
            nsud.setObject(sba, forKey: "showBirthdayAllowed")
            nsud.setObject(sua, forKey: "searchUsernameAllowed")
        }
    }
    
    @IBAction func logout(sender: AnyObject) {
        self.performSegueWithIdentifier("LogoutSegue", sender: self)
    }
    
    func alertUser(titleText: String, messageText: String, buttonText: String){
        let alertController = UIAlertController(title: titleText, message: messageText, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nsud = NSUserDefaults.standardUserDefaults()
        let na = nsud.boolForKey("notificationsAllowed")
        let sys = nsud.boolForKey("systemEmailsAllowed")
        let sea = nsud.boolForKey("showEmailAllowed")
        let sba = nsud.boolForKey("showBirthdayAllowed")
        let sua = nsud.boolForKey("searchUsernameAllowed")
        
        notificationSwitch.on = na
        systemEmailSwitch.on = sys
        showEmailSwitch.on = sea
        showBirthdaySwitch.on = sba
        allowSearchSwitch.on = sua
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
