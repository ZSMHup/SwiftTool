//
//  Network+Error.swift
//
//  Created by 张书孟 on 2018/8/27.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import Alamofire

extension Error {
    
    var errorMessage: String {
        guard let error = self as NSError? else { return "" }
        
        switch error.code {
        case -1001:
            return "网络请求超时"
        case -1200, -1201, -1202, -1203, -1205:
            return "没有配置证书"
        case -1009:
            return "网络异常，请检查您的网络后重试"
        default:
            return "服务器异常"
        }
    }
}
