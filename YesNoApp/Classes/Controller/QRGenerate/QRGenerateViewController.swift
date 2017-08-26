//
//  QRGenerateViewController.swift
//  YesNoApp
//
//  Created by shogo okamuro on 2017/08/26.
//  Copyright © 2017 shogo okamuro. All rights reserved.
//

import Foundation
import EFQRCode
import UIKit
import Bond

class QRGenerateViewController: UIViewController {
    @IBOutlet weak var qrcodeImageView: UIImageView!
    @IBOutlet weak var closeBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let userID =  YesNoViewModel.sharedInstance.userID.value else { return }
        print(userID)
        guard let tryImage = EFQRCode.generate(
            content: "\(userID)",
            watermark: UIImage(named: "yesno-sample-icon")?.toCGImage()
            ) else { return }
        self.qrcodeImageView.image = UIImage(cgImage: tryImage)
        let _ = self.closeBtn.reactive.tap.observe { _ in
            self.dismiss(animated: true, completion: nil)
        }
    }
}
