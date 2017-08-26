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
//
//    static func openRoom(roomID: UInt, completionHandler: @escaping () -> (), errorHandler: @escaping (Error?, Int) -> ()) {
//        guard let userID = Config.getPreferenceValue(key: .KEY_USER_ID) as? String else { return }
//        let params: [String:String] = ["room_id": "\(roomID)", "user_id": userID]
//        Alamofire.request(Router.openRoom(parameters: params)).responseSwiftyJSON{(request, response, jsonData, error) in
//            guard let res = response else {
//                print("error! no response", error!, request)
//                return
//            }
//            if res.statusCode < 200 || res.statusCode >= 300 {
//                print("error!! status => \(res.statusCode)", request)
//                errorHandler(error, res.statusCode)
//                return
//            }
//            completionHandler()
//        }
//    }
//
//
//    //create room
//    static func createRoom(roomMateID: UInt, completionHandler: @escaping (Room) -> (), errorHandler: @escaping (Error?, Int) -> ()) {
//        guard let userID = Config.getPreferenceValue(key: .KEY_USER_ID) as? String else { return }
//        let params: [String:String] = ["user_id": "\(userID)", "room_mate_id": "\(roomMateID)"]
//        Alamofire.request(Router.createRoom(parameters: params)).responseSwiftyJSON{(request, response, jsonData, error) in
//            guard let res = response else {
//                print("error! no response", error!, request)
//                return
//            }
//            if res.statusCode < 200 || res.statusCode >= 300 {
//                print("error!! status => \(res.statusCode)", request)
//                errorHandler(error, res.statusCode)
//                return
//            }
//
//            completionHandler(Room(fromJson: jsonData))
//        }
//    }
//
//    //create room
//    static func createRoom(timeline timelineID: UInt, message: String, completionHandler: @escaping (Room) -> (), errorHandler: @escaping (Error?, Int) -> ()) {
//        guard let userID = Config.getPreferenceValue(key: .KEY_USER_ID) as? String else { return }
//        let params: [String:String] = ["user_id": "\(userID)", "time_line_id": "\(timelineID)", "message": message]
//        Alamofire.request(Router.createRoomWithTimeline(parameters: params)).responseSwiftyJSON{(request, response, jsonData, error) in
//            guard let res = response else {
//                print("error! no response", error!, request)
//                return
//            }
//            if res.statusCode < 200 || res.statusCode >= 300 {
//                print("error!! status => \(res.statusCode)", request)
//                errorHandler(error, res.statusCode)
//                return
//            }
//
//            completionHandler(Room(fromJson: jsonData))
//        }
//    }
//
//    //create room
//    static func createRoom(profile profileID: UInt, message: String, completionHandler: @escaping (Room) -> (), errorHandler: @escaping (Error?, Int) -> ()) {
//        guard let userID = Config.getPreferenceValue(key: .KEY_USER_ID) as? String else { return }
//        let params: [String:String] = ["user_id": "\(userID)", "room_mate_id": "\(profileID)", "message": message]
//        Alamofire.request(Router.createRoomWithProfile(parameters: params)).responseSwiftyJSON{(request, response, jsonData, error) in
//            guard let res = response else {
//                print("error! no response", error!, request)
//                return
//            }
//            if res.statusCode < 200 || res.statusCode >= 300 {
//                print("error!! status => \(res.statusCode)", request)
//                errorHandler(error, res.statusCode)
//                return
//            }
//
//            completionHandler(Room(fromJson: jsonData))
//        }
//    }
//
//    static func getRooms(page: UInt, completionHandler: @escaping (JSON) -> (), errorHandler: @escaping (Error?, Int) -> ()) {
//        guard let userID = Config.getPreferenceValue(key: .KEY_USER_ID) as? String else { return }
//        let params: [String:String] = ["page": "\(page)", "user_id": "\(userID)"]
//        Alamofire.request(Router.getRooms(parameters: params)).responseSwiftyJSON{(request, response, jsonData, error) in
//            guard let res = response else {
//                print("error! no response", error!)
//                return
//            }
//            if res.statusCode < 200 || res.statusCode >= 300 {
//                print("error!! status => \(res.statusCode)", jsonData["message"].stringValue)
//                errorHandler(error, res.statusCode)
//                return
//            }
////            var rooms: [Room] = []
////            for room in jsonData.arrayValue {
////                rooms.append(Room(fromJson: room))
////            }
//            completionHandler(jsonData)
//        }
//    }
//
//
//
//    static func getTimeLines(params: Parameters, completionHandler: @escaping (Genre?,JSON) -> (), errorHandler: @escaping (Error?, Int) -> ()) {
//
//        Alamofire.request(Router.getTimeLine(parameters: params)).responseSwiftyJSON{(request, response, jsonData, error) in
//            guard let res = response else {
//                print("error! no response", error!)
//                return
//            }
//            if res.statusCode < 200 || res.statusCode >= 300 {
//                print("error!! status => \(res.statusCode)", jsonData["message"].stringValue)
//                errorHandler(error, res.statusCode)
//                return
//            }
//            let genre = Genre.findBy(id: jsonData["genre_id"].intValue)
//            completionHandler(genre, jsonData)
//        }
//    }
//
//    static func postTimeLines(params: Parameters, image: (UIImage, URL), progressHandler: @escaping (Double) -> (), completionHandler: @escaping (Bool) -> (), errorHandler: @escaping (Error?, Int) -> ()) {
//        guard let userID = Config.getPreferenceValue(key: .KEY_USER_ID) as? String else { return }
//        let url = Router.baseURLString + Router.postTimeLine().path
//        var postParams = params
//        postParams["user_id"] = "\(userID)"
//
//        Alamofire.upload(multipartFormData: { (multipartFormData) in
//            guard let imageType = image.1.imageTypeForExtention() else { return }
//            guard let data = image.0.toData(imageType: imageType) else { return }
//            multipartFormData.append(data, withName: "image", fileName: "\(String.shortCode62())." + imageType.rawValue, mimeType: "image/" + imageType.rawValue)
//            for (key, value) in postParams {
//                multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
//            }
//        },usingThreshold: UInt64.init(),
//          to: url,
//          method: .post,
//          headers: nil,
//          encodingCompletion: { encodingResult in
//            switch encodingResult {
//            case .success(let upload, _, _):
//                upload.responseString(completionHandler: { response in
//                    guard let res = response.result.value else {
//                        print("error! no response")
//                        return
//                    }
//                    guard let data = res.data(using: String.Encoding.utf8, allowLossyConversion: false) else { return }
//                    let json = JSON(data)
//                    if json["status"].boolValue {
//                        completionHandler(true)
//                    } else {
//                        errorHandler(nil, 500)
//                    }
//
//                })
//            case .failure(let encodingError):
//                print("en eroor :", encodingError)
//            }
//        })
//    }
//
//    static func starPost(params: Parameters, completionHandler: @escaping (Bool) -> (), errorHandler: @escaping (Error?, Int) -> ()) {
//        Alamofire.request(Router.starPost(parameters: params)).responseSwiftyJSON{(request, response, jsonData, error) in
//            guard let res = response else {
//                print("error! no response", error!)
//                return
//            }
//            if res.statusCode < 200 || res.statusCode >= 300 {
//                print("error!! status => \(res.statusCode)", jsonData["message"].stringValue)
//                errorHandler(error, res.statusCode)
//                return
//            }
//            completionHandler(true)
//        }
//    }
//
//    static func unstarPost(params: Parameters, completionHandler: @escaping (Bool) -> (), errorHandler: @escaping (Error?, Int) -> ()) {
//        Alamofire.request(Router.unstarPost(parameters: params)).responseSwiftyJSON{(request, response, jsonData, error) in
//            guard let res = response else {
//                print("error! no response", error!)
//                return
//            }
//            if res.statusCode < 200 || res.statusCode >= 300 {
//                print("error!! status => \(res.statusCode)", jsonData["message"].stringValue)
//                errorHandler(error, res.statusCode)
//                return
//            }
//            completionHandler(true)
//        }
//    }
}
