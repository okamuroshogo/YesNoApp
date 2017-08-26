//
//  YesNoModel.swift
//  YesNoApp
//
//  Created by shogo okamuro on 2017/08/26.
//  Copyright © 2017 shogo okamuro. All rights reserved.
//

import Foundation

struct YesNoModel {
    
    /**
     ユーザーを作成する
     */
    static func createUser(complete: @escaping (String) -> ()) {
        guard let token = Config.getPreferenceValue(key: .KEY_DEVICE_TOKEN) as? String else {
            //TODO: device tokenをpermission scopeで再取得
            return
        }
        let userID = Config.getPreferenceValue(key: .KEY_USER_ID) as? String
        if let id = userID {
            complete(id)
            return
        }
        
        //FIXME: debug
        if isSimulator() || true {
            complete("1234567890987654321")
            return
        }
        
        APIService.createUser(uuid: token, completionHandler: { userID in
            Config.setPreferenceValue(key: .KEY_USER_ID, value: userID)
            complete(userID)
        }, errorHandler: { error , statusCode in
            print("createUser error: " + "\(String(describing: error))" ,statusCode)
        })
    }
    
    /**
     ステータスを取得する
     */
    static func fetchStatus(userID: UInt, complete: @escaping (Bool) -> ()) {
        APIService.fetchStatus(userID: userID, completionHandler: { status in
            complete(status)
        }) { (error, statusCode) in
            print("fetchStatus error: " + "\(String(describing: error))" ,statusCode)
        }
    }
    
    
    /**
     ステータスを更新する
     */
    static func registStatus(status: Bool, complete: @escaping () -> ()) {
        guard let myUserID = YesNoViewModel.sharedInstance.userID.value,
            let id = UInt(myUserID) else { return }
        APIService.registStatus(status: status, myUserID: id, completionHandler: {
            complete()
        }) { (error, statusCode) in
            print("registStatus error: " + "\(String(describing: error))" ,statusCode)
        }
    }
}
