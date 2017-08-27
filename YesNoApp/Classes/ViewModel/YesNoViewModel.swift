//
//  YesNoViewModel.swift
//  YesNoApp
//
//  Created by shogo okamuro on 2017/08/26.
//  Copyright © 2017 shogo okamuro. All rights reserved.
//

import Foundation
import Bond
import UIKit

final class YesNoViewModel {
    class var sharedInstance : YesNoViewModel {
        struct Static {
            static let instance : YesNoViewModel = YesNoViewModel()
        }
        return Static.instance
    }
    
    let uuid: Observable<String?> = Observable(nil)
    let myPartner: Observable<User?> = Observable(nil)
    let partnerStatus: Observable<Bool> = Observable(false)
    let myStatus: Observable<Bool> = Observable(false)
    
    let partners: Observable<[User]> = Observable([])

    init() {
        YesNoModel.createUser { uuid in
            self.uuid.value = uuid
        }
        self.partners.value = RealmData.sharedInstance.realm.objects(User.self).map { $0 }
        
        if let partnerID = Config.getPreferenceValue(key: .KEY_PARTNER_ID) as? String {
            self.myPartner.value = RealmData.sharedInstance.realm.objects(User.self).filter("id == \(partnerID)").first
        }
    }
}
