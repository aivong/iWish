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
        
        // Do any edititional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelEditEvent(segue: UIStoryboardSegue){
        
    }
    
    @IBAction func updateEvent(segue: UIStoryboardSegue){
        let editEventVC = segue.sourceViewController as EditEventViewController
        let newEventName = editEventVC.eventName.text
        let newEventDate = editEventVC.eventDate.text
        let newEventDesc = editEventVC.eventDescription.text
        let oldEventName = eventNameDetail.text!
        let oledEventDescription = eventDescriptionDetail.text!
        let oldEventDate = eventDateDetail.text!
        
        if newEventName == "" || newEventDate == "" || newEventDesc == ""{
            alertUser("Not Saved",  messageText: "Please fill in all fields", buttonText: "OK")
        }
        else if countElements(newEventName) > 20{
            alertUser("Warning!",  messageText: "Name must be no more than 20 characters", buttonText: "OK")
        }
        else if countElements(newEventDesc) > 500{
            alertUser("Warning!",  messageText: "Description is too long! 500 characters max", buttonText: "OK")
        }
        else{
            super.viewDidLoad()
            
            eventNameDetail.text = newEventName
            eventDescriptionDetail.text = newEventDesc
            eventDateDetail.text = newEventDate
            let query = "UPDATE Events SET name = '\(newEventName)', date = '\(newEventDate)', description = '\(newEventDesc)' WHERE name =  '\(oldEventName)' "
            print(query)
            DatabaseConnection.UpdateEvent(query){ responseObject, error in
                print(error?.localizedDescription)
            }
        }
        
    }
    
    func alertUser(titleText: String, messageText: String, buttonText: String){
        let alertController = UIAlertController(title: titleText, message: messageText, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if(segue.destinationViewController.isKindOfClass(ViewEventGiftsViewController)){
            
            let vc = segue.destinationViewController as ViewEventGiftsViewController
            
            vc.eventID = event.eventID
        }
        if(segue.destinationViewController.isKindOfClass(EventMenuViewController)){
            
            let vc = segue.destinationViewController as EventMenuViewController
            
            vc.event = event
        }
    }
    
}
