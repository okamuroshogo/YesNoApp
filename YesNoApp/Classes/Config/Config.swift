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
    static let host         = "https://"
    static let version      = "v1"
    static let mode         = "api"
    static let bundleID     = Bundle.main.bundleIdentifier
}

enum Segue: String, SegueType {
    case toMain
    case toPartner
    case toQR
    case toRead
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
