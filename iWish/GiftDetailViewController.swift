//
//  GiftDetailViewController.swift
//  iWish
//
//  Created by Zachary Bohlin on 2/15/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import UIKit

class GiftDetailViewController: UIViewController {
    
    @IBOutlet weak var giftNameDetail: UILabel!
    @IBOutlet weak var giftPriceDetail: UILabel!
    @IBOutlet weak var giftDescriptionDetail: UILabel!
    
    let editGiftSegueIdentifier = "EditGiftSegue"
    
    var gift : WishListGift!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateViewWithGiftInformation()
        
        let editButton = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: "editPressed:")
        
        self.navigationItem.rightBarButtonItem = editButton
    }
    
    func updateViewWithGiftInformation() {
        giftNameDetail.text = gift.name
        giftDescriptionDetail.text = gift.description
        giftPriceDetail.text = "$" + String(format:"%.2f", gift.price)
    }
    
    func editPressed(sender: AnyObject) {
        self.performSegueWithIdentifier(editGiftSegueIdentifier, sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == editGiftSegueIdentifier {
            let editGiftViewController = segue.destinationViewController as! EditGiftViewController
            editGiftViewController.gift = self.gift
        }
    }
    
    @IBAction func giftEditSaved(segue: UIStoryboardSegue) {
        let editGiftViewController = segue.sourceViewController as! EditGiftViewController
        
        self.gift = editGiftViewController.gift
        
        self.updateViewWithGiftInformation()
    }
}
