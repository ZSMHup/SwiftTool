//
//  Matcher.swift
//
//  Created by zhangshumeng on 2018/8/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

public enum Matcher: String {
    
    case phone = "^1[0-9]{10}$"
    case email = "^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$"
    case password = "^(?=.*[a-zA-Z])(?=.*[0-9]).{8,}$"
    case number = "^[0-9]+$"
    case url = "[a-zA-z]+://[^\\s]*"
    
    public func evaluate(_ input: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", rawValue)
        return predicate.evaluate(with: input)
    }
}
