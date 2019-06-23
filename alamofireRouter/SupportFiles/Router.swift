//
//  Router.swift
//  alamofireRouter
//
//  Created by SourceKhone on 6/23/19.
//  Copyright © 2019 mrs. All rights reserved.
//

import Alamofire


enum Router: URLRequestConvertible {
    static let baseURLString = ""
    case get(apiName: String)
    case getWhithQuery(apiName: String, query:String)
    case getWhithToken(apiName: String, token:String)
    case post(apiName: String, parameters: [String: Any])
    case postWithToken(apiName: String, parameters: [String: Any], tokenValue: String)
    case put(apiName: String, parameters: [String: Any], tokenValue: String)
    case patch(apiName: String, parameters: [String: Any], tokenValue: String)
    case delete(apiName: String, tokenValue: String)
    
    // MARK: - Method
    var method: HTTPMethod {
        switch self {
        case .get, .getWhithQuery, .getWhithToken:
            return .get
        case .post, .postWithToken:
            return .post
        case .put:
            return .put
        case .patch:
            return .patch
        case .delete:
            return .delete
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .get(let apiName), .getWhithQuery(let apiName, _), .getWhithToken(let apiName, _), .post(let apiName, _), .postWithToken(let apiName, _, _), .put(let apiName, _, _), .patch(let apiName, _, _), .delete(let apiName, _):
            return apiName
        }
    }
    
    // MARK: - Parameters
    private var parameters: [String: Any]? {
        switch self {
        case .get, .getWhithToken, .delete :
            return nil
        case .post(_, let parameters), .postWithToken(_, let parameters, _), .put(_, let parameters, _), .patch(_, let parameters, _):
            return parameters
        case .getWhithQuery(_, let query):
            return (["filter": query])
        }
    }
    
    // MARK: - token
    private var token: String?{
        switch self {
        case .get, .getWhithQuery, .post:
            return nil
        case .getWhithToken(_, let tokenValue ), .postWithToken(_, _, let tokenValue ), .put(_, _, let tokenValue ), .patch(_, _, let tokenValue ), .delete(_, let tokenValue):
            return (tokenValue)
        }
    }
        
    
    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        if let t = token {
            urlRequest.setValue(t, forHTTPHeaderField: "access_token")
        }
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    
    
}
