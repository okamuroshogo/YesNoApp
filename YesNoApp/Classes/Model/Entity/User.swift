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
    @objc dynamic var uuid            : String    = ""
    @objc dynamic var name            : String    = ""
    @objc dynamic var status          : Bool      = false
    
    required init() {
        super.init()
    }
    
    convenience init(uuid: String, name: String){
        self.init()
        let next = (RealmData.sharedInstance.realm.objects(User.self).sorted(byKeyPath: "id", ascending: false).first?.id ?? 0) + 1
        self.id             = next
        self.uuid           = uuid
        self.name           = name
        self.status = false
    }
    
    func update(name: String) {
        self.name           = name
    }
    
    static func findOrCreatedBy(uuid: String, name: String) -> (User, Bool) {
        if let user = RealmData.sharedInstance.realm.objects(User.self).filter("uuid = '\(uuid)'").first {
            return (user, false)
        } else {
            let user = User(uuid: uuid, name: name)
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
    
    
    override static func indexedProperties() -> [String] {
        return ["uuid"]
    }

    
}
