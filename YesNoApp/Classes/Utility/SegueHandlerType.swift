//
//  SegueHandlerType.swift
//  NegletCamera
//
//  Created by shogo okamuro on 2017/07/29.
//  Copyright © 2017 shogo okamuro. All rights reserved.
//

import Foundation
import UIKit

protocol SegueType {
    var rawValue: String { get }
}

extension UIViewController {
    /**
     performSegue for segue
     - Parameters:
     - segue: Segue
     - sender: AnyObject
     */
    func performSegue(segue: Segue, sender: AnyObject?) {
        performSegue(withIdentifier: segue.rawValue, sender: sender)
    }
}
