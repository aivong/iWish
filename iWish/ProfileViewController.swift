//
//  ProfileViewController.swift
//  iWish
//
//  Created by Ai Vong on 3/7/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var mailingAddress: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    
    var profileImage: UIImage!
    var users = [Users]()
    var file: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let queryImage = "SELECT * FROM pictures WHERE username = '\(VerifyState.selectedUser)'"
        // Do any additional setup after loading the view.
        
        
        let queryProfile = "SELECT * FROM Users WHERE username = '\(VerifyState.selectedUser)'"
        
        
        
        DatabaseConnection.GetUser(queryProfile) { responseObject, error in
            //CHECK FOR ERRORS
            if responseObject != nil {
                self.users = responseObject!
                self.fullName.text = self.users[0].fullname
                self.birthday.text = self.users[0].birthday
                self.gender.text = self.users[0].gender
                self.email.text = self.users[0].email
                self.mailingAddress.text = self.users[0].mailingaddress
                
            }
        }
        
        println(queryImage)
        DatabaseConnection.GetImage(queryImage) { responseObject, error in
            //CHECK FOR ERRORS
            if responseObject != nil {
                
                let profileImage : UIImage = UIImage(named: "/Users/aivong/Desktop/iWishimage/" + VerifyState.selectedPic)!
                let imageview = UIImageView(image: profileImage)
                imageview.frame = CGRectMake(31, 26, 172, 191)
                self.view.addSubview(imageview)
                
                self.file = responseObject!
            }
        }
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}