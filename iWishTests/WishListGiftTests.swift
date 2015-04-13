
//

//  WishListGIftTests.swift

//  iWish

//

//  Created by Zachary Bohlin on 4/13/15.

//  Copyright (c) 2015 WIS CS428. All rights reserved.

//



import XCTest



class WishListGIftTests: XCTestCase {
    
    
    
    override func setUp() {
        
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    
    
    override func tearDown() {
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        super.tearDown()
        
    }
    
    
    
    func testWishListGiftDescription() {
        
        let giftName = "Gift"
        
        let wlg = WishListGift(giftID: 0, giftName: giftName, giftDescription: "Description", giftPrice: 9.99, giftEvent: 0)
        
        XCTAssertTrue(wlg.describe().rangeOfString(giftName) != nil)
        
        
        
    }
    
    
    
    func testPerformanceExample() {
        
        // This is an example of a performance test case.
        
        self.measureBlock() {
            
            // Put the code you want to measure the time of here.
            
        }
        
    }
    
    
    
}

