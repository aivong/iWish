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
        println("Notification")
    }
    
    @IBAction func systemEmailSwitchChanged(sender: AnyObject) {
        println("System Email")
    }
    
    @IBAction func showEmailSwitchChanged(sender: AnyObject) {
        println("Show Email")
    }
    
    @IBAction func showBirthdayChanged(sender: AnyObject) {
        println("Show Birthday")
    }
    
    @IBAction func allowSearchByUsernameChanged(sender: AnyObject) {
        println("Show Search")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
