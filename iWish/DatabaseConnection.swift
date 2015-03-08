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

    class func GetImage(query: String, completionHandler: (responseObject: UIImage?, error: NSError?)->()){
        let password = "A7B129MNP"
        Alamofire.request(.GET, "http://cs429iwish.web.engr.illinois.edu/Webservice/service.php", parameters: ["password": password, "query":query]).responseJSON() {
            (_, _, data, error) in
            
            if data != nil{
                let json = JSON(data!)
                if json == [] {
                    completionHandler(responseObject: nil, error: error)
                }
                else {
                    for i in 0..<json.count{
                        let image: UIImage = (json[i]["image"]).rawValue as UIImage
                        
                        
                        completionHandler(responseObject: image, error: error)
                    }
                }
                
            }
        }
        
    }

}