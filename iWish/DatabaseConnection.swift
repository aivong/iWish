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
    
    //Functions to update gifts
    class func UpdateGift(query: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        InsertGiftQuery(query, completionHandler: completionHandler)
    }
    
    private class func UpdateGiftQuery(query: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){

        let password = "A7B129MNP"
        let url = "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php"
        let parameters = ["password": password, "query":query]
        
        Alamofire.request(.GET, url, parameters: parameters).responseJSON() {
            (_, _, data, error) in
            
            if error != nil{
                completionHandler(responseObject: false, error: error)
            }
            else{
                completionHandler(responseObject: true, error: error)
            }
            
        }
    }

    
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
                    let eventID = (json[i]["eventID"]).intValue
                    let pooling = (json[i]["pooling"]).boolValue
                    gifts.append(WishListGift(giftID: id, giftName: name, giftDescription: description, giftPrice: price, giftEvent: eventID, giftPooling: pooling))
                    completionHandler(responseObject: gifts, error: error)
                }
            }
            else{
                completionHandler(responseObject: nil, error: error)
            }
        }
        
    }
    //UPDATE  `cs429iwi_databases`.`WishListGifts` SET  `eventID` =  '5' WHERE  `WishListGifts`.`id` =21;
    //Functions to handle gifts
    class func HandleGift(query: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        HandleGiftQuery(query, completionHandler: completionHandler)
    }
    
    private class func HandleGiftQuery(query: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
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
    
    class func GetGiftPoolingOption(query: String, completionHandler: (responseObject: Int?, error: NSError?) -> ()){
        GetGiftPoolingOptionQuery(query, completionHandler: completionHandler)
    }
    
    private class func GetGiftPoolingOptionQuery(query: String, completionHandler: (responseObject: Int?, error: NSError?)->()){
        let password = "A7B129MNP"
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":query]).responseJSON() {
            (_, _, data, error) in
            if data != nil{
                let json = JSON(data!)
                let pooling = (json[0]["pooling"]).intValue
                completionHandler(responseObject: pooling, error: error)
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
    
    //Functions to insert gifts
    class func InsertPooledGift(query: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        InsertPooledGiftQuery(query, completionHandler: completionHandler)
    }
    
    private class func InsertPooledGiftQuery(query: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
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
    
    //Functions to insert gifts
    class func DeletePooledGift(query: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        DeletePooledGiftQuery(query, completionHandler: completionHandler)
    }
    
    private class func DeletePooledGiftQuery(query: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
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
    
    //Functions to insert gifts
    class func ExistsPooledGift(query: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        ExistsPooledGiftQuery(query, completionHandler: completionHandler)
    }
    
    private class func ExistsPooledGiftQuery(query: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        let password = "A7B129MNP"
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":query]).responseJSON() {
            (_, _, data, error) in
            if data != nil{
                let json = JSON(data!)
                if json.count > 0 {
                    completionHandler(responseObject: true, error: error)
                }
                else {
                    completionHandler(responseObject: false, error: error)
                }
            }
            else{
                completionHandler(responseObject: nil, error: error)
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
            //println(data)
            var users = Array<Users>()
            if data != nil{
                let json = JSON(data!)
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
                    //print(name)
                    events.append(UserEvent(eventID: id, eventName: name, eventDate: date, eventDescription: description))
                    
                    completionHandler(responseObject: events, error: error)
                }
            }
            else{
                completionHandler(responseObject: nil, error: error)
            }
        }
        
    }
    
    //Functions to return events
    class func GetEventRequests(query: String, completionHandler: (responseObject: [UserEvent]?, error: NSError?) -> ()){
        GetEventRequestsList(query, completionHandler: completionHandler)
    }
    private class func GetEventRequestsList(query: String, completionHandler: (responseObject: [UserEvent]?, error: NSError?)->()){
        let password = "A7B129MNP"
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php",
            parameters: ["password": password, "query":query]).responseJSON() {
            (_, _, data, error) in
            var events = Array<UserEvent>()
            if data != nil{
                let json = JSON(data!)
                for i in 0..<json.count{
                    //println("Data is not nil")
                    //println((json[i]["name"]).stringValue)
                    let id = (json[i]["eventID"]).intValue
                    let name = (json[i]["name"]).stringValue
                    let date = (json[i]["date"]).stringValue
                    let description = (json[i]["description"]).stringValue
                    events.append(UserEvent(eventID: id, eventName: name, eventDate: date, eventDescription: description))
                    
                    completionHandler(responseObject: events, error: error)
                }
            }
            else{
                completionHandler(responseObject: nil, error: error)
            }
        }
        
    }
    
    //Functions to return events
    class func GetUpcomingEvents(query: String, completionHandler: (responseObject: [UserEvent]?, error: NSError?) -> ()){
        GetUpcomingEventsList(query, completionHandler: completionHandler)
    }
    private class func GetUpcomingEventsList(query: String, completionHandler: (responseObject: [UserEvent]?, error: NSError?)->()){
        let password = "A7B129MNP"
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php",
            parameters: ["password": password, "query":query]).responseJSON() {
                (_, _, data, error) in
                var events = Array<UserEvent>()
                if data != nil{
                    let json = JSON(data!)
                    for i in 0..<json.count{
                        let id = (json[i]["eventID"]).intValue
                        let name = (json[i]["name"]).stringValue
                        let date = (json[i]["date"]).stringValue
                        let description = (json[i]["description"]).stringValue
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
    class func DeleteEvent(eventID: Int, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        DeleteEventsQuery(eventID, completionHandler: completionHandler)
    }
    private class func DeleteEventsQuery(eventID: Int, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        let password = "A7B129MNP"
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":"DELETE FROM Events WHERE eventID=\(eventID)"]).responseJSON() {
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
    class func UnbindGifts(eventID: Int, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        UnbindGiftsQuery(eventID, completionHandler: completionHandler)
    }
    private class func UnbindGiftsQuery(eventID: Int, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        let password = "A7B129MNP"
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":"UPDATE WishListGifts SET eventID=99999 WHERE eventID=\(eventID)"]).responseJSON() {
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
    class func UnbindInvites(eventID: Int, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        UnbindInvitesQuery(eventID, completionHandler: completionHandler)
    }
    private class func UnbindInvitesQuery(eventID: Int, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        let password = "A7B129MNP"
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":"DELETE FROM Invites WHERE eventID=\(eventID)"]).responseJSON() {
            (_, _, data, error) in
            if error != nil{
                completionHandler(responseObject: false, error: error)
            }
            else{
                completionHandler(responseObject: true, error: error)
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
                    
                    if username == username1{
                        users.append(Users(username: username2, password: "",fullname: "", email: "", gender: "", mailingaddress: "", birthday: ""))
                    }
                    else{
                        users.append(Users(username: username1, password: "", fullname: "", email: "", gender: "", mailingaddress: "", birthday: ""))
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
                    users.append(Users(username: username, password: password, fullname: "", email: "", gender: "", mailingaddress: "", birthday: ""))
                    
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
    
    class func AcceptOrRemoveEventRequest(invitee: String, eventID: Int, accept: Bool, completionHandler: (responseObject: Bool?, error: NSError?) -> ()){
        var query = ""
        if accept{
            query = "UPDATE Invites SET status = 'confirmed' WHERE invitee = '\(invitee)' AND eventID = '\(eventID)'"
        }
        else{
            query = "DELETE FROM Invites WHERE invitee = '\(invitee)' AND eventID = '\(eventID)'"
        }
        AcceptOrRemoveFriendRequestDB(query, completionHandler: completionHandler)
    }
    
    private class func AcceptOrRemoveEventRequestDB(query: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
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
            //println(data)
            //println(error?.description)
            if data != nil{
                completionHandler(responseObject: true, error: error)
                
            }
            else{
                completionHandler(responseObject: false, error: error)
            }
        }
        
    }
    
    class func GetGuestsForEvent(eventID: Int, status: String, completionHandler: (responseObject: [Invite]?, error: NSError?) -> ()){
        let query = "SELECT * FROM Invites WHERE eventID=\(eventID) AND status='\(status)'"
        GetEventGuests(query, completionHandler: completionHandler)
    }
    
    private class func GetEventGuests(query: String, completionHandler: (responseObject: [Invite]?, error: NSError?)->()){
        let password = "A7B129MNP"
            Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":query]).responseJSON() {
            (_, _, data, error) in
            var guests = Array<Invite>()
            if data != nil{
                let json = JSON(data!)
                for i in 0..<json.count{
                    let inviter = (json[i]["inviter"]).stringValue
                    let invitee = (json[i]["invitee"]).stringValue
                    let eventID = (json[i]["eventID"]).intValue
                    let status = (json[i]["status"]).stringValue
                    guests.append(Invite(inviter: inviter, invitee: invitee, eventID: eventID, status: status))
                    
                    completionHandler(responseObject: guests, error: error)
                }
            }
            else{
                completionHandler(responseObject: nil, error: error)
            }
        }
        
    }
    
    class func InviteFriend(query: String, completionHandler: (responseObject: Bool?, error: NSError?) -> ()){
               InviteFriendDB(query, completionHandler: completionHandler)
    }
    
    private class func InviteFriendDB(query: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        let password = "A7B129MNP"
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":query]).responseJSON() {
            (_, _, data, error) in
            //println(data)
            //println(error?.description)
            if data != nil{
                completionHandler(responseObject: true, error: error)
                
            }
            else{
                completionHandler(responseObject: false, error: error)
            }
        }
        
    }
    
    class func InsertUserSettings(username: String, completionHandler: (responseObject: Bool?, error: NSError?) -> ()){
        
        let query = "INSERT INTO UserSettings (username, notifications, allowSystemEmails, showEmailAddress, showBirthday, allowSearchByUsername) VALUES ('\(username)',1,1,1,1,1)"
        
        InsertUserSettingsDB(query, completionHandler: completionHandler)
        
    }
    
    
    
    private class func InsertUserSettingsDB(query: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        
        let password = "A7B129MNP"
        
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":query]).responseJSON() {
            
            (_, _, data, error) in
            
            //println("Get: \(data)")
            
            if data != nil{
                
                completionHandler(responseObject: true, error: error)
                
                
                
            }
                
            else{
                
                completionHandler(responseObject: false, error: error)
                
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
            
            //println("Get: \(JSON(data!)[0])")
            
            if data != nil && JSON(data!)[0] != nil{
                
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
    
    
    class func SetUserSettings(userSettings: UserSettings, completionHandler: (responseObject: Bool?, error: NSError?) -> ()){
        
        let query = "UPDATE UserSettings SET notifications = \(userSettings.notifications), showEmailAddress = \(userSettings.showEmailAddress), allowSystemEmails = \(userSettings.allowSystemEmails), showBirthday = \(userSettings.showBirthday), allowSearchByUsername = \(userSettings.allowSearchByUsername) WHERE username='\(userSettings.user)'"
        //println(query)
        SetUserSettingsDB(query, completionHandler: completionHandler)
        
    }
    
    
    
    private class func SetUserSettingsDB(query: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        
        let password = "A7B129MNP"
        
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":query]).responseJSON() {
            
            (_, _, data, error) in
            
            //println("Set: \(data)")
            
            if data != nil{
                
                completionHandler(responseObject: true, error: error)
                
            }
                
            else{
                
                completionHandler(responseObject: false, error: error)
                
            }
            
        }
        
        
        
    }
    
    //GetUsersUserSettingsSearchOff
    class func GetProperUsers(usersName: String, completionHandler: (responseObject: [String]?, error: NSError?) -> ()){
        
        let query = "SELECT username FROM UserSettings WHERE allowSearchByUsername = 1 AND username != '\(usersName)'"
        //println(query)
        GetProperUsersDB(query, completionHandler: completionHandler)
        
    }
    
    
    
    private class func GetProperUsersDB(query: String, completionHandler: (responseObject: [String]?, error: NSError?)->()){
        
        let password = "A7B129MNP"
        
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":query]).responseJSON() {
            
            (_, _, data, error) in
            
            //println("Set: \(data)")
            
            if data != nil{
                var ret = [String]()
                let json = JSON(data!)
                for i in 0..<json.count{
                    let u = (json[i]["username"]).stringValue
                    ret.append(u)
                }
                completionHandler(responseObject: ret, error: error)
                
            }
                
            else{
                
                completionHandler(responseObject: nil, error: error)
                
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
    
   
}