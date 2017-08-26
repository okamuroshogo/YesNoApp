//
//  QRReadViewController.swift
//  YesNoApp
//
//  Created by shogo okamuro on 2017/08/26.
//  Copyright © 2017 shogo okamuro. All rights reserved.
//

import Foundation
import MTBBarcodeScanner
import Bond

class QRReadViewController: UIViewController {
    
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet var previewView: UIView!
    var scanner: MTBBarcodeScanner?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.closeBtn.reactive.tap.observe { _ in
            self.dismiss(animated: true, completion: nil)
        }
        
        self.scanner = MTBBarcodeScanner(previewView: previewView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        MTBBarcodeScanner.requestCameraPermission(success: { success in
            if success {
                do {
                    try self.scanner?.startScanning(resultBlock: { codes in
                        guard let codes = codes else { return }
                        for code in codes {
                            let stringValue = code.stringValue!
                            guard let userID = UInt(stringValue) else { return }
                            print("Found code: \(userID)")
                            YesNoViewModel.sharedInstance.partnerID.value = userID
                            self.dismiss(animated: true, completion: nil)
                            
                        }
                    })
                } catch {
                    print("Unable to start scanning")
                }
            } else {
                //TODO: permission scope
                UIAlertView(title: "Scanning Unavailable", message: "This app does not have permission to access the camera", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "Ok").show()
            }
        })
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.scanner?.stopScanning()
        super.viewWillDisappear(animated)
    }
}
