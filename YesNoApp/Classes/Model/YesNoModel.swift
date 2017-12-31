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
        //FIXME: debug
        if isSimulator() {
            complete("qwertyuiop")
            return
        }
        
        guard let token = Config.getPreferenceValue(key: .KEY_DEVICE_TOKEN) as? String else {
            //TODO: device tokenをpermission scopeで再取得
            print("not found device token")
            return
        }
        let isRegist = Config.getPreferenceValue(key: .KEY_IS_REGIST) as? Bool
        if isRegist ?? false {
            complete(token)
            return
        }
        
        APIService.createUser(uuid: token, completionHandler: { uuid in
            Config.setPreferenceValue(key: .KEY_IS_REGIST, value: true)
            complete(uuid)
        }, errorHandler: { error , statusCode in
            print("createUser error: " + "\(String(describing: error))" ,statusCode)
        })
    }
    
    /**
     ステータスを取得する
     */
    static func fetchStatus() {
        if BaseViewModel.sharedInstance.partnerStatusRequest.value.isRequesting() { return }
        BaseViewModel.sharedInstance.partnerStatusRequest.value = .requesting
        guard let myPartner = YesNoViewModel.sharedInstance.myPartner.value else {
            BaseViewModel.sharedInstance.partnerStatusRequest.value = .error("パートナーを登録してください")
            return
        }
        APIService.fetchStatus(partners: [myPartner], completionHandler: { status in
            YesNoViewModel.sharedInstance.partnerStatus.value = status
            BaseViewModel.sharedInstance.partnerStatusRequest.value = .none
        }) { (error, statusCode) in
            BaseViewModel.sharedInstance.partnerStatusRequest.value = .error("ステータスの更新に失敗しました\n \(String(describing: error))")
        }
    }
    
    
    /**
     ステータスを更新する
     */
    static func registStatus() {
        if BaseViewModel.sharedInstance.myStatusRequest.value.isRequesting() { return }
        BaseViewModel.sharedInstance.myStatusRequest.value = .requesting
        let status = !YesNoViewModel.sharedInstance.myStatus.value
        YesNoViewModel.sharedInstance.myStatus.value = status
        guard let myUUID = YesNoViewModel.sharedInstance.uuid.value else { return }
        APIService.registStatus(status: status, myUUID: myUUID, completionHandler: {
            BaseViewModel.sharedInstance.myStatusRequest.value = .none
        }) { (error, statusCode) in
            YesNoViewModel.sharedInstance.myStatus.value = !status
            BaseViewModel.sharedInstance.myStatusRequest.value = .error("ステータスの更新に失敗しました\n \(String(describing: error))")
        }
    }
    
    /**
     パートナーを追加する
     */
    static func addPartner(uuid: String, name: String) {
        let (user, isNewRecord) = User.findOrCreatedBy(uuid: uuid, name: name)
        if isNewRecord {
            YesNoViewModel.sharedInstance.partners.value.append(user)
        }
    }
}
