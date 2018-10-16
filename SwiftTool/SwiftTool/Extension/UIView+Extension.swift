//
//  UIView+Extension.swift
//  SwiftTool
//
//  Created by 张书孟 on 2018/10/16.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

extension UIView {
    
    /// 通过UIView对象找到其所在的UIViewController
    var currVC: UIViewController? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let responder = view?.next, responder.isKind(of: UIViewController.self) {
                return responder as? UIViewController
            }
        }
        return nil
    }
    
    /// 部分圆角
    ///
    /// - Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   - radii: 圆角半径
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}
