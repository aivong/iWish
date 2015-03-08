//
//  EventDetailViewController.swift
//  iWish
//
//  Created by kamenye2 on 2/22/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var eventNameDetail: UILabel!
    @IBOutlet weak var eventDateDetail: UILabel!
    @IBOutlet weak var eventDescriptionDetail: UILabel!
    
    var event : UserEvent!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventNameDetail.text = event.name
        eventDescriptionDetail.text = event.description
        eventDateDetail.text = event.date
        
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