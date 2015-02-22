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
    
    init(giftID: Int, giftName:String, giftDescription:String, giftPrice:Double){
        self.eventID = giftID
        self.name = giftName
        self.date = giftDescription
    }
    
    func descripe () -> String {
//        return "Name: \(name)\nDescription: \(description)\nPrice: \(price)\nDatabaseID: \(databaseID)"
        return "";
    }
}