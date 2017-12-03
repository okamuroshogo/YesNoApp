//
//  HowtoViewController.swift
//  YesNoApp
//
//  Created by shogo okamuro on 2017/12/03.
//  Copyright © 2017 shogo okamuro. All rights reserved.
//

import Foundation
import UIKit
import Bond

class HowtoViewController: UIViewController {
    @IBOutlet private weak var startBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
    }
    
    private func bind() {
        self.startBtn.reactive.tap.observe { _ in
            self.dismiss(animated: true, completion: nil)
            Config.setPreferenceValue(key: .KEY_IS_FIRST, value: true)
        }
    }
}
