//
//  UserEvent.swift
//  iWish
//
//  Created by kamenye2 on 2/22/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import Foundation
import UIKit

class UserEvent{
    
    var eventID:Int!
    var name:String!
    var date:String!
    var description:String!
    
    init(eventID: Int, eventName:String, eventDate:String, eventDescription:String){
        self.eventID = eventID
        self.name = eventName
        self.date = eventDate
        self.description = eventDescription
    }
    
    func descripe () -> String {
        //        return "Name: \(name)\nDescription: \(description)\nPrice: \(price)\nDatabaseID: \(databaseID)"
        return "";
    }
    
    func getEventDateFromString() -> NSDate? {
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.dateFromString(self.date)
    }
    
    func weekEventNotification() -> UILocalNotification? {
        
        var weekNotification = UILocalNotification()
        weekNotification.timeZone = NSTimeZone.defaultTimeZone()
        weekNotification.alertBody = self.name + " is one week away!"
        
        var date = self.getEventDateFromString()
        
        if let eventDate = date {
            
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components(.MonthCalendarUnit | .DayCalendarUnit | .YearCalendarUnit, fromDate: eventDate)
            components.hour = 10
            components.minute = 0
            components.second = 0
            
            let c = NSCalendar(identifier: NSGregorianCalendar)
            var fireDate = calendar.dateFromComponents(components)
            fireDate = fireDate?.dateByAddingTimeInterval(-60*60*24*7)
            
            weekNotification.fireDate = fireDate
            
            return weekNotification
            
        } else {
            return nil
        }
    }
    
    func dayEventNotification() -> UILocalNotification? {
    
        var dayNotification = UILocalNotification()
        dayNotification.timeZone = NSTimeZone.defaultTimeZone()
        dayNotification.alertBody = self.name + " is tomorrow!"
        
        var date = self.getEventDateFromString()
        
        if let eventDate = date {

            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components(.MonthCalendarUnit | .DayCalendarUnit | .YearCalendarUnit, fromDate: eventDate)
            components.hour = 10
            components.minute = 0
            components.second = 0
            
            let c = NSCalendar(identifier: NSGregorianCalendar)
            var fireDate = calendar.dateFromComponents(components)
            fireDate = fireDate?.dateByAddingTimeInterval(-60*60*24)
            
            dayNotification.fireDate = fireDate
            
            return dayNotification
            
        } else {
            return nil
        }
    }
    
    func daysUntilString() -> String {
        
        let eventDate = getEventDateFromString()
        
        let eventDateMili = eventDate?.timeIntervalSince1970
        let today = NSDate()
        
        let miliDifference = eventDate?.timeIntervalSinceDate(NSDate())
        
        if let dif = miliDifference {
            
            let numberOfDays = (Double(dif) / (60.0*60.0*24.0)) + 1
            
            if (dif > 0) {
                return "\(Int(numberOfDays)) day(s) away"
            } else {
                return "\(Int(numberOfDays) * -1) day(s) ago"
            }
         
        } else {
            return ""
        }
    }
}