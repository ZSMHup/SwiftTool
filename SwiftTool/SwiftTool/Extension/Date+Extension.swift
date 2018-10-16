//
//  Date+Extension.swift
//
//  Created by zhangshumeng on 2018/8/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

import UIKit

private let zodiacs: [String] = ["鼠年", "牛年", "虎年", "兔年", "龙年", "蛇年", "马年", "羊年", "猴年", "鸡年", "狗年", "猪年"]

private let heavenlyStems: [String] = ["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"]

private let earthlyBranches: [String] = ["子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"]

private let months: [String] = ["正月", "二月", "三月", "四月", "五月", "六月", "七月", "八月",
                                "九月", "十月", "冬月", "腊月"]

private let days: [String] = ["初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十",
                               "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "廿",
                               "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十"]

public extension Date {
    
    // 生肖
    public func zodiac() -> String {
        let calendar: Calendar = Calendar(identifier: .chinese)
        return zodiac(year: calendar.component(.year, from: self))
    }
    
    private func zodiac(year: Int) -> String {
        let zodiacIndex: Int = (year - 1) % zodiacs.count
        return zodiacs[zodiacIndex]
    }
    
    // 天干地支
    public func era() -> String {
        let calendar: Calendar = Calendar(identifier: .chinese)
        return era(year: calendar.component(.year, from: self))
    }
    
    private func era(year: Int) -> String {
        let heavenlyStemIndex: Int = (year - 1) % heavenlyStems.count
        let heavenlyStem: String = heavenlyStems[heavenlyStemIndex]
        let earthlyBrancheIndex: Int = (year - 1) % earthlyBranches.count
        let earthlyBranche: String = earthlyBranches[earthlyBrancheIndex]
        return heavenlyStem + earthlyBranche
    }
    
    // 获取农历
    public func lunar() -> String {
        let calendar: Calendar = Calendar(identifier: .chinese)
        let com = calendar.dateComponents(component(), from: self)
        let m_str = months[com.month! - 1]
        let d_str = days[com.day! - 1]
        return m_str + " " + d_str
    }
    
    private func component() -> Set<Calendar.Component> {
        return [.year, .month, .day, .hour, .minute, .second]
    }
}
