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
//    @IBOutlet weak var canselBtn: UIButton!
    @IBOutlet weak var registBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    private var selectIndex: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GATrackingManager.sendScreenTracking(screenName: "user_change")
    }
    
    private func setup() {
        guard let partnerID = YesNoViewModel.sharedInstance.myPartner.value?.id else { return }
        for (index, partner) in YesNoViewModel.sharedInstance.partners.value.enumerated() {
            if partner.id == partnerID {
                self.selectIndex = index
            }
        }
    }
    
    private func bind() {
        let _ = self.registBtn.reactive.tap.observe { _ in
            self.registPartner()
        }
        
        let _ = YesNoViewModel.sharedInstance.partners.observe { _ in
            self.collectionView.reloadData()
        }
    }
    
    private func registPartner() {
        if YesNoViewModel.sharedInstance.partners.value.count <= 0 { return }
        let user = YesNoViewModel.sharedInstance.partners.value[self.selectIndex]
        let alert: UIAlertController = UIAlertController(title: "パートナーを\(user.name)で登録します", message: "保存してもいいですか？", preferredStyle:  .alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler:{
            (action: UIAlertAction!) -> Void in
            let partner =  YesNoViewModel.sharedInstance.partners.value[self.selectIndex]
            YesNoViewModel.sharedInstance.myPartner.value = partner
            Config.setPreferenceValue(key: .KEY_PARTNER_ID, value: "\(partner.id)")
            self.dismiss(animated: true, completion: nil)
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func partnerName() {
        let alertController = UIAlertController(title: "追加するパートナーの名前を\n入力してください", message: "", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "確定", style: .default, handler: {
            alert -> Void in
            guard let nameField = alertController.textFields?.first,
                let name = nameField.text else { return }
            if name.count <= 0 || name == "" || name == " " || name == "　" { return }
            YesNoViewModel.sharedInstance.registName = name
            self.performSegue(segue: .toRead, sender: nil)
        })
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "パートナーの名前"
        }
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension UserChangeCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == YesNoViewModel.sharedInstance.partners.value.count {
            self.partnerName()
        } else {
            self.selectIndex = indexPath.row
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return YesNoViewModel.sharedInstance.partners.value.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.layer.borderWidth = 1.0
        let addLabel = cell.viewWithTag(100) as? UILabel
        let nameLabel = cell.viewWithTag(101) as? UILabel
        if indexPath.row == YesNoViewModel.sharedInstance.partners.value.count {
            nameLabel?.isHidden = true
            addLabel?.isHidden = false
            cell.backgroundColor = .white
            cell.alpha = 0.5
        } else {
            let user = YesNoViewModel.sharedInstance.partners.value[indexPath.row]
            nameLabel?.isHidden = false
            print("user.name")
            print(user.name)
            nameLabel?.text = user.name
            cell.alpha = 1.0
            addLabel?.isHidden = true
            if indexPath.row == self.selectIndex {
                cell.layer.borderWidth = 3.0
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = ( UIScreen.main.bounds.width - 40 ) / 2.0
        let height = width
        return CGSize(width: width, height: height)
    }
}
