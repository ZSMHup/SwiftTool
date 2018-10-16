//
//  UIBarButtonItem+Extension.swift
//
//  Created by zhangshumeng on 2018/8/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

public extension UIBarButtonItem {
    
    convenience init(title: String?,
                     textColor: UIColor = UIColor.white,
                     font: UIFont = UIFont.systemFont(ofSize: 16),
                     target: Any? = nil,
                     action: Selector? = nil) {
        self.init(title: title, style: .plain, target: target, action: action)
        setTitleTextAttributes([.font: font, .foregroundColor: textColor], for: .normal)
    }
    
    convenience init(title: String?) {
        self.init(title: title, style: .plain, target: nil, action: nil)
    }
    
    convenience init(image: UIImage?) {
        self.init(image: image, style: .plain, target: nil, action: nil)
    }
}
