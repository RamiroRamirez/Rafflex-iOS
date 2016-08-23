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
    typealias FailureBlock			= ((result: AnyObject?, error: NSError?) -> Void)
    
    
    struct RequestData {
        
        // path with endpoint for request.
        var path: String
        // dictionary of parameters for the request.
        var parameters: [String: String]?
        
        init(path: String, parameters: [String: String]? = nil) {
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
    
    private static func GETRequest(requestData: RequestData, successBlock: SuccessBlock, failureBlock: FailureBlock) {
        
        let fullPath = self.baseURLWithPath(requestData.path)
		Manager.sharedInstance.request(.GET, fullPath, parameters: requestData.parameters, headers: nil).responseJSON { (response) in
            if let
                value = response.result.value,
                _value = value as? [String: AnyObject] where (response.result.isSuccess == true) {
                    successBlock(result: _value)
            } else {
                failureBlock(result: response.result.value, error: response.result.error)
            }
        }
    }
    
    private static func POSTRequest(requestData: RequestData, successBlock: SuccessBlock, failureBlock: FailureBlock) {
        
        let fullPath = self.baseURLWithPath(requestData.path)
		Manager.sharedInstance.request(.POST, fullPath, parameters: requestData.parameters, headers: nil).responseJSON { (response: Response<AnyObject, NSError>) in
            if (response.result.isSuccess == true) {
                successBlock(result: response.result.value)
            } else if (response.result.isFailure) {
                failureBlock(result: response.result.value, error: response.result.error)
            }
        }
    }
    
    static func login(parameters: [String: String]?, successBlock: SuccessBlock, failureBlock: FailureBlock) {
        
        let requestData = RequestData(path: API.Endpoint.Login.rawValue, parameters: parameters)
        self.POSTRequest(requestData, successBlock: successBlock, failureBlock: failureBlock)
    }

	static func register(parameters: [String: String]?, successBlock: SuccessBlock, failureBlock: FailureBlock) {

		let requestData = RequestData(path: API.Endpoint.Register.rawValue, parameters: parameters)
		self.POSTRequest(requestData, successBlock: successBlock, failureBlock: failureBlock)
	}

}
