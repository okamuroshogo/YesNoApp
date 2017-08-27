//
//  Router.swift
//  NHKComming
//
//  Created by shogo okamuro on 2016/11/13.
//  Copyright © 2016 ro.okamu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

import Alamofire

enum Router: URLRequestConvertible {
    case createUser(parameters :Parameters)
    case fetchStatus(parameters :Parameters)
    case registStatus(parameters :Parameters)
    
    static let baseURLString = Config.host + "/" + Config.mode + "/" + Config.version
    
    var method: HTTPMethod {
        switch self {
        case .createUser:                    return .post
        case .fetchStatus:                   return .post
        case .registStatus:                  return .post

        }
    }
    
    var path: String {
        switch self {
        case .createUser:
            return "/login"
        case .fetchStatus:
            return "/status-check"
         case .registStatus:
            return "/status"
        }
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .createUser(let parameters),
             .fetchStatus(let parameters),
             .registStatus(let parameters)
            :
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        default:
            break
        }
        
        return urlRequest
    }
}
