//
//  UserChangeCollectionViewController.swift
//  YesNoApp
//
//  Created by shogo okamuro on 2017/08/26.
//  Copyright © 2017 shogo okamuro. All rights reserved.
//

import Foundation
import UIKit
import Bond

class UserChangeCollectionViewController: UIViewController {
    @IBOutlet weak var registBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
    }
    
    private func bind() {
        let _ = self.registBtn.reactive.tap.observe { _ in
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension UserChangeCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(segue: .toRead, sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (UIScreen.main.bounds.width - 40 ) / 2.0
        let height = width
        return CGSize(width: width, height: height)
    }
}
