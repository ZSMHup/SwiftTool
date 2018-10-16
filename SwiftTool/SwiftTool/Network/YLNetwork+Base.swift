//
//  YLNetwork+Base.swift
//  YL
//
//  Created by 张书孟 on 2018/9/30.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit

let ver = String().appVersion
let channelCode = "appStore"
let tourist = "guest"
let uid = "U201809202116526624994"

extension RequestManager {
    public func requestHanlder(params: [String: Any]) -> RequestManager {
        
        var baseDic: [String: Any] = ["channelCode": channelCode,
                                      "v": ver,
                                      "token": tourist,
                                      "uid": uid]
        
        let dic = baseDic.append(dict: params)
        return request(url: NetworkEnvironment.environment.baseURL, method: .post, parameters: dic)
    }
}

extension RequestManager {
    public func uploadImage<T: Codable>(datas: [Data],
                                        model: T.Type,
                                        successCompletion: @escaping (T)->(),
                                        failureCompletion: @escaping (String)->()) {
        upload(datas: datas,
               url: NetworkEnvironment.environment.uploadURL,
               withName: "Filedata",
               fileName: "\(UUID().uuidString).jpeg",
            mimeType: "image/jpeg",
            successCompletion: { (data) in
            if let resopnseData = try? JSONDecoder().decode(NetworkResponse.Response1<T>.self, from: data) {
                
                if !resopnseData.isSuccess {
                    failureCompletion(resopnseData.message)
                    return
                }
                successCompletion(resopnseData.result)
            } else {
                failureCompletion("上传失败")
            }
        }) { (error) in
            failureCompletion(error.errorMessage)
        }
    }
}
