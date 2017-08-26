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
    
    let myStatusError: Observable<String?> = Observable(nil)
    let partnerStatusError: Observable<String?> = Observable(nil)
}


