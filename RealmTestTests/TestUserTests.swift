//
//  TestUserTests.swift
//  RealmTest
//
//  Created by Ben Redfield on 1/19/15.
//  Copyright (c) 2015 bredfield. All rights reserved.
//

import UIKit
import XCTest

class TestUserTests: RealmTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        let token = "testToken"
        
        TestUser.createUserWithToken(token)
        
        let predicate = NSPredicate(format: "token = %@", token)
        let user = TestUser.objectsWithPredicate(predicate).firstObject() as? TestUser
        //This sporadically passes/fails
        XCTAssert(user != nil, "User should exist")
    }
}
