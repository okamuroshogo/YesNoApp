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
    static func createUser(complete: @escaping (UInt) -> ()) {
        guard let token = Config.getPreferenceValue(key: .KEY_DEVICE_TOKEN) as? String else {
            //TODO: device tokenをpermission scopeで再取得
            print("not found device token")
            return
        }
        let userID = Config.getPreferenceValue(key: .KEY_USER_ID) as? String
        if let id = userID {
            guard let uint = UInt(id) else { return }
            complete(uint)
            return
        }
        
        //FIXME: debug
        if isSimulator() || true {
            complete(UInt(123456789876543))
            return
        }
        
        APIService.createUser(uuid: token, completionHandler: { userID in
            Config.setPreferenceValue(key: .KEY_USER_ID, value: userID)
            guard let uint = UInt(userID) else { return }
            complete(uint)
        }, errorHandler: { error , statusCode in
            print("createUser error: " + "\(String(describing: error))" ,statusCode)
        })
    }
    
    /**
     ステータスを取得する
     */
    static func fetchStatus() {
        guard let partnerID = YesNoViewModel.sharedInstance.partnerID.value else {
            BaseViewModel.sharedInstance.partnerStatusError.value = "パートナーを登録してください"
            return
        }
        APIService.fetchStatus(userID: partnerID, completionHandler: { status in
            YesNoViewModel.sharedInstance.partnerStatus.value = status
        }) { (error, statusCode) in
            BaseViewModel.sharedInstance.partnerStatusError.value = "ステータスの更新に失敗しました"
        }
    }
    
    
    /**
     ステータスを更新する
     */
    static func registStatus() {
        let status = !YesNoViewModel.sharedInstance.myStatus.value
        YesNoViewModel.sharedInstance.myStatus.value = status
        guard let myUserID = YesNoViewModel.sharedInstance.userID.value else { return }
        APIService.registStatus(status: status, myUserID: myUserID, completionHandler: {
        }) { (error, statusCode) in
            YesNoViewModel.sharedInstance.myStatus.value = !status
            BaseViewModel.sharedInstance.myStatusError.value = "ステータスの更新に失敗しました"
        }
    }
}
