//
//  UserSettings.swift
//  iWish
//
//  Created by Zachary Bohlin on 3/13/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import Foundation

class UserSettings{
    
    var user: String!
    var notifications: Bool!
    var allowSystemEmails: Bool!
    var showEmailAddress: Bool!
    var allowSearchByUsername: Bool!
    var showBirthday: Bool!
    
    init(user: String, notifications: Bool, allowSystemEmails: Bool, showEmailAddress: Bool, allowSearchByUsername: Bool, showBirthday: Bool){
        self.user = user
        self.notifications = notifications
        self.allowSystemEmails = allowSystemEmails
        self.showEmailAddress = showEmailAddress
        self.allowSearchByUsername = allowSearchByUsername
        self.showBirthday = showBirthday
    }
}