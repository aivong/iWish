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
    
    var giftName: String!
    var giftDescription: String!
    var giftPrice: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        giftNameDetail.text = giftName
        giftDescriptionDetail.text = giftDescription
        giftPriceDetail.text = "$" + String(format:"%.2f", giftPrice)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
