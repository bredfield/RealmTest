//
//  TestUser.swift
//  RealmTest
//
//  Created by Ben Redfield on 1/19/15.
//  Copyright (c) 2015 bredfield. All rights reserved.
//

class TestUser: RLMObject {
    dynamic var token = ""
    
    struct defaults {
        static let tokenKey = "userToken"
    }
    
    override class func primaryKey() -> String {
        return "token"
    }
    
    override init() {
        super.init()
    }
    
    init(_ token: String) {
        self.token = token
        super.init()
    }
}

//Creation & Deletion
extension TestUser {
    class func createUserWithToken(token: String)-> TestUser {
        let user = TestUser(token)
        
        let realm = RLMRealm.defaultRealm()
        
        realm.beginWriteTransaction()
        realm.addOrUpdateObject(user)
        realm.commitWriteTransaction()
        
        return user
    }
    
    func deleteUser() {
        //Remove current user
        let realm = RLMRealm.defaultRealm()
        realm.beginWriteTransaction()
        realm.deleteObject(self)
        realm.commitWriteTransaction()
    }
    
    class func currentUser(token: String) -> TestUser? {
        let predicate = NSPredicate(format: "token = %@", token)
        return TestUser.objectsWithPredicate(predicate).firstObject() as? TestUser
    }
}