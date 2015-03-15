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
<<<<<<< HEAD
||||||| merged common ancestors
    var email:String!
=======
    var fullname:String!
    var email:String!
    var gender:String!
    var mailingaddress:String!
    var birthday:String!
>>>>>>> Ai
    
<<<<<<< HEAD
    init(username: String, password:String){
||||||| merged common ancestors
    init(username: String, password:String, email:String){
=======
    init(username: String, password:String, fullname:String, email:String, gender:String, mailingaddress:String, birthday:String){
>>>>>>> Ai
        self.username = username
        self.password = password
<<<<<<< HEAD
||||||| merged common ancestors
        self.email = email
=======
        self.fullname = fullname
        self.email = email
        self.gender = gender
        self.mailingaddress = mailingaddress
        self.birthday = birthday
>>>>>>> Ai
    }
}