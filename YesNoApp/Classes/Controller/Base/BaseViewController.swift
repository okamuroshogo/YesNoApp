//
//  BaseViewController.swift
//  YesNoApp
//
//  Created by shogo okamuro on 2017/08/26.
//  Copyright © 2017 shogo okamuro. All rights reserved.
//

import Foundation
import UIKit
import Bond

class BaseViewController: UIViewController {
    var errorAlert: UIAlertController = UIAlertController(title: "error", message: "", preferredStyle: .alert)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstExplain()
        self.serup()
        self.bind()
    }
    
    private func bind() {
        let _ = BaseViewModel.sharedInstance.myStatusRequest.observeNext { state in
            switch state {
            case .error(let message):
                self.showErrorAlert(message: message)
            default: return
            }
        }
        let _ = BaseViewModel.sharedInstance.partnerStatusRequest.observeNext { state in
            switch state {
            case .error(let message):
                self.showErrorAlert(message: message)
            default: return
            }
        }
    }
    
    private func serup() {
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        self.errorAlert.addAction(defaultAction)
    }
    
    private func showErrorAlert(message: String) {
        self.errorAlert.message = message
        self.present(self.errorAlert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.errorAlert.dismiss(animated: true, completion: nil)
            }
        }
    }
}

private extension BaseViewController {
    func firstExplain() {
        let isFirst = Config.getPreferenceValue(key: .KEY_IS_FIRST) as? Bool ?? false
//        if isFirst { return }
        self.performSegue(segue: .toHowto, sender: nil)
    }
}
