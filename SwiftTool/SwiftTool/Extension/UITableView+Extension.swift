//
//  UITableView+Extension.swift
//  SwiftTool
//
//  Created by 张书孟 on 2018/9/12.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import CocoaChainKit

extension Chain where Base: UITableView {
    
    @discardableResult
    func separator(left: CGFloat = 20, right: CGFloat = 0) -> Chain {
        base.separatorColor = UIColor.separator
        base.separatorInset = UIEdgeInsets(top: 0, left: left, bottom: 0, right: right)
        return self
    }
    
    @discardableResult
    func plainFooterView() -> Chain {
        base.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
        return self
    }
}
