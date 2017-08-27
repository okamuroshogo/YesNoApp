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
    @IBOutlet weak var myStatusLabel: UILabel!
    @IBOutlet weak var partnerStatusLabel: UILabel!
    @IBOutlet weak var fetchPartnerBtn: UIButton!
    @IBOutlet weak var myStatusBtn: UIButton!
    @IBOutlet weak var addPartnerBtn: UIButton!
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
        let _ = self.addPartnerBtn.reactive.tap.observe { _ in
            self.performSegue(segue: .toPartner, sender: nil)
        }
        let _ = self.qrGenerateBtn.reactive.tap.observe { _ in
            self.performSegue(segue: .toQR, sender: nil)
        }
        let _ = YesNoViewModel.sharedInstance.myStatus.observeNext { status in
            self.myStatusLabel.text = status ? "yes" : "no"
//            rself.view.backgroundColor = status ? UIColor(named: "YesPinkColor") : UIColor(named: "NoBlueColor")
        }
        let _ = YesNoViewModel.sharedInstance.partnerStatus.observeNext { status in
            print(YesNoViewModel.sharedInstance.partnerStatus.value)
            print(status)
            if YesNoViewModel.sharedInstance.provisionPartnerStatus == status { return }
            YesNoViewModel.sharedInstance.provisionPartnerStatus = status
            YesNoViewModel.sharedInstance.partnerStatus.value = status
            self.partnerStatusLabel.text = status ? "yes" : "no"
            let iconName = status ? "yes-Icon-60" : "no-Icon-60"
            UIApplication.shared.setAlternateIconName(iconName, completionHandler: { error in
                print(error)
            })
        }
    }
}
