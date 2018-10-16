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

/// 获取首页-subject
func requestHomeSubjectList() -> RequestManager {
    let paramter = ["method": "ella.book.listSubject"]
    return RequestManager.default.requestHanlder(params: paramter)
}

/// 获取首页-all
func requestHomeAllList() -> RequestManager {
    let paramter = ["method": "ella.book.listAllPart"]
    return RequestManager.default.requestHanlder(params: paramter)
}

/// 获取首页-猜你喜欢

func requestHomeLikeList(page: Int) -> RequestManager {
    let paramter = ["method": "ella.book.listRecommendBookSelection",
                    "content": ["channelCode": channelCode,
                                "uid": uid,
                                "pageSize": "15",
                                "pageIndex": "\(page)"]] as [String : Any]
    return RequestManager.default.requestHanlder(params: paramter)
}

/// banner跳转页
func requestPackageBook(
    page: Int,
    packageCode: String,
    method: String) -> RequestManager {
    
    let paramter = ["method": method,
                    "content": ["packageCode": packageCode,
                                "uid": uid,
                                "pageVo": ["page": "\(page)"],
                                "resource": "normal"].dictionaryToString
    ]
    return RequestManager.default.requestHanlder(params: paramter)
}

/// BuyBookPackage
func requestBuyPackageBook(packageCode: String) -> RequestManager {
    
    let paramter = ["method": "ella.order.buyBookPackage",
                    "content": ["packageCode": packageCode,
                                "uid": uid,
                                "channelCode": "APPLE_STORE",
                                "resource": "IOS"].dictionaryToString
    ]
    return RequestManager.default.requestHanlder(params: paramter)
}

/// 版本更新
func requestSystemUpdate() -> RequestManager {
    
    let paramter = ["method": "ella.user.updateVersion",
                    "content": ["version": ver,
                                "channel": "appStore",
                                "versionResource": "iOS"].dictionaryToString
    ]
    return RequestManager.default.requestHanlder(params: paramter)
}
