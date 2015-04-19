//
//  EventTests.swift
//  iWish
//
//  Created by Kevin French on 4/9/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import UIKit
import XCTest

class EventTests: XCTestCase {

    let userEvent: UserEvent = UserEvent(eventID: 1, eventName: "Test Event", eventDate: "2015-10-10", eventDescription: "Test description")
    let badUserEvent: UserEvent = UserEvent(eventID: 2, eventName: "Test Event", eventDate: "October 10th", eventDescription: "Test description")
    let oldUserEvent: UserEvent = UserEvent(eventID: 1, eventName: "Test Event", eventDate: "2014-10-10", eventDescription: "Test description")
    
//    var dateFormatter: NSDateFormatter
    let dateFormatter = NSDateFormatter()

    override func setUp() {
        super.setUp()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testValidWeekEventNotificationCreation() {
        
        let createdNotification = self.userEvent.weekEventNotification()!
        
        let fireDate: NSDate = createdNotification.fireDate!
    
        let calendar = NSCalendar.currentCalendar();
        let components = calendar.components(.MonthCalendarUnit | .DayCalendarUnit | .YearCalendarUnit, fromDate: fireDate)
        
        XCTAssertEqual(components.month, 10, "Month was incorrect")
        XCTAssertEqual(components.day, 03, "Day was incorrect")
        XCTAssertEqual(components.year, 2015, "Year was incorrect")
        XCTAssert("Test Event is one week away!" == createdNotification.alertBody, "Expected text is incorrect")
    }
    
    func testValidDayEventNotificationCreation() {
        
        let createdNotification = self.userEvent.dayEventNotification()!
        
        let fireDate: NSDate = createdNotification.fireDate!
        
        let calendar = NSCalendar.currentCalendar();
        let components = calendar.components(.MonthCalendarUnit | .DayCalendarUnit | .YearCalendarUnit, fromDate: fireDate)
        
        XCTAssertEqual(components.month, 10, "Month was incorrect")
        XCTAssertEqual(components.day, 09, "Day was incorrect")
        XCTAssertEqual(components.year, 2015, "Year was incorrect")
        XCTAssert("Test Event is tomorrow!" == createdNotification.alertBody, "Expected text is incorrect")
    }
    
    func testinValidWeekEventNotificationCreation() {
        
        let createdNotification = self.badUserEvent.weekEventNotification()
        
        if let notification = createdNotification {
            XCTAssert(false, "Notification was nil")
        } else {
            XCTAssert(true, "Notification was not nil")
        }
        
    }
    
    func testInvalidDayEventNotificationCreation() {
        
        let createdNotification = self.badUserEvent.dayEventNotification()
        
        if let notification = createdNotification {
            XCTAssert(false, "Notification was nil")
        } else {
            XCTAssert(true, "Notification was not nil")
        }
        
        //XCTAssertNil(createdNotification!, "Created Notification was not nil")
        
    }
    
    func testOldNotificationWontBeScheduled() {
        
        var previousNotifications =  UIApplication.sharedApplication().scheduledLocalNotifications
        
        let createdNotification = self.userEvent.weekEventNotification()
        
        
        println("\n\n\n\n\n\n\n\n\n\n\n\n\n\(createdNotification)\n\n\n\n\n\n\n\n\n\n\n\n\n")
        UIApplication.sharedApplication().scheduleLocalNotification(createdNotification!)
        
        let newNotifications =  UIApplication.sharedApplication().scheduledLocalNotifications
        
        XCTAssertEqual(previousNotifications.count, newNotifications.count, "Created Notifaction was not added")
    }
    
    func testdaysUntilStringValidFuture() {
        
        let today = NSDate()
        let daysAway10 = today.dateByAddingTimeInterval(60*60*24*10)
    
        let daysAway10DateString = dateFormatter.stringFromDate(daysAway10)

        let event: UserEvent = UserEvent(eventID: 1, eventName: "Test Event", eventDate: daysAway10DateString, eventDescription: "Test Event Description")
        let daysUntilString = event.daysUntilString()
        
        XCTAssertEqual(daysUntilString, "10 day(s) away", "Days Until string was incorrect")
    }
    
    func testdaysUntilStringInvalidFuture() {
        
        let event: UserEvent = UserEvent(eventID: 1, eventName: "Test Event", eventDate: "2016-02-31", eventDescription: "Test Event Description")
        let daysUntilString = event.daysUntilString()
        
        XCTAssertEqual(daysUntilString, "", "Days Until string was incorrect")
    }
    
    func testdaysUntilStringValidPast() {
        
        let today = NSDate()
        let daysAway10 = today.dateByAddingTimeInterval(-60*60*24*10)
        
        let daysAway10DateString = dateFormatter.stringFromDate(daysAway10)
        
        let event: UserEvent = UserEvent(eventID: 1, eventName: "Test Event", eventDate: daysAway10DateString, eventDescription: "Test Event Description")
        let daysUntilString = event.daysUntilString()
        
        XCTAssertEqual(daysUntilString, "10 day(s) ago", "Days Until string was incorrect")
    }
    
    func testdaysUntilStringInvalidPast() {
        let event: UserEvent = UserEvent(eventID: 1, eventName: "Test Event", eventDate: "2014-02-31", eventDescription: "Test Event Description")
        let daysUntilString = event.daysUntilString()
        
        XCTAssertEqual(daysUntilString, "", "Days Until string was incorrect")
    }
    
    func testdaysUntilStringToday() {
        
        let today = NSDate()
        
        let daysAway10DateString = dateFormatter.stringFromDate(today)
        
        let event: UserEvent = UserEvent(eventID: 1, eventName: "Test Event", eventDate: daysAway10DateString, eventDescription: "Test Event Description")
        let daysUntilString = event.daysUntilString()
        
        XCTAssertEqual(daysUntilString, "Today!", "Days Until string was incorrect")
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
