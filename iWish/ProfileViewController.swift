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
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            println("First selected")
        case 1:
            println("Second Segment selected")
        default:
            break; 
        }
    }
    
   
    var users = [Users]()
    var profileImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let queryProfile = "SELECT * FROM Users WHERE username = '\(VerifyState.selectedUser)'"
        let queryImage = "SELECT image FROM pictures WHERE username = '\(VerifyState.selectedUser)'"
                
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
    

        
//        DatabaseConnection.GetImage(queryImage) { responseObject, error in
//            //CHECK FOR ERRORS
//            if responseObject != nil {
//                self.profileImage = responseObject!
//                
//                println(self.profileImage)
//                
//            }
//        }

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
