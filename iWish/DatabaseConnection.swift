//
//  DatabaseConnection.swift
//  iWish
//
//  Created by Zachary Bohlin on 2/12/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import Foundation
import Alamofire

class DatabaseConnection{
    //Funcitons to return gifts
    class func GetGifts(query: String, completionHandler: (responseObject: [WishListGift]?, error: NSError?) -> ()){
        GetWishListGifts(query, completionHandler: completionHandler)
    }
    
    private class func GetWishListGifts(query: String, completionHandler: (responseObject: [WishListGift]?, error: NSError?)->()){
        let password = "A7B129MNP"
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":query]).responseJSON() {
            (_, _, data, error) in
            var gifts = Array<WishListGift>()
            if data != nil{
            let json = JSON(data!)
            for i in 0..<json.count{
                let id = (json[i]["id"]).intValue
                let name = (json[i]["name"]).stringValue
                let description = (json[i]["description"]).stringValue
                let price = (json[i]["price"]).doubleValue
                gifts.append(WishListGift(giftID: id, giftName: name, giftDescription: description, giftPrice: price))
            
                completionHandler(responseObject: gifts, error: error)
            }
            }
            else{
                completionHandler(responseObject: nil, error: error)
            }
        }
        
    }
    
    //Functions to insert gifts
    class func InsertGift(query: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        InsertGiftQuery(query, completionHandler: completionHandler)
    }
    
    private class func InsertGiftQuery(query: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        let password = "A7B129MNP"
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":query]).responseJSON() {
            (_, _, data, error) in
            if error != nil{
                completionHandler(responseObject: false, error: error)
            }
            else{
                completionHandler(responseObject: true, error: error)
            }
            
        }
    }
    
    //Functions to delete gifts
    class func DeleteGift(giftID: Int, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        DeleteGiftQuery(giftID, completionHandler: completionHandler)
    }
    private class func DeleteGiftQuery(giftID: Int, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        let password = "A7B129MNP"
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":"DELETE FROM WishListGifts WHERE id=\(giftID)"]).responseJSON() {
            (_, _, data, error) in
            if error != nil{
                completionHandler(responseObject: false, error: error)
            }
            else{
                completionHandler(responseObject: true, error: error)
            }
            
        }
    }
    
    //Functions to Create an account
    class func InsertUser(query: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        InsertUserQuery(query, completionHandler: completionHandler)
    }
    
    private class func InsertUserQuery(query: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        let password = "A7B129MNP"
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":query]).responseJSON() {
            (_, _, data, error) in
            if error != nil{
                completionHandler(responseObject: false, error: error)
            }
            else{
                completionHandler(responseObject: true, error: error)
            }
            
        }
    }
    
    class func GetUser(query: String, completionHandler: (responseObject: [Users]?, error: NSError?) -> ()){
        GetUsers(query, completionHandler: completionHandler)
    }
    
    private class func GetUsers(query: String, completionHandler: (responseObject: [Users]?, error: NSError?)->()){
        let password = "A7B129MNP"
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":query]).responseJSON() {
            (_, _, data, error) in
            
            if data != nil{
                var users = Array<Users>()
                let json = JSON(data!)
                if json == [] {
                    completionHandler(responseObject: nil, error: error)
                }
                else {
                    for i in 0..<json.count{
                        let username = (json[i]["username"]).stringValue
                        let password = (json[i]["password"]).stringValue
                        let fullname = (json[i]["fullname"]).stringValue
                        let email =  (json[i]["email"]).stringValue
                        let gender =  (json[i]["gender"]).stringValue
                        let mailingaddress =  (json[i]["mailaddress"]).stringValue
                        let birthday =  (json[i]["birthday"]).stringValue
                        users.append(Users(username: username, password: password, fullname: fullname, email: email, gender: gender, mailingaddress: mailingaddress, birthday: birthday))
                        
                        completionHandler(responseObject: users, error: error)
                    }
                }
                
            }
        }
    }
    
    class func GetFriendsForUser(username: String, completionHandler: (responseObject: [Users]?, error: NSError?) -> ()){

        GetFriendsForUserDB(username, completionHandler: completionHandler)
    }
    
    private class func GetFriendsForUserDB(username: String, completionHandler: (responseObject: [Users]?, error: NSError?)->()){
        let password = "A7B129MNP"
        let query = "SELECT * FROM Friends WHERE (requester='\(username)' OR requestee='\(username)') AND areFriendsYet=1"
        
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":query]).responseJSON() {
            (_, _, data, error) in
            var users = Array<Users>()
            if data != nil{
                let json = JSON(data!)
                for i in 0..<json.count{
                    let username1 = (json[i]["requestee"]).stringValue
                    let username2 = (json[i]["requester"]).stringValue
                    let fullname = (json[i]["fullname"]).stringValue
                    let email =  (json[i]["email"]).stringValue
                    let gender =  (json[i]["gender"]).stringValue
                    let mailingaddress =  (json[i]["mailaddress"]).stringValue
                    let birthday =  (json[i]["birthday"]).stringValue

                    if username == username1{
                        users.append(Users(username: username1, password: password, fullname: fullname, email: email, gender: gender, mailingaddress: mailingaddress, birthday: birthday))
                    }
                    else{
                        users.append(Users(username: username1, password: password, fullname: fullname, email: email, gender: gender, mailingaddress: mailingaddress, birthday: birthday))
                    }
                    
                    
                    completionHandler(responseObject: users, error: error)
                }
            }
            else{
                completionHandler(responseObject: nil, error: error)
            }
        }
        
    }
    
    class func GetFriendRequestsForUser(username: String, completionHandler: (responseObject: [Users]?, error: NSError?) -> ()){
        let query = "SELECT * FROM Friends WHERE requestee='\(username)' AND areFriendsYet=0 ORDER BY requester"
        GetFriendRequestsForUserDB(query, completionHandler: completionHandler)
    }
    
    private class func GetFriendRequestsForUserDB(query: String, completionHandler: (responseObject: [Users]?, error: NSError?)->()){
        let password = "A7B129MNP"
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":query]).responseJSON() {
            (_, _, data, error) in
            var users = Array<Users>()
            if data != nil{
                let json = JSON(data!)
                
                for i in 0..<json.count{
                    let username = (json[i]["requester"]).stringValue
                    let fullname = (json[i]["fullname"]).stringValue
                    let email =  (json[i]["email"]).stringValue
                    let gender =  (json[i]["gender"]).stringValue
                    let mailingaddress =  (json[i]["mailaddress"]).stringValue
                    let birthday =  (json[i]["birthday"]).stringValue
                    users.append(Users(username: username, password: password, fullname: fullname, email: email, gender: gender, mailingaddress: mailingaddress, birthday: birthday))
                    
                    completionHandler(responseObject: users, error: error)
                }
            }
            else{
                completionHandler(responseObject: nil, error: error)
            }
        }
        
    }
    
    class func AddFriendRequest(requester: String, requestee: String, completionHandler: (responseObject: Bool?, error: NSError?) -> ()){
        let query = "" +
        "INSERT INTO Friends (requester, requestee, areFriendsYet) VALUES ('\(requester)', '\(requestee)', 0)"
        AddFriendRequestDB(query, completionHandler: completionHandler)
    }
    
    private class func AddFriendRequestDB(query: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        let password = "A7B129MNP"
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":query]).responseJSON() {
            (_, _, data, error) in
            if data != nil{
                completionHandler(responseObject: true, error: error)
                
            }
            else{
                completionHandler(responseObject: false, error: error)
            }
        }
        
    }
    
    class func AcceptOrRemoveFriendRequest(requester: String, requestee: String, accept: Bool, completionHandler: (responseObject: Bool?, error: NSError?) -> ()){
        var query = ""
        if accept{
            query = "UPDATE Friends SET areFriendsYet = 1 WHERE requester = '\(requester)' AND requestee = '\(requestee)'"
        }
        else{
            query = "DELETE FROM Friends WHERE requester = '\(requester)' AND requestee = '\(requestee)'"
        }
        AcceptOrRemoveFriendRequestDB(query, completionHandler: completionHandler)
    }
    
    private class func AcceptOrRemoveFriendRequestDB(query: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        let password = "A7B129MNP"
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":query]).responseJSON() {
            (_, _, data, error) in
            if data != nil{
                completionHandler(responseObject: true, error: error)
                
            }
            else{
                completionHandler(responseObject: false, error: error)
            }
        }
        
    }
    
    class func RemoveFriend(username: String, friendBeingRemoved: String, completionHandler: (responseObject: Bool?, error: NSError?) -> ()){
        let query = "DELETE FROM Friends WHERE (requester = '\(username)' AND requestee = '\(friendBeingRemoved)') OR (requester = '\(friendBeingRemoved)' AND requestee = '\(username)')"
        RemoveFriendDB(query, completionHandler: completionHandler)
    }
    
    private class func RemoveFriendDB(query: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        let password = "A7B129MNP"
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":query]).responseJSON() {
            (_, _, data, error) in
            println(data)
            println(error?.description)
            if data != nil{
                completionHandler(responseObject: true, error: error)
                
            }
            else{
                completionHandler(responseObject: false, error: error)
            }
        }
        
    }
    
    class func GetImage(query: String, completionHandler: (responseObject: String?, error: NSError?)->()){
        let password = "A7B129MNP"
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":query]).responseJSON() {
            (_, _, data, error) in
            
            if data != nil{
                var json = JSON(data!)
                println(json)
                
                if json == [] {
                    completionHandler(responseObject: nil, error: error)
                }
                else {
                    for i in 0..<json.count{
                        var filename = (json[i]["image"]).stringValue
                        //    println(filename)
                        VerifyState.DBFinished = true
                        VerifyState.selectedPic = filename
                        completionHandler(responseObject: filename, error: error)
                    }
                }
                
            }
        }
        //println(VerifyState.selectedPic)
        
    }

    
    class func GetUserSettings(username: String, completionHandler: (responseObject: UserSettings?, error: NSError?) -> ()){
        let query = "SELECT * FROM UserSettings WHERE username='\(username)'"
        GetUserSettingsDB(query, completionHandler: completionHandler)
    }
    
    private class func GetUserSettingsDB(query: String, completionHandler: (responseObject: UserSettings?, error: NSError?)->()){
        let password = "A7B129MNP"
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":query]).responseJSON() {
            (_, _, data, error) in
            println("Get: \(data)")
            if data != nil{
                let json = JSON(data!)
                let usern = json[0]["username"].stringValue
                let not = json[0]["notifications"].boolValue
                let showE = json[0]["showEmailAddress"].boolValue
                let sysE = json[0]["allowSystemEmails"].boolValue
                let showB = json[0]["showBirthday"].boolValue
                let allowSBU = json[0]["allowSearchByUsername"].boolValue
                let usersettings = UserSettings(user: usern, notifications: not, allowSystemEmails: sysE, showEmailAddress: showE, allowSearchByUsername: allowSBU, showBirthday: showB)
                completionHandler(responseObject: usersettings, error: error)
                
            }
            else{
                completionHandler(responseObject: nil, error: error)
            }
        }
        
    }
    
    private class func numToBool(num: NSNumber) -> Bool{
        if num.intValue == 0{
            return false
        }
        else{
            return true
        }
    }
    
    class func SetUserSettings(userSettings: UserSettings, completionHandler: (responseObject: Bool?, error: NSError?) -> ()){
        let query = "UPDATE UserSettings SET notifications = \(userSettings.notifications), showEmailAddress = \(userSettings.showEmailAddress), allowSystemEmails = \(userSettings.allowSystemEmails), showBirthday = \(userSettings.showBirthday), allowSearchByUsername = \(userSettings.allowSearchByUsername)) WHERE username='\(userSettings.user)'"
        SetUserSettingsDB(query, completionHandler: completionHandler)
    }
    
    private class func SetUserSettingsDB(query: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        let password = "A7B129MNP"
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":query]).responseJSON() {
            (_, _, data, error) in
            println("Set: \(data)")
            if data != nil{

                completionHandler(responseObject: true, error: error)
                
            }
            else{
                completionHandler(responseObject: false, error: error)
            }
        }
        
    }

}