//
//  StarRatingView.swift
//  ProjectSwiftDemo
//
//  Created by 张书孟 on 2018/9/10.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit

@objc protocol StarRatingViewDelegate: NSObjectProtocol {
    
    @objc optional func starRating(view: StarRatingView, score: Float)
}

enum RateStyle {
    case wholeStar // 只能整星评论
    case halfStar // 允许半星评论
    case incompleteStar // 允许不完整星评论
}

class StarRatingView: UIView {

    private lazy var starBackgroundView: UIView = {
        buidlStarView(imageName: backgroundStarImg)
    }()
    
    private lazy var starForegroundView: UIView = {
        buidlStarView(imageName: foregroundStarImg)
    }()
    
    private var numberStar: Int = 5
    
    weak var delegate: StarRatingViewDelegate?
    var backgroundStarImg: String = "icon_star_unfilled"
    var foregroundStarImg: String = "icon_star_filled"
    var rateStyle: RateStyle = .wholeStar
    var isEnabled: Bool = true {
        didSet {
            self.isUserInteractionEnabled = isEnabled
        }
    }
    var currentScore: Float = 5.0 {
        didSet {
            if currentScore > Float(numberStar) {
                currentScore = Float(numberStar)
            }
            let point = CGPoint(x: CGFloat(currentScore) * frame.size.width / CGFloat(numberStar), y: 0)
            changeStarForegroundView(point: point)
        }
    }
    
    // MARK: Touche Event
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = (touches as NSSet).anyObject() as! UITouch
        let p: CGPoint = touch.location(in: self)
        let react: CGRect = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        if react.contains(p) {
            changeStarForegroundView(point: p)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = (touches as NSSet).anyObject() as! UITouch
        let p: CGPoint = touch.location(in: self)
        UIView.animate(withDuration: 0.25) {
            self.changeStarForegroundView(point: p)
        }
    }

    convenience init(frame: CGRect, numberOfStar: Int) {
        self.init(frame: frame)
        self.numberStar = numberOfStar
        addSubViews()
    }
}

extension StarRatingView {
    
    private func addSubViews() {
        
        addSubview(starBackgroundView)
        addSubview(starForegroundView)
    }
    
    /// 通过图片构建星星视图
    ///
    /// - Parameter imageName: 图片名称
    /// - Returns: 星星视图
    private func buidlStarView(imageName: String) -> UIView {
        let frame: CGRect = self.bounds
        let view: UIView = UIView(frame: frame)
        view.clipsToBounds = true
        for i in 0...numberStar {
            let imageView: UIImageView = UIImageView(image: UIImage(named: imageName))
            imageView.frame = CGRect(x: CGFloat(i) * frame.size.width / CGFloat(numberStar), y: 0, width: frame.size.width / CGFloat(numberStar), height: frame.size.height)
            view.addSubview(imageView)
        }
        return view
    }
    
    /// 通过坐标改变前景视图
    ///
    /// - Parameter point: 坐标
    private func changeStarForegroundView(point: CGPoint) {
        var p: CGPoint = point
        
        var offsetX = p.x
        
        if offsetX < 0 {
            offsetX = 0
        }
        
        if offsetX > frame.size.width {
            offsetX = frame.size.width
        }
        
        let realStarScore = offsetX / (frame.size.width / CGFloat(numberStar))
        
        var score: Float = 0.0
        
        switch rateStyle {
        case .wholeStar:
            score = ceilf(Float(realStarScore))
            break
        case .halfStar:
            
            if Float(realStarScore) == 0 {
                score = 0
            } else if Float(realStarScore) > 0 && Float(realStarScore) < 0.5 {
                score = 0.5
            } else if roundf(Float(realStarScore)) == Float(numberStar) {
                score = Float(numberStar)
            } else if roundf(Float(realStarScore)) >= Float(realStarScore) {
                score = roundf(Float(realStarScore))
            } else {
                score = ceilf(Float(realStarScore)) - 0.5
            }
            break
        case .incompleteStar:
            score = Float(realStarScore)
            break
        }
        p.x = CGFloat(score) * frame.size.width / CGFloat(numberStar)
        starForegroundView.frame = CGRect(x: 0, y: 0, width: p.x, height: frame.size.height)
        
        if let delegate = delegate {
            delegate.starRating!(view: self, score: score)
        }
    }
}
