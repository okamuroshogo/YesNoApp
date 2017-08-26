//
//  UserDefaults.swift
//  NHKComming
//
//  Created by shogo okamuro on 2016/11/13.
//  Copyright © 2016 ro.okamu. All rights reserved.
//

import Foundation


enum PreferenceKey: String {
    case KEY_DEVICE_TOKEN       = "USER_DEVICE_TOKEN"
    case KEY_USER_ID            = "MY_USER_ID"
    case KEY_PARTNER_ID         = "MY_PARTNER_ID"

}
//UserDefault
extension Config {
    static func getPreferenceValue(key: PreferenceKey) -> Any? {
        return UserDefaults.standard.object(forKey: key.rawValue)
    }
    static func setPreferenceValue(key: PreferenceKey, value: Any) {
        let ud = UserDefaults.standard
        ud.set(value, forKey: key.rawValue)
        ud.synchronize()
    }
    static func removePreferenceValue(key: PreferenceKey) {
        let ud = UserDefaults.standard
        ud.removeObject(forKey: key.rawValue)
        ud.synchronize()
    }
}
