//
//  Invite.swift
//  iWish
//
//  Created by chutipo2 on 3/15/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import Foundation


class Invite{
    
    var inviter:String!
    var invitee:String!
    var eventID:Int!
    var status:String!
    
    init(inviter: String, invitee:String, eventID:Int, status:String){
        self.inviter = inviter
        self.invitee = invitee
        self.eventID = eventID
        self.status = status
    }
    
}