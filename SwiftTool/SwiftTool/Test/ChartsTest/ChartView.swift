//
//  ChartView.swift
//  SwiftTool
//
//  Created by 张书孟 on 2018/10/31.
//  Copyright © 2018 zsm. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class ChartView: UIView {

    var pieDataSource: [PieConfig] = [] {
        didSet {
//            layer.removeFromSuperlayer()
//            setNeedsDisplay()
        }
    }
    var pieHeight: CGFloat = 40.0 /// 饼的厚度
    var pieCenter: CGPoint = CGPoint(x: 0, y: 0) /// 饼的中心位置
    var pieRadius: CGFloat = 140 /// 饼的半径
    var xScale: CGFloat = 1 /// x轴的压缩比例
    var yScale: CGFloat = 1 /// y轴的压缩比例
    
    override func draw(_ rect: CGRect) {
        drawRect()
//        CATransform3D scale = CATransform3DMakeScale(1., LAYER_FLAT_TRANSFORM, 1.);
//        CATransform3D replace = CATransform3DMakeTranslation(0, LAYER_REPLACE_TRANSFORM, 0);
//        self.layer.transform = CATransform3DConcat(scale, replace);
        
        let scale = CATransform3DMakeScale(1.0, 0.6, 1.0)
        let replace = CATransform3DMakeTranslation(0, 0.6, 0)
        layer.transform = CATransform3DConcat(scale, replace)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        guard let touch: UITouch = (touches as NSSet).anyObject() as? UITouch else { return }

        let point = touch.location(in: self)

        debugPrint(point)

//        debugPrint(layer.sublayers?.count)
//
//        guard let layers = layer.sublayers else { return }




    }
}

extension ChartView {
//    private func drawRect() {
//        //第一步获得上下文
//        guard let cakeContextRef: CGContext = UIGraphicsGetCurrentContext() else { return }
//        //反锯齿,让图形边缘更加柔和（Sets whether or not to allow anti-aliasing for a graphics context.）
//        cakeContextRef.setAllowsAntialiasing(true)
//        //缩放坐标系的比例，通过设置y轴压缩，然后画代阴影的厚度，就画出了像是3D饼图的效果
//        cakeContextRef.scaleBy(x: xScale, y: yScale)
//        //饼图最先的起始角度
//        var startAngle: CGFloat = 0.0
//
//        for pie in pieDataSource {
//
//            let pieLayer = CALayer()
//            layer.addSublayer(pieLayer)
//
//
//
//            //cake当前的角度
//            let currentAngle = pie.column
//            //结束的角度
//            let endAngle = startAngle + currentAngle
//            //每一块cake的起点,也就是圆心
//            cakeContextRef.move(to: CGPoint(x: pieCenter.x, y: pieCenter.y))
//
//            //添加对应角度扇形
//            cakeContextRef.addArc(center: pieCenter,
//                                  radius: pieRadius,
//                                  startAngle: startAngle.angle,
//                                  endAngle: endAngle.angle,
//                                  clockwise: false)
//
//            //设置边界颜色
//            cakeContextRef.setStrokeColor(pie.color.cgColor)
//            //设置填充颜色
//            cakeContextRef.setFillColor(pie.color.cgColor)
//            //画子路径，这里就绘制还不是在画完厚度再绘制，是因为并不需要绘制所有cake的厚度，但是上一部分的圆是都要绘制的
//            cakeContextRef.drawPath(using: .fill)
//            //饼图上一部分圆，startAngle处的起点坐标
//            let upStartX = pieCenter.x + pieRadius * cos(startAngle.angle)
//            let upStartY = pieCenter.y + pieRadius * sin(startAngle.angle)
//            //饼图上一部分圆，endAngle处的终点坐标
//            let upEndX = pieCenter.x + pieRadius * cos(endAngle.angle)
//            let upEndY = pieCenter.y + pieRadius * sin(endAngle.angle)
//
//            //饼图厚度在角度结束处y坐标
//            let downEndY = upEndY + pieHeight
//
//            //画圆柱的侧面，饼图的厚度，圆柱的前半部分能看到，后半部分是看不到
//            //开始的角度如果>=M_PI，就会在圆柱的后面，侧面厚度就没必要画了
//            if (startAngle < 0.5) {
//                //绘制厚度
//                let path: CGMutablePath = CGMutablePath()
//                path.move(to: CGPoint(x: upStartX, y: upStartX))
//                //当结束的角度>0.5*2*M_PI时，结束的角度该是M_PI的地方（视觉原因）
//                if (endAngle > 0.5) {
//                    //上部分的弧
//                    path.addArc(center: pieCenter,
//                                radius: pieRadius,
//                                startAngle: startAngle.angle,
//                                endAngle: CGFloat.pi,
//                                clockwise: false)
//                    //在角度结束的地方，上部分到下部分的直线
//                    path.addLine(to: CGPoint(x: pieCenter.x - pieRadius, y: pieCenter.y + pieHeight))
//                    //下部分的弧
//                    path.addArc(center: CGPoint(x: pieCenter.x, y: pieCenter.y + pieHeight),
//                                radius: pieRadius,
//                                startAngle: CGFloat.pi,
//                                endAngle: startAngle.angle,
//                                clockwise: true)
//                    //在角度开始的地方，从下部分到上部分的直线
//                    path.addLine(to: CGPoint(x: upStartX, y: upStartY))
//
//                } else {
//                    //上部分的弧
//                    path.addArc(center: pieCenter,
//                                radius: pieRadius,
//                                startAngle: startAngle.angle,
//                                endAngle: endAngle.angle,
//                                clockwise: false)
//                    //在角度结束的地方，上部分到下部分的直线
//                    path.addLine(to: CGPoint(x: upEndX, y: downEndY))
//                    //下部分的弧
//                    path.addArc(center: CGPoint(x: pieCenter.x, y: pieCenter.y + pieHeight),
//                                radius: pieRadius,
//                                startAngle: endAngle.angle,
//                                endAngle: startAngle.angle,
//                                clockwise: true)
//                    //在角度开始的地方，从下部分到上部分的直线
//                    path.addLine(to: CGPoint(x: upStartX, y: upStartY))
//
//                }
//                //之前这一段不是很明白，为啥设颜色和阴影都要draw一次
//                //我自己尝试并理解分析了一下，每次draw一下想当于，把当前的设置画出来，再次draw就在这基础上，再画当前的设置，这里加颜色和阴影就是一层一层的画上去。要是不draw的话，再设置颜色相当于重新设置了颜色，之前设置的颜色就无效了。
//                cakeContextRef.addPath(path)
//                cakeContextRef.drawPath(using: .fill)
//                //加阴影
//                UIColor(white: 0.1, alpha: 0.2).setFill()
//                cakeContextRef.addPath(path)
//                cakeContextRef.drawPath(using: .fill)
//            }
//            //最后一句，上一块的结束角度是下一块的开始角度
//            startAngle = endAngle;
//        }
//    }
    
    
    private func drawRect() {
        
        while pieDataSource.count > layer.sublayers?.count ?? 0 {
            let pieLayer = CAShapeLayer()
            layer.addSublayer(pieLayer)
        }
        
        var startAngle: CGFloat = 0.0
        
        for (index, pie) in pieDataSource.enumerated() {
            if let subs = layer.sublayers, let pieLayer = subs[index] as? CAShapeLayer {
                let endAngle = startAngle + pie.column
                let piePath = UIBezierPath()
                piePath.move(to: pieCenter)
                piePath.addArc(withCenter: pieCenter, radius: pieRadius, startAngle: startAngle.angle, endAngle: endAngle.angle, clockwise: true)
                pieLayer.fillColor = pie.color.cgColor
                pieLayer.path = piePath.cgPath
                startAngle = endAngle
            }
        }
    }
}

class PieConfig: NSObject {
    var color: UIColor = UIColor.red
    var column: CGFloat = 0.0 // 比列
    var name: String = ""
}

extension CGFloat {
    var angle: CGFloat {
        return self * CGFloat.pi * 2
    }
}
