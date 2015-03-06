//
//  Users.swift
//  iWish
//
//  Created by Zachary Bohlin on 2/12/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import Foundation

class Users {
    
    var username:String!
    var password:String!
    var email:String!
    
    init(username: String, password:String, email:String){
        self.username = username
        self.password = password
        self.email = email
    }
}