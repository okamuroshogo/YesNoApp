//
//  SelectViewController.swift
//  YesNoApp
//
//  Created by shogo okamuro on 2018/01/01.
//  Copyright © 2018 shogo okamuro. All rights reserved.
//

import Foundation
import UIKit
import Bond

class SelectViewController: BaseViewController {
    @IBOutlet private weak var cancelBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cancelBtn.reactive.tap.observe { _ in
            self.dismiss(animated: true, completion: nil)
        }
    }
}
