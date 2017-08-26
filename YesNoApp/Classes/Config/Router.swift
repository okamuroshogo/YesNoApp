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
    case splash(parameters :Parameters)
    case createUser(parameters :Parameters)
    
    
    static let baseURLString = Config.host + "/" + Config.mode + "/" + Config.version
    
    var method: HTTPMethod {
        switch self {
        case .splash:                   return .get
        case .createUser:                    return .post
        
        }
    }
    
    var path: String {
        switch self {
        case .splash:
            return "/splash.json"
        case .createUser:
            return "/login.json"
        }
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .createUser(let parameters),
             .splash(let parameters)
            :
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        default:
            break
        }
        
        return urlRequest
    }
}
