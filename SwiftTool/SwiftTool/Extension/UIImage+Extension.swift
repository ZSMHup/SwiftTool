//
//  UIImage+Extension.swift
//
//  Created by zhangshumeng on 2018/8/26.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

/// 绘制等边三角形
public extension UIImage {
    func triangle(image size: CGSize, tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let ctx = UIGraphicsGetCurrentContext()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: size.height))
        path.addLine(to: CGPoint(x: size.width, y: size.height))
        path.addLine(to: CGPoint(x: size.width / 2, y: 0))
        path.close()
        ctx?.setFillColor(tintColor.cgColor)
        path.fill()
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage ?? UIImage()
    }
}
