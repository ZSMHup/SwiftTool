//
//  Toast.swift
//  SwiftTool
//
//  Created by 张书孟 on 2018/8/28.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import Toast_Swift

final class Toast {
    static var keyWindow: UIWindow? {
        return UIApplication.shared.keyWindow
    }
    
    static func loading() {
        hide()
        keyWindow?.makeToastActivity(.center)
    }
    
    static func show(info: String, duration: TimeInterval = ToastManager.shared.duration) {
        hide()
        keyWindow?.makeToast(info, duration: duration, position: .center)
    }
    
    static func show(image: UIImage?, duration: TimeInterval = ToastManager.shared.duration) {
        hide()
        let imageView = UIImageView(image: image)
        keyWindow?.showToast(imageView, duration: duration)
    }
    
    static func show(customView: UIView, duration: TimeInterval = ToastManager.shared.duration) {
        hide()
        keyWindow?.showToast(customView, duration: duration)
    }
    
    static func hideActivity() {
        keyWindow?.hideToastActivity()
    }
    
    static func hide() {
        keyWindow?.hideAllToasts(includeActivity: true)
    }
}


