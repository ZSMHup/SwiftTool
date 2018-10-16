//
//  CacheManager.swift
//
//  Created by 张书孟 on 2018/8/24.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import Cache

struct CacheModel: Codable {
    var data: Data?
    init() {}
}

class CacheManager {
    static let `default` = CacheManager()
    /// Manage storage
    private var storage: Storage<CacheModel>?
    /// init
    init() {
        let diskConfig = DiskConfig(name: "NetCache")
        let memoryConfig = MemoryConfig(expiry: .never)
        do {
            storage = try Storage(diskConfig: diskConfig, memoryConfig: memoryConfig, transformer: TransformerFactory.forCodable(ofType: CacheModel.self))
        } catch {
            debugPrint(error)
        }
    }
    
    func setObject(_ object: CacheModel, forKey: String) {
        do {
            try storage?.setObject(object, forKey: forKey)
        } catch {
            debugPrint("CacheManager save obiect error: \(error)")
        }
    }
    
    /// 异步读取缓存
    func object(forKey key: String, completion: @escaping (Cache.Result<CacheModel>)->Void) {
        storage?.async.object(forKey: key, completion: completion)
    }
    /// 读取缓存
    func objectSync(forKey key: String) -> CacheModel? {
        do {
            return (try storage?.object(forKey: key)) ?? nil
        } catch {
            debugPrint("CacheManager get obiect error: \(error)")
            return nil
        }
    }
    
    /// 清除所有缓存
    ///
    /// - Parameter completion: 完成闭包
    func removeAllCache(completion: @escaping (Bool)->()) {
        storage?.async.removeAll(completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .value: completion(true)
                case .error: completion(false)
                }
            }
        })
    }
    /// 根据key值清除缓存
    func removeObjectCache(_ cacheKey: String, completion: @escaping (Bool)->()) {
        storage?.async.removeObject(forKey: cacheKey, completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .value: completion(true)
                case .error: completion(false)
                }
            }
        })
    }
    
//    func getFileSize() -> Double  {
//        var size: Double = 0
//        let fileManager = FileManager.default
//        var isDir: ObjCBool = false
//        let isExists = fileManager.fileExists(atPath: filePath!, isDirectory: &isDir)
//        // 判断文件存在
//        if isExists {
//            // 是否为文件夹
//            if isDir.boolValue {
//                // 迭代器 存放文件夹下的所有文件名
//                let enumerator = fileManager.enumerator(atPath: filePath!)
//                for subPath in enumerator! {
//                    // 获得全路径
//                    let fullPath = filePath?.appending("/\(subPath)")
//                    do {
//                        let attr = try fileManager.attributesOfItem(atPath: fullPath!)
//                        size += attr[FileAttributeKey.size] as! Double
//                    } catch  {
//                        debugPrint("error :\(error)")
//                    }
//                }
//            } else {    // 单文件
//                do {
//                    let attr = try fileManager.attributesOfItem(atPath: filePath!)
//                    size += attr[FileAttributeKey.size] as! Double
//
//                } catch  {
//                    debugPrint("error :\(error)")
//                }
//            }
//        }
//        return size
//    }
}

/// 将参数字典转换成字符串后md5
func cacheKey(_ url: String, _ params: Dictionary<String, Any>?) -> String {
    let str = "\(url)" + "\(sort(params))"
    return MD5(str)
}

/// 参数排序生成字符串
func sort(_ parameters: Dictionary<String, Any>?) -> String {
    var sortParams = ""
    if let params = parameters {
        let sortArr = params.keys.sorted { return $0 < $1 }
        
        sortArr.forEach({ (str) in
            if var value = params[str] {
                if let va = value as? Dictionary<String, Any> {
                    value = sort1(va)
                }
                sortParams = sortParams.appending("\(str)=\(value)")
            } else {
                sortParams = sortParams.appending("\(str)=")
            }
        })
    }
    return sortParams
}

func sort1(_ parameters: Dictionary<String, Any>?) -> String {
    var sortParams = ""
    if let params = parameters {
        let sortArr = params.keys.sorted { return $0 < $1 }
        sortArr.forEach({ (str) in
            if let value = params[str] {
                sortParams = sortParams.appending("\(str)=\(value)")
            } else {
                sortParams = sortParams.appending("\(str)=")
            }
        })
    }
    return sortParams
}
