//
//  DatabaseConnection.swift
//  iWish
//
//  Created by Zachary Bohlin on 2/12/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

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
    
<<<<<<< HEAD
    //Functions to Create an account
    class func InsertUser(query: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        InsertUserQuery(query, completionHandler: completionHandler)
||||||| merged common ancestors
    //Functions to update gifts
    class func UpdateGift(gift: WishListGift, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        UpdateGiftQuery(gift, completionHandler: completionHandler)
=======
    //Functions to return events
    class func GetEvents(query: String, completionHandler: (responseObject: [UserEvent]?, error: NSError?) -> ()){
        GetEventsList(query, completionHandler: completionHandler)
>>>>>>> Ai
    }
<<<<<<< HEAD
    
    private class func InsertUserQuery(query: String, completionHandler: (responseObject: Bool?, error: NSError?)->()){
||||||| merged common ancestors
    
    private class func UpdateGiftQuery(gift: WishListGift, completionHandler: (responseObject: Bool?, error: NSError?)->()){
        
=======
    private class func GetEventsList(query: String, completionHandler: (responseObject: [UserEvent]?, error: NSError?)->()){
>>>>>>> Ai
        let password = "A7B129MNP"
<<<<<<< HEAD
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":query]).responseJSON() {
||||||| merged common ancestors
        let url = "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php"
        let query = "UPDATE WishListGifts SET name=\(gift.name), description=\(gift.description), price=\(gift.price) WHERE id=\(gift.databaseID)"
        let parameters = ["password": password, "query":query]
        
        Alamofire.request(.GET, url, parameters: parameters).responseJSON() {
=======
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":query]).responseJSON() {
            (_, _, data, error) in
            var events = Array<UserEvent>()
            if data != nil{
                let json = JSON(data!)
                //println(json)
                for i in 0..<json.count{
                    let id = (json[i]["eventID"]).intValue
                    let name = (json[i]["name"]).stringValue
                    let date = (json[i]["date"]).stringValue
                    let description = (json[i]["description"]).stringValue
                    events.append(UserEvent(eventID: id, eventName: name, eventDate: date, eventDescription: description))
                    
                   
                }
              //  println(events.count)
                 completionHandler(responseObject: events, error: error)
            }
            else{
                completionHandler(responseObject: nil, error: error)
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
>>>>>>> Ai
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
            println(data)
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

<<<<<<< HEAD
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
||||||| merged common ancestors
            if data != nil {
                var users = Array<Users>()
=======
            if data != nil{
                var users = Array<Users>()
>>>>>>> Ai
                let json = JSON(data!)
<<<<<<< HEAD
                for i in 0..<json.count{
                    let id = (json[i]["eventID"]).intValue
                    let name = (json[i]["name"]).stringValue
                    let date = (json[i]["date"]).stringValue
                    let description = (json[i]["description"]).stringValue
                    print(name)
                    events.append(UserEvent(eventID: id, eventName: name, eventDate: date, eventDescription: description))
                    
                    completionHandler(responseObject: events, error: error)
||||||| merged common ancestors
                println(json)
                if json == [] {
                    println("EMPTY")
                    completionHandler(responseObject: nil, error: error)
=======
                if json == [] {
                    completionHandler(responseObject: nil, error: error)
>>>>>>> Ai
                }
<<<<<<< HEAD
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
                        users.append(Users(username: username2, password: ""))
                    }
                    else{
                        users.append(Users(username: username1, password: ""))
||||||| merged common ancestors
                else {
                    for i in 0..<json.count{
                        let username = (json[i]["username"]).stringValue
                        let password = (json[i]["password"]).stringValue
                        let email = (json[i]["email"]).stringValue
                        users.append(Users(username: username, password: password, email: email))
                        
                        completionHandler(responseObject: users, error: error)
=======
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
>>>>>>> Ai
                    }
                    
                    
                    completionHandler(responseObject: users, error: error)
                }

            }
            else{
                completionHandler(responseObject: nil, error: error)
            }
        }
        
    }
<<<<<<< HEAD
    
    class func GetFriendRequestsForUser(username: String, completionHandler: (responseObject: [Users]?, error: NSError?) -> ()){
        let query = "SELECT * FROM Friends WHERE requestee='\(username)' AND areFriendsYet=0 ORDER BY requester"
        GetFriendRequestsForUserDB(query, completionHandler: completionHandler)
    }
    
    private class func GetFriendRequestsForUserDB(query: String, completionHandler: (responseObject: [Users]?, error: NSError?)->()){
||||||| merged common ancestors

||||||| merged common ancestors
    
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
=======

    class func GetImage(query: String, completionHandler: (responseObject: String?, error: NSError?)->()){
>>>>>>> Ai
        let password = "A7B129MNP"
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":query]).responseJSON() {
            (_, _, data, error) in
            
            if data != nil{
<<<<<<< HEAD
                let json = JSON(data!)
                for i in 0..<json.count{
                    let username = (json[i]["requester"]).stringValue
                    users.append(Users(username: username, password: password))
                    
                    completionHandler(responseObject: users, error: error)
||||||| merged common ancestors
                let json = JSON(data!)
                for i in 0..<json.count{
                    let username = (json[i]["username"]).stringValue
                    let password = (json[i]["password"]).stringValue
                    users.append(Users(username: username, password: password))
                    
                    completionHandler(responseObject: users, error: error)
=======
                var json = JSON(data!)
                println(json)

                if json == [] {
                    completionHandler(responseObject: nil, error: error)
>>>>>>> Ai
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
<<<<<<< HEAD
        
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
||||||| merged common ancestors
        
    }

=======
>>>>>>> origin/master
=======
          //println(VerifyState.selectedPic)
       
        }

>>>>>>> Ai
}