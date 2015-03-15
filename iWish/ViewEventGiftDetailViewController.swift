//
//  ViewEventGiftDetailViewController.swift
//  iWish
//
//  Created by chutipo2 on 3/8/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import UIKit

class ViewEventGiftDetailViewController: UIViewController {
    
    @IBOutlet weak var giftNameDetail: UILabel!
    @IBOutlet weak var giftPriceDetail: UILabel!
    @IBOutlet weak var giftDescriptionDetail: UILabel!
    
    
    var gift : WishListGift!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        giftNameDetail.text = gift.name
        giftDescriptionDetail.text = gift.description
        giftPriceDetail.text = String(format:"%.3f", gift.price)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

