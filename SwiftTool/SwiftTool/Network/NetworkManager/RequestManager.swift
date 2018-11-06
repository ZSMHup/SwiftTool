//
//  RequestManager.swift
//  YL
//
//  Created by 张书孟 on 2018/9/30.
//  Copyright © 2018年 zsm. All rights reserved.
//

import Alamofire

class RequestSessionManager: SessionManager {
    
    static let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        return SessionManager(configuration: configuration)
    }()
}


class RequestManager: NSObject {
    
    static let `default` = RequestManager()
    
    private var cache: Bool = false
    private var dataRequest = [String: DataRequest]()
    private var cacheKeys: String = ""
    private var requestCount: Int = 0 {
        didSet {
            if requestCount == 0 {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            } else {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
        }
    }
}

// MARK: 请求
extension RequestManager {
    public func request(url: String,
                        method: HTTPMethod = .get,
                        parameters: Parameters? = nil,
                        encoding: ParameterEncoding = URLEncoding.default,
                        headers: HTTPHeaders? = nil) -> RequestManager {
        
        let key = cacheKey(url, parameters)
        
        let request = RequestSessionManager.sessionManager.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
        dataRequest[key] = request
        requestCount += 1
        cache = false
        return self
    }
}

// MARK: 响应数据处理
extension RequestManager {
    public func responseData<T: Codable>(_ type: T.Type ,
                                         completion: @escaping (T) -> (),
                                         failureCompletion: @escaping (String) -> ()) {
        
        guard !dataRequest.isEmpty else {
            requestCount = 0
            return
        }
        
        dataRequest.forEach { (key, request) in
            dataRequest.removeValue(forKey: key)
            request.responseData { (response) in
                
                self.requestCount < 0 ? (self.requestCount = 0) : (self.requestCount -= 1)
                
                switch response.result {
                case .success(let data):
                    if let responseData = try? JSONDecoder().decode(NetworkResponse.Response<T>.self, from: data) {
                        if !responseData.success {
                            failureCompletion(responseData.message)
                            return
                        }
                        
                        if self.cache {
                            var model = CacheModel()
                            model.data = data
                            CacheManager.default.setObject(model, forKey: key)
                        }
                        
                        completion(responseData.data)
                    } else {
                        failureCompletion("解析失败")
                    }
                case .failure(let error):
                    failureCompletion(error.errorMessage)
                }
            }
        }
    }
}

// MARK: 缓存数据
extension RequestManager {
    
    public func cache(_ cache: Bool) -> RequestManager {
        self.cache = cache
        return self
    }
    
    public func responseCache<T: Codable>(_ type: T.Type ,
                                          completion: @escaping (T) -> ()) -> RequestManager {
        if cache {
            guard !dataRequest.isEmpty else {
                return self
            }
            dataRequest.forEach { (key, request)in
                let model = CacheManager.default.objectSync(forKey: key)
                guard let data = model?.data else { return }
                if let responseData = try? JSONDecoder().decode(NetworkResponse.Response<T>.self, from: data) {
                    completion(responseData.data)
                }
            }
        }
        return self
    }
}

// MARK: 文件上传
extension RequestManager {
    /// 文件上传
    ///
    /// - Parameters:
    ///   - datas: 文件 [Date]
    ///   - url: 服务器地址
    ///   - withName: 和后台服务器的name要一致
    ///   - fileName: 可以充分利用写成用户的id，但是格式要写对
    ///   - mimeType: 规定的，要上传其他格式可以自行百度查一下
    ///   - successCompletion: 成功回调
    ///   - progressCompletion: 上传进度回调
    ///   - failureCompletion: 失败回调
    public func upload(datas: [Data],
                       url: String,
                       withName: String,
                       fileName: String,
                       mimeType: String,
                       successCompletion: @escaping (Data) -> (),
                       failureCompletion: @escaping (Error) -> ()) {
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for data in datas {
                multipartFormData.append(data, withName: withName, fileName: fileName, mimeType: mimeType)
            }
        }, to: url) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseData(completionHandler: { (response) in
                    switch response.result {
                    case .success(let value):
                        successCompletion(value)
                    case .failure(let error):
                        failureCompletion(error)
                    }
                })
                break
            case .failure(let error):
                failureCompletion(error)
            }
        }
    }
}

