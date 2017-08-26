//
//  User.swift
//  YesNoApp
//
//  Created by shogo okamuro on 2017/08/26.
//  Copyright © 2017 shogo okamuro. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class User: Object {
    @objc dynamic var id              : Int      = 0
    @objc dynamic var name            : String    = ""
    
    
    required init() {
        super.init()
    }
    
    convenience init(userID: UInt){
        self.init()
        self.id             = Int(userID)
    }
    
    func update(name: String) {
        self.name           = name
    }
    
    static func findOrCreatedBy(userID: UInt) -> (User, Bool) {
        if let user = RealmData.sharedInstance.realm.objects(self).filter("id == \(userID)").first {
            return (user, false)
        } else {
            let user = User(userID: userID)
            RealmData.sharedInstance.save(data: user)
            return (user, true)
        }
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    
//    override static func indexedProperties() -> [String] {
//        return ["prefectureId"]
//    }
//
    
}
