//
//  BaseViewModel.swift
//  YesNoApp
//
//  Created by shogo okamuro on 2017/08/26.
//  Copyright © 2017 shogo okamuro. All rights reserved.
//

import Foundation
import Bond
import UIKit

final class BaseViewModel {
    class var sharedInstance : BaseViewModel {
        struct Static {
            static let instance : BaseViewModel = BaseViewModel()
        }
        return Static.instance
    }
    
    let myStatusRequest: Observable<RequestState> = Observable(.none)
    let partnerStatusRequest: Observable<RequestState> = Observable(.none)
}


