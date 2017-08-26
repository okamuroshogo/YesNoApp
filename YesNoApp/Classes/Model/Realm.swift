//
//  Realm.swift
//  Mona
//
//  Created by shogo okamuro on 2017/01/21.
//  Copyright © 2017 ro.okamu. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        
        return array
    }
}

class RealmData {
    class var sharedInstance: RealmData { struct Singleton { static let instance: RealmData = RealmData() }; return Singleton.instance }
    let realm :Realm
    
    private init() {
        let config = Realm.Configuration(schemaVersion: 18, migrationBlock: nil)
        Realm.Configuration.defaultConfiguration = config
        do {
            self.realm = try Realm()
        }
        catch let error {
            print(error)
            self.realm = try! Realm()
        }
    }
    
    //データの保存
    
    func save<T :Object>(data: T) {
        let lockQueue = DispatchQueue(label: "ro.okamu.mona.realm")
        lockQueue.sync {
        do {
            let realm = self.realm
            try realm.write {
                realm.add(data, update: true)
            }
            return
        }
        catch { return }
        }
    }
    
    func save<T :Object>(datas :[T]) {
        let lockQueue = DispatchQueue(label: "ro.okamu.mona.realm")
        lockQueue.sync {
        do {
            let realm = self.realm
            try realm.write {
                realm.add(datas, update: true)
            }
            return
        }
        catch {
            return
        }
    }
    }
    
   
    
    //データの削除
    func deleteAllRecord<T :Object>(results :Results<T>) -> Bool {
        do {
            let realm = self.realm
            try realm.write {
                realm.delete(results)
            }
            
            return true
        }
        catch { return false }
    }
    
    // record
    func delete<T :Object>(object :T) -> Bool {
        do {
            let realm = self.realm 
            try realm.write {
                realm.delete(object)
            }
            return true
        }
        catch { return false }
    }
    
}
