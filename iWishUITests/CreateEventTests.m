//
//  CreateEventTests.m
//  iWish
//
//  Created by Kevin French on 4/13/15.
//  Copyright (c) 2015 WIS CS428. All rights reserved.
//

#import "CreateEventTests.h"
#import "KIFUITestActor.h"

@implementation CreateEventTests

-(void)testSomething {
    
    //Nothing really happens
    [tester tapViewWithAccessibilityLabel:@"logInButton"];
    [tester waitForViewWithAccessibilityLabel:@"passwordTextField"];
}

@end
