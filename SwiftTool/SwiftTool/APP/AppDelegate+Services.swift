//
//  AppDelegate+Services.swift
//  SwiftTool
//
//  Created by 张书孟 on 2018/10/16.
//  Copyright © 2018年 zsm. All rights reserved.
//

import Toast_Swift

#if DEBUG
import CocoaDebug
#endif


extension AppDelegate {
    
    func registerServices() {
        
        configureCocoaDebug()
    }
    
    private func configureToastStyle() {
        ToastManager.shared.style.backgroundColor = UIColor.white
        ToastManager.shared.style.messageColor = UIColor(hex: "#313131")
        ToastManager.shared.style.activityBackgroundColor = UIColor.white
        ToastManager.shared.style.activityIndicatorColor = UIColor(hex: "#313131")
    }
    
    private func configureCocoaDebug() {
        #if DEBUG
        CocoaDebug.enable()
        CocoaDebug.recordCrash = true
        #endif
    }
}

