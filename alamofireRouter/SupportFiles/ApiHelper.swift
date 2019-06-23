//
//  ApiHelper.swift
//  alamofireRouter
//
//  Created by SourceKhone on 6/23/19.
//  Copyright © 2019 mrs. All rights reserved.
//

import Alamofire

class ApiHelper : NSObject {
    static let sharedInstants = ApiHelper()
    
    func getMainData(_ completionHandler: @escaping(Any, Bool) -> Void) {
        Alamofire.request(Router.get(apiName: "/api/v1/Categories/getAppMainData")).responseJSON { response in
            switch response.result {
            case .success(_):
                if let Json = response.result.value as? NSDictionary {
                    if let hasError = Json["hasError"] as? Bool {
                        if hasError {
                            if let error = Json["error"] as? NSDictionary {
                                completionHandler(error, hasError)
                            }
                        } else {
                            if let data = Json["response"] {
                                completionHandler(data, hasError)
                            }
                        }
                    }
                }
            case .failure(_):
                completionHandler(response.error.debugDescription,true)
            }
        }
    }
    
    func getProduct(productID: String ,_ completionHandler: @escaping(Any, Bool) -> Void) {
        let q = "{\"include\":[\"brand\",\"gallery\"]}"
        Alamofire.request(Router.getWhithQuery(apiName: "/api/v1/Products/\(productID)", query: q)).responseJSON { response in
            switch response.result {
            case .success(_):
                if let Json = response.result.value as? NSDictionary {
                    if let hasError = Json["hasError"] as? Bool {
                        if hasError {
                            if let error = Json["error"] as? NSDictionary {
                                completionHandler(error, hasError)
                            }
                        } else {
                            if let data = Json["response"] {
                                completionHandler(data, hasError)
                            }
                        }
                    }
                }
            case .failure(_):
                completionHandler(response.error.debugDescription,true)
            }
        }
    }
    
    
    func loginApi(mobile:String, _ completionHandler: @escaping(Any,Bool)-> Void) {
        let myParameters :[String : Any]  = [
            "mobile": mobile,
            "device": [
                "model": "iphone 8",
                "platform": "ios",
                "version": "ios 12",
                "manufacture": "Apple"
            ]
        ]
        
        Alamofire.request(Router.post(apiName: "/api/v1/AppUsers/loginUser", parameters: myParameters)).responseJSON { response in
            switch response.result {
            case .success(_):
                if let Json = response.result.value as? NSDictionary {
                    if let hasError = Json["hasError"] as? Bool {
                        if hasError {
                            if let error = Json["error"] as? NSDictionary {
                                completionHandler(error, hasError)
                            }
                        } else {
                            if let data = Json["response"] {
                                completionHandler(data, hasError)
                            }
                        }
                    }
                }
            case .failure(_):
                completionHandler(response.error.debugDescription,true)
            }
        }
    }
}
