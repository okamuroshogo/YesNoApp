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
    
    let userID: Observable<String?> = Observable(nil)
    
    init() {
        YesNoModel.createUser { userID in
            self.userID.value = userID
        }
    }
}

