//
//  BaseViewController.swift
//  SwiftTool
//
//  Created by 张书孟 on 2018/10/16.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
    }
    
    deinit {
        debugPrint("\(classForCoder) deinit")
    }
}

extension BaseViewController {
    
    private func setupNav() {
        
    }
    
    private func addSubviews() {
        
    }
}

extension BaseViewController {
    
}

extension BaseViewController {
    
}

