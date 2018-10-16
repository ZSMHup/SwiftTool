//
//  YLHomeAPI.swift
//  YL
//
//  Created by 张书孟 on 2018/9/21.
//  Copyright © 2018年 zsm. All rights reserved.
//


/// 获取首页-banner
func requestHomeBannerList() -> RequestManager {
    let paramter = ["method": "ella.book.listBanner"]
    return RequestManager.default.requestHanlder(params: paramter)
}
