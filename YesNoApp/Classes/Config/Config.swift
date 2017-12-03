//
//  Config.swift
//  NHKComming
//
//  Created by shogo okamuro on 2016/11/13.
//  Copyright © 2016 ro.okamu. All rights reserved.
//

import UIKit

// swiftlint:disable type_name
struct Config {
    static let host         = "https://a93d0y86qc.execute-api.ap-northeast-1.amazonaws.com/dev"
    static let version      = "v1"
    static let mode         = "api"
    static let bundleID     = Bundle.main.bundleIdentifier
    static let yesColor     = UIColor(red: 0.9215686275, green: 0.6352941176, blue: 0.7490196078, alpha: 1.0)
    static let noColor      = UIColor(red: 0.4705882353, green: 0.8235294118, blue: 0.862745098, alpha: 1.0)
}

enum Segue: String, SegueType {
    case toMain
    case toPartner
    case toQR
    case toRead
    case toHowto
}

enum RequestState {    
    case none
    case requesting
    case error(String)
    func isRequesting() -> Bool {
        switch self {
        case .requesting:
            return true
        default:
            return false
        }
    }
    
    func isError() -> Bool {
        switch self {
        case .error(_):
            return true
        default:
            return false
        }
    }
}
