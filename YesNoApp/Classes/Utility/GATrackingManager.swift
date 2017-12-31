//
//  GATrackingManager.swift
//  YesNoApp
//
//  Created by shogo okamuro on 2017/12/31.
//  Copyright © 2017 shogo okamuro. All rights reserved.
//

import Foundation

class GATrackingManager {
    
    class func sendScreenTracking(screenName: String) {
        let tracker = GAI.sharedInstance().defaultTracker
        tracker?.set(kGAIScreenName, value: screenName)
        tracker?.send(GAIDictionaryBuilder.createScreenView().build() as [NSObject: AnyObject])
        tracker?.set(kGAIScreenName, value: nil)
    }
    
    class func sendEventTracking(Category: String, Action: String, Label: String) {
        let tracker = GAI.sharedInstance().defaultTracker
        tracker?.send(GAIDictionaryBuilder.createEvent(withCategory: Category, action: Action, label: Label, value: nil).build() as [NSObject: AnyObject])
    }
    
}
