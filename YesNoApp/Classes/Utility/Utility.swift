//
//  Utility.swift
//  NegletCamera
//
//  Created by shogo okamuro on 2017/07/29.
//  Copyright © 2017 shogo okamuro. All rights reserved.
//

import Foundation

/**
 シュミレータで起動しているか判定
 - Returns: Bool
*/
func isSimulator() -> Bool {
    return TARGET_OS_SIMULATOR != 0
}
