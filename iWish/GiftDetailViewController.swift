//
//  GiftDetailViewController.swift
//  iWish
//
//  Created by Zachary Bohlin on 2/15/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import UIKit

class GiftDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var descriptionTextField: UITextView!
    
    @IBOutlet weak var giftPoolingSwitch: UISwitch!
    
    let editGiftSegueIdentifier = "EditGiftSegue"
    
    var gift : WishListGift!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateViewWithGiftInformation()
        
        let editButton = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: "editPressed:")
        
        self.navigationItem.rightBarButtonItem = editButton
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addStyleToView()
    }
    
    
    func addStyleToView() {
        iWishStylingTool.addStyleToSubviewsOfView(self.view)
    }
    
    func updateViewWithGiftInformation() {
        
        nameLabel.text = gift.name
        priceLabel.text = "$" + String(format:"%.2f", gift.price)
        descriptionTextField.text = gift.description
        descriptionTextField.userInteractionEnabled = false
        giftPoolingSwitch.on = gift.allowPooling
        giftPoolingSwitch.userInteractionEnabled = false;
        
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
            let editGiftViewController = segue.destinationViewController as EditGiftViewController
            editGiftViewController.gift = self.gift
        }
    }
    
    @IBAction func giftEditSaved(segue: UIStoryboardSegue) {
        let editGiftViewController = segue.sourceViewController as EditGiftViewController
        
        self.gift = editGiftViewController.gift
        
        self.updateViewWithGiftInformation()
    }
}
