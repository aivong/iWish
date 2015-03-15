//
//  WishListGift.swift
//  iWish
//
//  Created by Zachary Bohlin on 2/12/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import Foundation

class WishListGift{
    
    var databaseID:Int!
    var name:String!
    var description:String!
    var price:Double!
    
    init(giftID: Int, giftName:String, giftDescription:String, giftPrice:Double){
        self.databaseID = giftID
        self.name = giftName
        self.description = giftDescription
        self.price = giftPrice
    }
    
    func descripe () -> String {
        return "Name: \(name)\nDescription: \(description)\nPrice: \(price)\nDatabaseID: \(databaseID)"
    }
}