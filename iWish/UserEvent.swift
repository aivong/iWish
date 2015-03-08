//
//  UserEvent.swift
//  iWish
//
//  Created by kamenye2 on 2/22/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import Foundation

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
}