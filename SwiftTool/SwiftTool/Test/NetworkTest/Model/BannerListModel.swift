//
//  BannerListModel.swift
//  SwiftTool
//
//  Created by 张书孟 on 2018/10/16.
//  Copyright © 2018年 zsm. All rights reserved.
//

struct BannerListModel: Codable {
    let id: String
    let bannerCode: String
    let bannerTitle: String
    let bannerDesc: String
    let targetType: String
    let targetPage: String
    let idx: String
    let bannerImageUrl: String
    let stat: String
    let createTime: String
}
