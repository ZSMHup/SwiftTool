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
        
//        let scale = CATransform3DMakeScale(1, 0.6, 1)
//        let replace = CATransform3DMakeTranslation(0, -50, 0)
//        chartView.layer.transform = CATransform3DConcat(scale, replace)
//        
//        view.addSubview(chartView)
//        //生成5条随机数据
//        let dataEntries = (0..<5).map { (i) -> PieChartDataEntry in
//            return PieChartDataEntry(value: Double(arc4random_uniform(50) + 10),
//                                     label: "数据\(i)")
//        }
//        let chartDataSet = PieChartDataSet(values: dataEntries, label: "数据分布")
////        chartDataSet.selectionShift = 5 // 修改选中扇区的伸出长度
//        chartDataSet.sliceSpace = 3 //扇区间隔为3
//        chartDataSet.colors = [ChartColorTemplates.colorFromString("#020202")]
//            + ChartColorTemplates.joyful()
//            + ChartColorTemplates.colorful()
//            + ChartColorTemplates.liberty()
//            + ChartColorTemplates.pastel()
//        let chartData = PieChartData(dataSet: chartDataSet)
//        chartView.data = chartData
        
        let chart = ChartView(frame: CGRect(x: 50, y: 100, width: UIScreen.width - 100, height: UIScreen.width - 100))
//        chart.backgroundColor = UIColor.white
        chart.pieHeight = 40
        chart.pieRadius = 140
        chart.pieCenter = CGPoint(x: 150, y: 200)
        chart.yScale = 0.6
        chart.pieDataSource = addSlice()
        view.addSubview(chart)
        
        
    }
    
    private func addSlice() -> [PieConfig] {
        let firstSlice = PieConfig()
        firstSlice.color = UIColor.red
        firstSlice.column = 0.3
        firstSlice.name = "firstSlice"
        
        let secondSlice = PieConfig()
        secondSlice.color = UIColor.blue
        secondSlice.column = 0.1
        secondSlice.name = "secondSlice"
        
        let thirdSlice = PieConfig()
        thirdSlice.color = UIColor.yellow
        thirdSlice.column = 0.2
        thirdSlice.name = "thirdSlice"
        
        let fourthSlice = PieConfig()
        fourthSlice.color = UIColor.green
        fourthSlice.column = 0.2
        fourthSlice.name = "fourthSlice"
        
        let lastSlice = PieConfig()
        lastSlice.color = UIColor.white
        lastSlice.column = 0.2
        lastSlice.name = "lastSlice"
        
        return [firstSlice, secondSlice, thirdSlice, fourthSlice, lastSlice]
    }
}

extension ChartsViewController {
    
}

extension ChartsViewController {
    
}

