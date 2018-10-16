//
//  NetworkViewController.swift
//  SwiftTool
//
//  Created by 张书孟 on 2018/10/16.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit

class NetworkViewController: BaseViewController {

    private lazy var textView: UITextView = {
        UITextView().chain
            .backgroundColor(UIColor.red)
            .textColor(UIColor.white)
            .build
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNav()
        addSubviews()
    }
}

extension NetworkViewController {
    
    private func setupNav() {
        
    }
    
    private func addSubviews() {
        
        view.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(200)
        }
        
        requestHomeBannerList()
            .cache(true)
            .responseCache([BannerListModel].self) { (model) in
                
            }.responseData([BannerListModel].self, completion: { (model) in
                self.textView.text = "\(model)"
            }) { (error) in
                debugPrint(error)
        }
    }
}

extension NetworkViewController {
    
    
    
}

extension NetworkViewController {
    
}

