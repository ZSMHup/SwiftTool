//
//  NetworkResponse.swift
//  YL
//
//  Created by 张书孟 on 2018/9/30.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit

class NetworkResponse: NSObject {
    
    struct Response<T: Codable>: Codable {
        let code: String
        let data: T
        let message: String
        let remark: String
        let status: String
        
        var success: Bool {
            return status == "1"
        }
        
        enum CodingKeys: String, CodingKey {
            case code
            case data
            case message
            case remark
            case status
        }
    }
    
    struct Response1<T: Codable>: Codable {
        let code: String
        let result: T
        let message: String
        let success: String
        
        var isSuccess: Bool {
            return success == "true" && code == "2000"
        }
        
        enum CodingKeys: String, CodingKey {
            case code
            case result
            case message
            case success
        }
    }
}
