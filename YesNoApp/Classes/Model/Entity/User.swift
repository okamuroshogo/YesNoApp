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
import SwiftyJSON

class User: Object {
    @objc dynamic var id              : Int      = 0
    @objc dynamic var uuid            : String    = ""
    
    
    required init() {
        super.init()
    }
    
    convenience init(fromJson json: JSON!){
        self.init()
        self.id             = json["id"].intValue
        self.update(fromJson: json)
    }
    
    func update(fromJson json: JSON) {
        self.uuid           = json["uuid"].stringValue
        
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
