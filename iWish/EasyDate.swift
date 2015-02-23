//
//  EasyDate.swift
//  iWish
//
//  Created by Zachary Bohlin on 2/18/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import Foundation

class EasyDate{
    var year: Int!
    var month: Int!
    var day: Int!
    var hour: Int!
    var minute: Int!
    
    init(year: Int, month: Int, day: Int, hour: Int, minute: Int){
        self.year = year
        self.month = month
        self.day = day
        self.hour = hour
        self.minute = minute
    }
    
    init(date: NSDate){
        let calendarToday = NSCalendar.currentCalendar()
        let componentsToday = calendarToday.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitMonth |  .CalendarUnitDay | .CalendarUnitYear, fromDate: date)
        self.year = componentsToday.year
        self.month = componentsToday.month
        self.day = componentsToday.day
        self.hour = componentsToday.hour
        self.minute = componentsToday.minute
    }
    
    
    func timeUntilDate(date: NSDate) -> EasyDate{
        let today = NSDate()
        let calendarToday = NSCalendar.currentCalendar()
        let c = calendarToday.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitMonth |  .CalendarUnitDay | .CalendarUnitYear, fromDate: today)
        return EasyDate(year: c.year, month: c.month, day: c.day, hour: c.hour, minute: c.minute)
    }
    
    
    
}