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
        self.serup()
        self.bind()
    }
    
    private func bind() {
        let _ = BaseViewModel.sharedInstance.myStatusError.observeNext { message in
            self.showErrorAlert(message: message)
        }
        let _ = BaseViewModel.sharedInstance.partnerStatusError.observeNext { message in
            self.showErrorAlert(message: message)
        }
    }
    
    private func serup() {
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        self.errorAlert.addAction(defaultAction)
    }
    
    private func showErrorAlert(message: String?) {
        guard let message = message else { return }
        self.errorAlert.message = message
        self.present(self.errorAlert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.errorAlert.dismiss(animated: true, completion: nil)
            }
        }
    }
}
