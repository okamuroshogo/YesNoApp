//
//  YesNoStatusViewController.swift
//  YesNoApp
//
//  Created by shogo okamuro on 2017/08/26.
//  Copyright © 2017 shogo okamuro. All rights reserved.
//

import Foundation
import UIKit
import Bond

class YesNoStatusViewController: BaseViewController {
    @IBOutlet weak var fetchPartnerBtn: UIButton!
    @IBOutlet weak var myStatusBtn: UIButton!
    @IBOutlet weak var qrGenerateBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bind()
    }
   
    private func bind() {
        let _ = self.myStatusBtn.reactive.tap.observe { _ in
            YesNoModel.registStatus()
        }
        let _ = self.fetchPartnerBtn.reactive.tap.observe { _ in
            YesNoModel.fetchStatus()
        }
        let _ = self.qrGenerateBtn.reactive.tap.observe { _ in
            self.performSegue(segue: .toQR, sender: nil)
        }
        let _ = YesNoViewModel.sharedInstance.myStatus.observeNext { status in
            let image = status ? UIImage(named: "my_yes") : UIImage(named: "my_no")
            self.myStatusBtn.setImage(image, for: .normal)
        }
        let _ = YesNoViewModel.sharedInstance.partnerStatus.observeNext { status in
            if YesNoViewModel.sharedInstance.provisionPartnerStatus == status { return }
            YesNoViewModel.sharedInstance.provisionPartnerStatus = status
            YesNoViewModel.sharedInstance.partnerStatus.value = status
            let image = status ? UIImage(named: "your_yes") : UIImage(named: "your_no")
            self.fetchPartnerBtn.setImage(image, for: .normal)
            let iconName = status ? "yes-Icon-60" : "no-Icon-60"
            UIApplication.shared.setAlternateIconName(iconName, completionHandler: nil)
        }
    }
}
