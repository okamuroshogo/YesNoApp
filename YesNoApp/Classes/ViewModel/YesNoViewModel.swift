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
    
    let userID: Observable<UInt?> = Observable(nil)
    let partnerID: Observable<UInt?> = Observable(nil)
    let partnerStatus: Observable<Bool> = Observable(false)
    let myStatus: Observable<Bool> = Observable(false)
    
    let partners: Observable<[User]> = Observable([])

    init() {
        YesNoModel.createUser { userID in
            self.userID.value = userID
        }
        self.partners.value = RealmData.sharedInstance.realm.objects(User.self).map { $0 }
    }
}
