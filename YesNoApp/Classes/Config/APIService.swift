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

enum RequestState: UInt {
    case None = 0
    case Requesting
    case Error
}
struct APIService {
    //login
    static func createUser(uuid: String, completionHandler: @escaping (String) -> (), errorHandler: @escaping (Error?, Int) -> ()) {
        let params: [String:String] = ["uuid":uuid]
        print(params)
        Alamofire.request(Router.createUser(parameters: params)).responseSwiftyJSON{(request, response, jsonData, error) in
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
            let userId = jsonData["user_id"].stringValue
            completionHandler(userId)
        }
    }

    static func fetchStatus(userID: UInt, completionHandler: @escaping (Bool) -> (), errorHandler: @escaping (Error?, Int) -> ()) {
        let params: [String:String] = ["user_id": "\(userID)"]
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
            let status = jsonData["status"].boolValue
            completionHandler(status)
        }
    }

    static func registStatus(status: Bool, myUserID: UInt, completionHandler: @escaping () -> (), errorHandler: @escaping (Error?, Int) -> ()) {
        let params: [String:String] = ["user_id": "\(myUserID)", "status": status.description]
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
