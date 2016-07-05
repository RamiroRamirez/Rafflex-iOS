//
//  RXAPIManager.swift
//  Rafflex
//
//  Created by Ramiro Ramirez on 30/06/16.
//  Copyright © 2016 RAM. All rights reserved.
//

import Foundation
import Alamofire

struct RXAPIManager {
    
    // Standard success block returning the result from request.
    typealias SuccessBlock 			= ((result: AnyObject?) -> Void)
    // Standard failure block returning the result and error from request.
    typealias FailureBlock			= ((result: AnyObject?, error: AnyObject?) -> Void)
    
    
    struct RequestData {
        
        // path with endpoint for request.
        var path: String
        // dictionary of parameters for the request.
        var parameters: [String: AnyObject]?
        
        init(path: String, parameters: [String: AnyObject]? = nil) {
            self.path = path
            self.parameters = parameters
        }
    }
    
    static func baseURLWithPath(path: String?) -> String {
        var baseURL = (NSBundle.entryInPListForKey(UserDefault.APIBaseURL.rawValue) as? String ?? "")
        
        if let pathUrl = path {
            baseURL = baseURL + "/" + pathUrl
        }
        return baseURL
    }
}
