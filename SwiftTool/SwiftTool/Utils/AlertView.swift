//
//  AlertView.swift
//  SwiftTool
//
//  Created by 张书孟 on 2018/10/16.
//  Copyright © 2018年 zsm. All rights reserved.
//

import UIKit

enum AlertTap {
    case confirm /// 确定
    case cancel /// 取消
    case mask /// 点击蒙版
}

class AlertView: UIView {

    private var title: String = ""
    private var detail: String = ""
    private var leftText: String = "取消"
    private var rightText: String = "确定"
    
    private let alertWidth = UIScreen.main.bounds.size.width - 130
    private var topViewHeight: CGFloat = 96
    private var buttonHeight: CGFloat = 44
    /// color
    private let maskColor: UIColor = UIColor.dark.alpha(0.3)
    private let titleTextColor: UIColor = UIColor.dark
    private let detailTextColor: UIColor = UIColor.dark
    private let leftTextColor: UIColor = UIColor(red: 0, green: 111/255, blue: 255/255, alpha: 1.0)
    private let rightTextColor: UIColor = UIColor(red: 0, green: 111/255, blue: 255/255, alpha: 1.0)
    private let lineColor: UIColor = UIColor.dark.alpha(0.1)
    private let alertColor: UIColor = UIColor.white
    /// font
    private let titleFont: UIFont = UIFont.boldSystemFont(ofSize: 17)
    private let detailFont: UIFont = UIFont.systemFont(ofSize: 13)
    private let leftFont: UIFont = UIFont.systemFont(ofSize: 17)
    private let rightFont: UIFont = UIFont.systemFont(ofSize: 17)
    
    private lazy var alertMaskView: UIView = {
        let alertMaskView = UIView(frame: UIScreen.main.bounds)
        alertMaskView.backgroundColor = maskColor
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(maskAction))
        alertMaskView.addGestureRecognizer(tap)
        return alertMaskView
    }()
    
    private lazy var alertBgView: UIView = {
        let alertBgView = UIView()
        alertBgView.backgroundColor = UIColor.clear
        return alertBgView
    }()
    
    private lazy var topView: UIView = {
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: alertWidth, height: topViewHeight))
        topView.backgroundColor = alertColor
        topView.corner(byRoundingCorners: [.topLeft,.topRight], radii: 13)
        return topView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = titleTextColor
        titleLabel.font = titleFont
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.text = title
        return titleLabel
    }()
    
    private lazy var detailLabel: UILabel = {
        let detailLabel = UILabel()
        detailLabel.textColor = detailTextColor
        detailLabel.font = detailFont
        detailLabel.numberOfLines = 0
        detailLabel.textAlignment = .center
        detailLabel.text = detail
        return detailLabel
    }()
    
    private lazy var lineView1: UIView = {
        let lineView1 = UIView()
        lineView1.backgroundColor = lineColor
        return lineView1
    }()
    
    private lazy var lineView2: UIView = {
        let lineView2 = UIView()
        lineView2.backgroundColor = lineColor
        return lineView2
    }()
    
    private lazy var leftBtn: UIButton = {
        let leftBtn = UIButton(frame: CGRect(x: 0, y: 0, width: alertWidth / 2, height: buttonHeight))
        leftBtn.setTitle(leftText, for: .normal)
        leftBtn.setTitleColor(leftTextColor, for: .normal)
        leftBtn.titleLabel?.font = leftFont
        leftBtn.backgroundColor = alertColor
        leftBtn.corner(byRoundingCorners: [.bottomLeft], radii: 13)
        leftBtn.addTarget(self, action: #selector(leftBtnClick), for: .touchUpInside)
        return leftBtn
    }()
    
    private lazy var rightBtn: UIButton = {
        let rightBtn = UIButton(frame: CGRect(x: 0, y: 0, width: alertWidth / 2, height: buttonHeight))
        rightBtn.setTitle(rightText, for: .normal)
        rightBtn.setTitleColor(rightTextColor, for: .normal)
        rightBtn.titleLabel?.font = rightFont
        rightBtn.backgroundColor = alertColor
        rightBtn.corner(byRoundingCorners: [.bottomRight], radii: 13)
        rightBtn.addTarget(self, action: #selector(rightBtnClick), for: .touchUpInside)
        return rightBtn
    }()
    
    var callBack: (AlertTap) -> Void = { _ in }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// public
extension AlertView {
    
    class func alert(title: String, detail: String, leftText: String, rightText: String, callBack: @escaping (AlertTap) -> ()) {
        let alertView: AlertView = AlertView()
        alertView.topViewHeight = alertView.topViewHeight(title: title, detail: detail)
        alertView.title = title
        alertView.detail = detail
        alertView.leftText = leftText
        alertView.rightText = rightText
        alertView.callBack = callBack
        alertView.addSubViews()
        alertView.show()
    }
    
    class func alert(title: String, detail: String, callBack: @escaping (AlertTap) -> ()) {
        let alertView: AlertView = AlertView()
        alertView.topViewHeight = alertView.topViewHeight(title: title, detail: detail)
        alertView.title = title
        alertView.detail = detail
        alertView.callBack = callBack
        alertView.addSubViews()
        alertView.show()
    }
    
    class func alert(title: String, callBack: @escaping (AlertTap) -> ()) {
        let alertView: AlertView = AlertView()
        alertView.topViewHeight = alertView.topViewHeight(title: title, detail: "")
        alertView.title = title
        alertView.callBack = callBack
        alertView.addSubViews()
        alertView.show()
    }
}

extension AlertView {
    
    private func hide() {
        UIView.animate(withDuration: 0.25, animations: {
            self.alertMaskView.alpha = 0
            self.alertBgView.alpha = 0
            self.alpha = 0
            self.alertBgView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    
    private func show() {
        let animation: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "transform")
        animation.duration = 0.25
        animation.isRemovedOnCompletion = true
        animation.fillMode = CAMediaTimingFillMode.forwards
        var value = [Any]()
        value.append(NSValue(caTransform3D: CATransform3DMakeScale(0.8, 0.8, 1.0)))
        value.append(NSValue(caTransform3D: CATransform3DMakeScale(1.1, 1.1, 1.0)))
        value.append(NSValue(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)))
        animation.values = value
        alertBgView.layer.add(animation, forKey: nil)
    }
    
    private func topViewHeight(title: String = "", detail: String = "") -> CGFloat {
        let titleH = title.isEmpty ? 0 : title.get_heightForComment(fontSize: 17, width: alertWidth - 32)
        let detailH = detail.isEmpty ? 0 : detail.get_heightForComment(fontSize: 13, width: alertWidth - 32)
        let height = 19 + titleH + detailH + 20
        
        if height < topViewHeight && !detail.isEmpty {
            return topViewHeight
        }
        return height
    }
}

extension AlertView {
    
    private func addSubViews() {
        UIApplication.shared.keyWindow?.addSubview(self)
        addSubview(alertMaskView)
        addSubview(alertBgView)
        alertBgView.addSubview(topView)
        topView.addSubview(titleLabel)
        topView.addSubview(detailLabel)
        
        alertBgView.addSubview(leftBtn)
        alertBgView.addSubview(rightBtn)
        
        alertBgView.addSubview(lineView1)
        alertBgView.addSubview(lineView2)
        
        alertBgView.snp.makeConstraints { (make) in
            make.centerX.equalTo(alertMaskView.snp.centerX)
            make.centerY.equalTo(alertMaskView.snp.centerY)
            make.size.equalTo(CGSize(width: alertWidth, height: topViewHeight + buttonHeight))
        }
        
        /// top
        topView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(alertBgView)
            make.height.equalTo(topViewHeight)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(topView.snp.left).offset(16)
            make.top.equalTo(topView.snp.top).offset(19)
            make.right.equalTo(topView.snp.right).offset(-16)
        }
        
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(topView.snp.left).offset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(13)
            make.right.equalTo(topView.snp.right).offset(-16)
        }
        
        /// bottom
        leftBtn.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(alertBgView)
            make.size.equalTo(CGSize(width: alertWidth / 2, height: buttonHeight))
        }
        
        rightBtn.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(alertBgView)
            make.size.equalTo(CGSize(width: alertWidth / 2, height: buttonHeight))
        }
        
        lineView1.snp.makeConstraints { (make) in
            make.left.right.equalTo(alertBgView)
            make.top.equalTo(topView.snp.bottom)
            make.height.equalTo(0.5)
        }
        
        lineView2.snp.makeConstraints { (make) in
            make.left.equalTo(leftBtn.snp.right)
            make.top.equalTo(lineView1.snp.bottom)
            make.bottom.equalTo(leftBtn.snp.bottom)
            make.width.equalTo(0.5)
        }
    }
}

extension AlertView {
    
    @objc private func maskAction() {
        hide()
        callBack(.mask)
    }
    
    @objc private func leftBtnClick() {
        hide()
        callBack(.cancel)
    }
    
    @objc private func rightBtnClick() {
        hide()
        callBack(.confirm)
    }
}
