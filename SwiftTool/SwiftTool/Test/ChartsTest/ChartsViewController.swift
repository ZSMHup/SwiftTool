//
//  ChartsViewController.swift
//  SwiftTool
//
//  Created by 张书孟 on 2018/10/30.
//  Copyright © 2018 zsm. All rights reserved.
//

import UIKit
import Charts

class ChartsViewController: BaseViewController {

    private lazy var chartView: PieChartView = {
        let chartView = PieChartView(frame: CGRect(x: 20, y: 80, width: UIScreen.width - 40, height: 260))
        chartView.rotationEnabled = false //禁用旋转功能
//        chartView.centerText = "我是饼状图"
        chartView.holeRadiusPercent = 0  //空心半径为0
        chartView.transparentCircleRadiusPercent = 0.25  //半透明半径比例
        chartView.drawHoleEnabled = false  //这个饼是实心的
        chartView.animate(xAxisDuration: 1.4, easingOption: .easeOutBounce)
        return chartView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
    }
}

extension ChartsViewController {
    
    private func addSubviews() {
        view.addSubview(chartView)
        //生成5条随机数据
        let dataEntries = (0..<5).map { (i) -> PieChartDataEntry in
            return PieChartDataEntry(value: Double(arc4random_uniform(50) + 10),
                                     label: "数据\(i)")
        }
        let chartDataSet = PieChartDataSet(values: dataEntries, label: "数据分布")
//        chartDataSet.selectionShift = 5 // 修改选中扇区的伸出长度
        chartDataSet.sliceSpace = 3 //扇区间隔为3
        chartDataSet.colors = [ChartColorTemplates.colorFromString("#020202")]
            + ChartColorTemplates.joyful()
            + ChartColorTemplates.colorful()
            + ChartColorTemplates.liberty()
            + ChartColorTemplates.pastel()
        let chartData = PieChartData(dataSet: chartDataSet)
        chartView.data = chartData
    }
}

extension ChartsViewController {
    
}

extension ChartsViewController {
    
}

