//
//  UIColor+extension.swift
//
//  Created by zhangshumeng on 2018/8/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

public extension UIColor {
    
    /// #E8B838
    public static var global: UIColor {
        return UIColor(hex: "#E8B838")
    }
    
    /// #F5B817
    public static var theme: UIColor {
        return UIColor(hex: "#F5B817")
    }
    
    /// #1D1D1D
    public static var globalBackground: UIColor {
        return UIColor(hex: "#1D1D1D")
    }
    
    /// #111111
    public static var dark: UIColor {
        return UIColor(hex: "#111111")
    }
    
    /// #777777
    public static var light: UIColor {
        return UIColor(hex: "#777777")
    }
    
    /// #888888
    public static var placeholder: UIColor {
        return UIColor(hex: "#888888")
    }
    
    /// #EFEFEF alpha 0.2
    public static var separator: UIColor {
        return UIColor(hex: "#EFEFEF").alpha(0.2)
    }
}

public extension UIColor {
    
    convenience init(hex string: String) {
        var hex = string.hasPrefix("#") ? String(string.dropFirst()) : string
        guard hex.count == 3 || hex.count == 6 else {
            self.init(white: 1.0, alpha: 0.0)
            return
        }
        if hex.count == 3 {
            for (index, char) in hex.enumerated() {
                hex.insert(char, at: hex.index(hex.startIndex, offsetBy: index * 2))
            }
        }
        
        self.init(red: CGFloat((Int(hex, radix: 16)! >> 16) & 0xFF) / 255.0,
                  green: CGFloat((Int(hex, radix: 16)! >> 8) & 0xFF) / 255.0,
                  blue: CGFloat((Int(hex, radix: 16)!) & 0xFF) / 255.0, alpha: 1.0)
    }
    
    func alpha(_ value: CGFloat) -> UIColor {
        return withAlphaComponent(value)
    }
}
