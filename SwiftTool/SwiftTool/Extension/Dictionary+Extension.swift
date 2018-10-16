//
//  Dictionary+Extension.swift
//  SwiftTool
//
//  Created by 张书孟 on 2018/9/12.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import Foundation

extension Dictionary {
    
    /// 字典转jsonString
    var dictionaryToString: String {
        var result: String = ""
        do {
            //如果设置options为JSONSerialization.WritingOptions.prettyPrinted,则打印格式更好阅读
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.init(rawValue: 0))
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                result = JSONString
            }
        } catch {
            result = ""
        }
        return result
    }
    
    /// 字典添加字典
    mutating func append(dict: Dictionary) -> Dictionary {
        dict.forEach { (key, value) in
            self.updateValue(value, forKey: key)
        }
        return self
    }
}
