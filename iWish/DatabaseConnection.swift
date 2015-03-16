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
    
//    class func CheckUser(query: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
//        InsertUserQuery(query, completionHandler: completionHandler)
//    }
//    
//    private class func CheckUserQuery(query: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
//        let password = "A7B129MNP"
//        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":query]).responseJSON() {
//            (_, _, data, error) in
//            if data != nil{
//                let json = JSON(data!)
//                if json.count > 0 {
//                    completionHandler(responseObject: true, error: error)
//                }
//            }
//            else{
//                completionHandler(responseObject: false, error: error)
//            }
//        }
//    }
    class func GetUser(query: String, completionHandler: (responseObject: [Users]?, error: NSError?) -> ()){
        GetUsers(query, completionHandler: completionHandler)
    }
    
    private class func GetUsers(query: String, completionHandler: (responseObject: [Users]?, error: NSError?)->()){
        let password = "A7B129MNP"
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":query]).responseJSON() {
            (_, _, data, error) in
            var users = Array<Users>()
            if data != nil{
                let json = JSON(data!)
                for i in 0..<json.count{
                    let username = (json[i]["username"]).stringValue
                    let password = (json[i]["password"]).stringValue
                    users.append(Users(username: username, password: password))
                    
                    completionHandler(responseObject: users, error: error)
                }
            }
            else{
                completionHandler(responseObject: nil, error: error)
            }
        }
        
    }

    //Functions to return events
    class func GetEvents(query: String, completionHandler: (responseObject: [UserEvent]?, error: NSError?) -> ()){
        GetEventsList(query, completionHandler: completionHandler)
    }
    private class func GetEventsList(query: String, completionHandler: (responseObject: [UserEvent]?, error: NSError?)->()){
        let password = "A7B129MNP"
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":query]).responseJSON() {
            (_, _, data, error) in
            var events = Array<UserEvent>()
            if data != nil{
                let json = JSON(data!)
                for i in 0..<json.count{
                    let id = (json[i]["eventID"]).intValue
                    let name = (json[i]["name"]).stringValue
                    let date = (json[i]["date"]).stringValue
                    let description = (json[i]["description"]).stringValue
                    print(name)
                    events.append(UserEvent(eventID: id, eventName: name, eventDate: date, eventDescription: description))
                    
                    completionHandler(responseObject: events, error: error)
                }
            }
            else{
                completionHandler(responseObject: nil, error: error)
            }
        }
        
    }
    
    //Functions to insert events
    class func InsertEvent(query: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        InsertEventsQuery(query, completionHandler: completionHandler)
    }
    private class func InsertEventsQuery(query: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
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
    
    //Functions to insert events
    class func UpdateEvent(query: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        UpdateEventsQuery(query, completionHandler: completionHandler)
    }
    private class func UpdateEventsQuery(query: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
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
    
    //Functions to delete events
    class func DeleteEvent(name: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        DeleteEventsQuery(name, completionHandler: completionHandler)
    }
    private class func DeleteEventsQuery(name: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        let password = "A7B129MNP"
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":"DELETE FROM Events WHERE name=\(name)"]).responseJSON() {
            (_, _, data, error) in
            if error != nil{
                completionHandler(responseObject: false, error: error)
            }
            else{
                completionHandler(responseObject: true, error: error)
            }
            
        }
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