//
//  NetworkEnvironment.swift
//  YL
//
//  Created by 张书孟 on 2018/9/30.
//  Copyright © 2018年 zsm. All rights reserved.
//

public enum NetworkEnvironment {
    case develop
    case product
    
    static let environment: NetworkEnvironment = .product
    
    var baseURL: String {
        switch self {
        case .develop:
            return ""
        case .product:
            return "http://api.ellabook.cn/rest/api/service"
        }
    }
    
    var uploadURL: String {
        switch self {
        case .develop:
            return ""
        case .product:
            return ""
        }
    }
}
