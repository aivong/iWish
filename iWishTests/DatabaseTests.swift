//
//  DatabaseTests.swift
//  iWish
//
//  Created by Zachary Bohlin on 3/5/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

import UIKit
import XCTest
import iWish
import AlamoFire

class DatabaseTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testFriendRequestSentAndGetFriendRequest() {
        DatabaseConnection.AddFriendRequest("testuserrequester", requestee: "testuserrequestee"){ responseObject, error in
            DatabaseConnection.GetFriendRequestsForUser("testuserrequester"){responseObject, error in
                XCTAssertTrue(responseObject?.count == 1, "Passed friend request")
            }
        }
        XCTAssert(true, "Pass")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
