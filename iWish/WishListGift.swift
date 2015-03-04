//
//  WishListGift.swift
//  iWish
//
//  Created by Zachary Bohlin on 2/12/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import Foundation
import UIKit

class WishListGift{
    
    var databaseID:Int!
    var name:String!
    var description:String!
    var price:Int!
    var image:UIImage?
    var isPooling:Bool
    
    init(giftID: Int, giftName:String, giftDescription:String, giftPrice:Int, pooling:Bool){
        self.databaseID = giftID
        self.name = giftName
        self.description = giftDescription
        self.price = giftPrice
        self.isPooling = pooling
    }
    
    func descripe () -> String {
        return "Name: \(name)\nDescription: \(description)\nPrice: \(price)\nPooling: \(isPooling)\nDatabaseID: \(databaseID)"
    }
    
    
}