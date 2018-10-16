//
//  Int+Extension.swift
//
//  Created by zhangshumeng on 2018/8/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

public extension Int {
    
    /// 数字转中文数字
    var cnNumber: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "zh_Hans")
        formatter.numberStyle = .spellOut
        return formatter.string(from: NSNumber(integerLiteral: self)) ?? ""
    }
}
