//
//  String+Extension.swift
//
//  Created by zhangshumeng on 2018/8/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import CommonCrypto

/// 计算高度
public extension String {
    
    func textHeight(font: UIFont, width: CGFloat, maxHeight: CGFloat = CGFloat.greatestFiniteMagnitude) -> CGFloat {
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: maxHeight),
                                                       options: .usesLineFragmentOrigin,
                                                       attributes: [.font: font],
                                                       context: nil)
        return ceil(rect.height)
    }
    
    func get_heightForComment(fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(rect.height)
    }
}

public extension String {
    
    func urlEncoding() -> String {
        if self.isEmpty { return "" }
        let urlDecod = self.urlDecoding() // 先解码，防止链接二次编码导致链接打不开
        guard let encodeUrlString = urlDecod.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return ""
        }
        return encodeUrlString
    }
    
    func urlDecoding() -> String {
        if self.isEmpty { return "" }
        guard let decodingUrl = self.removingPercentEncoding else { return "" }
        return decodingUrl
    }
}

/// 日期
public extension String {
    
    func stringToDate(string: String, dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = dateFormat
        guard let date = formatter.date(from: string) else { return Date() }
        return date
    }
    
    func dateToString(date: Date, dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
    
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let formatDate = dateFormatter.date(from: self) else { return "" }
        let calendar = Calendar.current
        _ = calendar.component(.era, from: formatDate)
        let year = calendar.component(.year, from: formatDate)
        let month = calendar.component(.month, from: formatDate)
        let day = calendar.component(.day, from: formatDate)
        let hour = calendar.component(.hour, from: formatDate)
        let minute = calendar.component(.minute, from: formatDate)
        let second = calendar.component(.second, from: formatDate)
        return String(format: "%.2zd年%.2zd月%.2zd日 %.2zd时:%.2zd分:%.2zd秒", year, month, day, hour, minute, second)
    }
    
    func featureWeekday() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let formatDate = dateFormatter.date(from: self) else { return "" }
        let calendar = Calendar.current
        let weekDay = calendar.component(.weekday, from: formatDate)
        switch weekDay {
        case 1:
            return "星期日"
        case 2:
            return "星期一"
        case 3:
            return "星期二"
        case 4:
            return "星期三"
        case 5:
            return "星期四"
        case 6:
            return "星期五"
        case 7:
            return "星期六"
        default:
            return ""
        }
    }
}

/// emoji表情处理
public extension String {
    // 判断是否包含emoji
    var containsEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case
            0x00A0...0x00AF,
            0x2030...0x204F,
            0x2120...0x213F,
            0x2190...0x21AF,
            0x2310...0x329F,
            0x1F000...0x1F9CF:
                return true
            default:
                continue
            }
        }
        return false
    }
    
    //返回字数
    private var count: Int {
        let string_NS = self as NSString
        return string_NS.length
    }
    
    //使用正则表达式替换
    private func pregReplace(pattern: String, with: String,
                     options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: self, options: [],
                                              range: NSMakeRange(0, self.count),
                                              withTemplate: with)
    }
    
    // 移除emoji
    func removeEmoji() -> String {
        let pattern = "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"
        return self.pregReplace(pattern: pattern, with: "")
    }
}

/// 版本更新
public extension String {
    /// 获取当前版本号
    var appVersion: String {
        guard let infoDic = Bundle.main.infoDictionary else { return "" }
        let appVersion: String = (infoDic["CFBundleShortVersionString"] ?? "") as! String
        return appVersion
    }
    
    /// 比较版本号
    func versionCompare() -> Bool {
        let result = appVersion.compare(self, options: .numeric, range: nil, locale: nil)
        if result == .orderedDescending || result == .orderedSame{
            return false
        }
        return true
    }
}

public extension String {
    var MD5String: String {
        let cStrl = cString(using: .utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: .utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        
        let buffer = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(cStrl, strLen, buffer)
        var md5String = ""
        for idx in 0..<digestLen {
            let obcStrl = String.init(format: "%02x", buffer[idx])
            md5String.append(obcStrl)
        }
        free(buffer)
        return md5String
    }
}

public extension String {
    
    /// 从url String中截取出参数
    var urlParameters: [String: AnyObject]? {
        // 判断是否有参数
        guard let _ = self.range(of: "?") else {
            return nil
        }
        
        var params = [String: AnyObject]()
        // 截取参数
        let comArr = self.components(separatedBy: "?")
        
        guard let paramsString = comArr.last else {
            return nil
        }
        
        // 判断参数是单个参数还是多个参数
        if paramsString.contains("&") {
            // 多个参数，分割参数
            let urlComponents = paramsString.components(separatedBy: "&")
            // 遍历参数
            for keyValuePair in urlComponents {
                // 生成Key/Value
                let pairComponents = keyValuePair.components(separatedBy: "=")
                let key = pairComponents.first
                let value = pairComponents.last
                // 判断参数是否是数组
                if let key = key, let value = value {
                    // 已存在的值，生成数组
                    if let existValue = params[key] {
                        if var existValue = existValue as? [AnyObject] {
                            existValue.append(value as AnyObject)
                        } else {
                            params[key] = [existValue, value] as AnyObject
                        }
                    } else {
                        params[key] = value as AnyObject
                    }
                }
            }
        } else {
            // 单个参数
            let pairComponents = paramsString.components(separatedBy: "=")
            // 判断是否有值
            if pairComponents.count == 1 {
                return nil
            }
            let key = pairComponents.first
            let value = pairComponents.last
            if let key = key, let value = value {
                params[key] = value as AnyObject
            }
        }
        return params
    }
}

public extension String {
    /// 遍历所有子目录， 并计算文件大小 单位：字节
    var getCacheSize: Double {
        var fileSize: Double = 0.0
        if let childFilePath = FileManager.default.subpaths(atPath: self) {
            for path in childFilePath {
                let fileAbsoluePath = self + path
                fileSize += fileAbsoluePath.fileSize
            }
        }
        return fileSize
    }
    
    /// 计算单个文件的大小 单位：字节
    var fileSize: Double {
        let manager = FileManager.default
        var fileSize: Double = 0.0
        if manager.fileExists(atPath: self) {
            do {
                let attributes = try manager.attributesOfItem(atPath: self)
                if !attributes.isEmpty, let size = attributes[FileAttributeKey.size] as? Double {
                    fileSize = size
                }
            } catch {}
        }
        return fileSize
    }
}

public extension String {
    /// 从url中获取后缀 例：.pdf
    var pathExtension: String {
        guard let url = URL(string: self) else { return "" }
        return url.pathExtension.isEmpty ? "" : ".\(url.pathExtension)"
    }
}

public extension String {
    
}

public extension String {
    
    
}
