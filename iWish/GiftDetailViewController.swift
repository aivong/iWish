//
//  GiftDetailViewController.swift
//  iWish
//
//  Created by Zachary Bohlin on 2/15/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import UIKit

class GiftDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate {
    
    var gift : WishListGift!
    
    let rightTextViewCellIndentifier: String = "rightTextViewCell"
    let largeImageViewCellIdentifier: String = "largeImageViewCell"
    let rightBoxCellIdentifier: String = "rightBoxCell"
    let rightDetailCellIdentifier: String = "rightDetailCell"
    let centerLabelCellIdentifier: String = "centerLabelCell"
    
    let fullNumberOfCells = 6
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNibs()
        
        let editButton = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: "editPressed:")
        
        self.navigationItem.rightBarButtonItems?.append(editButton)
    }
    
    
    

    func editPressed(sender: AnyObject) {
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("EditGiftViewController") as? EditGiftViewController
        
        if let vc = viewController {
            vc.gift = self.gift
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if gift.image != nil {
            tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0), atScrollPosition: .Top, animated: true)
        }
        
        
    }
    
    func loadNibs() {
        
        let nib1 = UINib(nibName: "RightTextViewTableViewCell", bundle: nil)
        self.tableView.registerNib(nib1, forCellReuseIdentifier: rightTextViewCellIndentifier)
        
        let nib3 = UINib(nibName: "LargeImageViewTableViewCell", bundle: nil)
        self.tableView.registerNib(nib3, forCellReuseIdentifier: largeImageViewCellIdentifier)
        
        let nib4 = UINib(nibName: "RightBoxTableViewCell", bundle: nil)
        self.tableView.registerNib(nib4, forCellReuseIdentifier: rightBoxCellIdentifier)
        
        let nib6 = UINib(nibName: "CenterLabelTableViewCell", bundle: nil)
        self.tableView.registerNib(nib6, forCellReuseIdentifier: centerLabelCellIdentifier)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier(rightDetailCellIdentifier) as UITableViewCell
        
        if gift.image == nil {
        
            if indexPath.row == 0 {
                cell = tableView.dequeueReusableCellWithIdentifier(centerLabelCellIdentifier) as UITableViewCell
            } else if indexPath.row == 1 {
                cell = tableView.dequeueReusableCellWithIdentifier(rightDetailCellIdentifier) as UITableViewCell
            } else if indexPath.row == 2 {
                cell = tableView.dequeueReusableCellWithIdentifier(rightTextViewCellIndentifier) as UITableViewCell
                var c = cell as RightTextViewTableViewCell
                c.textView.editable = false
            } else if indexPath.row == 3{
                cell = tableView.dequeueReusableCellWithIdentifier(rightDetailCellIdentifier) as UITableViewCell
            }
            
        } else {
            
            if indexPath.row == 0 {
                cell = tableView.dequeueReusableCellWithIdentifier(centerLabelCellIdentifier) as UITableViewCell
            } else if indexPath.row == 1 {
                cell = tableView.dequeueReusableCellWithIdentifier(largeImageViewCellIdentifier) as UITableViewCell
            } else if indexPath.row == 2 {
                cell = tableView.dequeueReusableCellWithIdentifier(rightDetailCellIdentifier) as UITableViewCell
            } else if indexPath.row == 3 {
                cell = tableView.dequeueReusableCellWithIdentifier(rightTextViewCellIndentifier) as UITableViewCell
            } else if indexPath.row == 4{
                cell = tableView.dequeueReusableCellWithIdentifier(rightDetailCellIdentifier) as UITableViewCell
            }
        }
    
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if gift.image != nil {
            return fullNumberOfCells
        } else {
            return fullNumberOfCells - 1
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.selectionStyle = .None
        
        if cell.isKindOfClass(CenterLabelTableViewCell) {
            var c = cell as CenterLabelTableViewCell
            c.label?.text = gift.name
        } else if cell.isKindOfClass(LargeImageViewTableViewCell) {
            var c = cell as LargeImageViewTableViewCell
            var imageView = UIImageView(image: gift?.image)
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            c.backgroundView = imageView
        } else if cell.isKindOfClass(RightTextViewTableViewCell) {
            var c = cell as RightTextViewTableViewCell
            c.label?.text = "Gift Description"
            c.textView?.text = gift.description
        } else {
            
            if gift.image == nil {
                
                if indexPath.row == 1 {
                    cell.textLabel?.text = "Price"
                    cell.detailTextLabel?.text = String(format:"$%.02f", gift.price)
                } else if indexPath.row == 3 {
                    cell.textLabel?.text = "Allow Gift Pooling"
                    
                    if (gift.isPooling) {
                        cell.detailTextLabel?.text = "On"
                    } else {
                        cell.detailTextLabel?.text = "Off"
                    }
                }
                
            } else {
                
                if indexPath.row == 2 {
                    cell.textLabel?.text = "Price"
                    cell.detailTextLabel?.text = String(format:"$%.02f", gift.price)
                } else if indexPath.row == 4 {
                    cell.textLabel?.text = "Allow Gift Pooling"
                    if (gift.isPooling) {
                        cell.detailTextLabel?.text = "On"
                    } else {
                        cell.detailTextLabel?.text = "Off"
                    }
                }
            }
        }
    }
    
    @IBAction func trashPressed(sender: AnyObject) {
        let alert = UIAlertView(title: "Remove Gift", message: "Are you sure you want to remove  \(gift.name) from this wishlist?", delegate: self, cancelButtonTitle: "No", otherButtonTitles: "Yes")
        alert.show()
    }
    
    func deleteGift() {
        
        DatabaseConnection.DeleteGift(gift.databaseID) { responseObject, error in
            self.popViewController()
        }
    }
    
    func popViewController() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if gift.image != nil {
            if indexPath.row == 1 {
                return 200
            } else if indexPath.row == 3 {
                return 80
            } else {
                return 60
            }
        } else {
            if indexPath.row == 2 {
                return 80
            } else {
                return 60
            }
        }
    
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            self.deleteGift()
        }
    }
    
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
        let source = segue.sourceViewController as EditGiftViewController
        gift = source.gift
        tableView.reloadData()
    }

}
