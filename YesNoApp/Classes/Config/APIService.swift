//
//  APIService.swift
//  NHKComming
//
//  Created by shogo okamuro on 2016/11/13.
//  Copyright © 2016 ro.okamu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


struct APIService {
    //login
    static func createUser(uuid: String, completionHandler: @escaping (String) -> (), errorHandler: @escaping (Error?, Int) -> ()) {
        let params: [String:String] = ["device_token":uuid]
        Alamofire.request(Router.createUser(parameters: params)).responseSwiftyJSON{(request, response, jsonData, error) in
            print(uuid)
            guard let res = response else {
                errorHandler(error, -500)
                print("error! no response", error!, request)
                return
            }
            if res.statusCode < 200 || res.statusCode >= 300 {
                print("error!! status => \(res.statusCode)", request)
                errorHandler(error, res.statusCode)
                return
            }
            let token = jsonData["device_token"].stringValue
            if uuid == token {
                completionHandler(token)
            } else {
                errorHandler(error, -400)
            }
        }
    }

    static func fetchStatus(partners: [User], completionHandler: @escaping (Bool) -> (), errorHandler: @escaping (Error?, Int) -> ()) {
        let arr = partners.map{ ["device_token": $0.uuid] }
        let params: [String:Any] = ["users": arr]
        Alamofire.request(Router.fetchStatus(parameters: params)).responseSwiftyJSON{(request, response, jsonData, error) in
            guard let res = response else {
                print("error! no response", error!, request)
                errorHandler(error, -500)
                return
            }
            if res.statusCode < 200 || res.statusCode >= 300 {
                print("error!! status => \(res.statusCode)", request)
                errorHandler(error, res.statusCode)
                return
            }
            var partnerStatus = false
            print(jsonData)

            try! RealmData.sharedInstance.realm.write {
                for userJson in jsonData["users"].arrayValue {
                    let uuid = userJson["device_token"].stringValue
                    let status = userJson["status"].boolValue
                    let user = RealmData.sharedInstance.realm.objects(User.self).filter("uuid = '\(uuid)'").first
                    user?.status = status
                    if YesNoViewModel.sharedInstance.myPartner.value?.uuid == uuid {
                        partnerStatus = status
                    }
                }
            
            }

            completionHandler(partnerStatus)
        }
    }
    

    static func registStatus(status: Bool, myUUID: String, completionHandler: @escaping () -> (), errorHandler: @escaping (Error?, Int) -> ()) {
        let params: [String:String] = ["device_token": "\(myUUID)", "status": status.description]
        Alamofire.request(Router.registStatus(parameters: params)).responseSwiftyJSON{(request, response, jsonData, error) in
            guard let res = response else {
                print("error! no response", error!, request)
                errorHandler(error, -500)
                return
            }
            if res.statusCode < 200 || res.statusCode >= 300 {
                print("error!! status => \(res.statusCode)", request)
                errorHandler(error, res.statusCode)
                return
            }
            completionHandler()
        }
    }
}
