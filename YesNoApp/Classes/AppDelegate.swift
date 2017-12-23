//
//  AppDelegate.swift
//  YesNoApp
//
//  Created by shogo okamuro on 2017/08/26.
//  Copyright © 2017 shogo okamuro. All rights reserved.
//

import UIKit
import UserNotificationsUI
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.setApperrance()
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
            DispatchQueue.main.async(execute: {
                UIApplication.shared.registerForRemoteNotifications()
                UNUserNotificationCenter.current().delegate = self
            })
        }
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        self.saveDevicetoken(deviceToken: deviceToken)
    }

    //デバイストークンを取得する
    func saveDevicetoken(deviceToken: Data) {
        let token = deviceToken.map { String(format: "%.2hhx", $0) }.joined()
        Config.setPreferenceValue(key: .KEY_DEVICE_TOKEN, value: token)
        YesNoViewModel.sharedInstance.uuid.value = token
    }

}

private extension AppDelegate {
    func setApperrance() {
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = UIColor.brown
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.brown]
    }
}
