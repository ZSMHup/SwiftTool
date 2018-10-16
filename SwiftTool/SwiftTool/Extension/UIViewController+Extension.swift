//
//  UIViewController+Extension.swift
//
//  Created by zhangshumeng on 2018/8/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit
import SnapKit
//import EachNavigationBar

public extension UIViewController {
    
    func disablesAdjustScrollViewInsets(_ scrollView: UIScrollView) {
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    /*
    var topLayoutGuideBottom: ConstraintItem {
        return navigation.bar.snp.bottom
    }
    */
    
    var topLayoutGuideBottom: ConstraintItem {
        return topLayoutGuide.snp.bottom
    }
    
    var safeAreaLayoutGuideBottom: ConstraintItem {
        if #available(iOS 11.0, *) {
            return view.safeAreaLayoutGuide.snp.bottom
        } else {
            return view.snp.bottom
        }
    }
}
