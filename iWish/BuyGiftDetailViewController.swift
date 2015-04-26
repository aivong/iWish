//
//  GiftDetailViewController.swift
//  iWish
//
//  Created by Zachary Bohlin on 2/15/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import UIKit

class BuyGiftDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var descriptionTextField: UITextView!
    
    @IBOutlet weak var giftPoolingSwitch: UISwitch!
    
    var gift : WishListGift!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateViewWithGiftInformation()
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
