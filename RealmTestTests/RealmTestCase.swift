//
//  RealmTestTests.swift
//  RealmTestTests
//
//  Created by Ben Redfield on 1/19/15.
//  Copyright (c) 2015 bredfield. All rights reserved.
//

import UIKit
import XCTest


/**
Global overrides & test methods
*/
func testRealmPath() -> String {
    return realmPathForFile("test.realm")
}

func defaultRealmPath() -> String {
    return realmPathForFile("default.realm")
}

func realmPathForFile(fileName: String) -> String {
    #if os(iOS)
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return (paths[0] as String) + "/" + fileName
        #else
        return fileName
    #endif
}

func realmLockPath(path: String) -> String {
    return path + ".lock"
}

func deleteRealmFilesAtPath(path: String) {
    let fileManager = NSFileManager.defaultManager()
    if fileManager.fileExistsAtPath(path) {
        let succeeded = NSFileManager.defaultManager().removeItemAtPath(path, error: nil)
        assert(succeeded, "Unable to delete realm")
    }
    
    let lockPath = realmLockPath(path)
    if fileManager.fileExistsAtPath(lockPath) {
        let succeeded = NSFileManager.defaultManager().removeItemAtPath(lockPath, error: nil)
        assert(succeeded, "Unable to delete realm")
    }
}

func realmWithTestPathAndSchema(schema: RLMSchema?) -> RLMRealm {
    return RLMRealm(path: testRealmPath(), readOnly: false, error: nil)
}

class RealmTestCase: XCTestCase {
    
    func realmWithTestPath() -> RLMRealm {
        return RLMRealm(path: testRealmPath(), readOnly: false, error: nil)
    }
    
    override func setUp() {
        super.setUp()
        // Delete realm files
        deleteRealmFilesAtPath(defaultRealmPath())
        deleteRealmFilesAtPath(testRealmPath())
        RLMRealm.setDefaultRealmPath(realmWithTestPath().path)
    }
    
    override func tearDown() {
        super.tearDown()
        
        // Reset Realm cache
        RLMRealm.resetRealmState()
        // Delete realm files
        deleteRealmFilesAtPath(defaultRealmPath())
        deleteRealmFilesAtPath(testRealmPath())
    }
    
}
