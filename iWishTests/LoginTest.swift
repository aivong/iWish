//
//  LoginTest.swift
//  iWish
//
//  Created by Ai Vong on 4/13/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import UIKit
import XCTest


class LoginTest: XCTestCase {
    
    var vc : LoginViewController!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        var storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: self.dynamicType))
        vc = storyboard.instantiateViewControllerWithIdentifier("LoginVC") as LoginViewController
        vc.loadView()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
