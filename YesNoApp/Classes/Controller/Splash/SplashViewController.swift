//
//  SplashViewController.swift
//  YesNoApp
//
//  Created by shogo okamuro on 2017/08/26.
//  Copyright © 2017 shogo okamuro. All rights reserved.
//

import Foundation
import UIKit
import Bond

final class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        YesNoViewModel.sharedInstance.uuid.observeNext { uuid in
            if uuid == nil { return }
            YesNoModel.createUser(complete: { _ in
                self.performSegue(segue: .toMain, sender: nil)
            })
        }
        
        if isSimulator() {
            YesNoViewModel.sharedInstance.uuid.value = "aaaaaaaaa"
        }
    }
}

