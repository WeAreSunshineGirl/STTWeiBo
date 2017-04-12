//
//  ProgressImageView.swift
//  Weibo10
//
//  Created by male on 15/10/27.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

/// 带进度的图像视图
/// 面试题：如果在 UIImageView 的 drawRect 中绘图会怎样？不会执行 drawRect 函数
class ProgressImageView: UIImageView {

    /// 外部传递的进度值 0~1
    var progress: CGFloat = 0 {
        didSet {
            progressView.progress = progress
        }
    }
    
    // MARK: - 构造函数
    // 一旦给构造函数指定了参数，系统不再提供默认的构造函数
    init() {
        super.init(frame: CGRectZero)

        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(progressView)
        progressView.backgroundColor = UIColor.clearColor()
        
        // 设置布局
        progressView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.snp_edges)
        }
    }
    
    // MARK: - 懒加载控件
    private lazy var progressView: ProgressView = ProgressView()
}

/// 进度视图
private class ProgressView: UIView {
    
    /// 内部使用的进度值 0~1
    var progress: CGFloat = 0 {
        didSet {
            // 重绘视图
            setNeedsDisplay()
        }
    }
    
    // rect == bounds
    override func drawRect(rect: CGRect) {
        
        let center = CGPoint(x: rect.width * 0.5, y: rect.height * 0.5)
        let r = min(rect.width, rect.height) * 0.5
        let start = CGFloat(-M_PI_2)
        let end = start + progress * 2 * CGFloat(M_PI)
        
        /**
            参数：
            1. 中心点
            2. 半径
            3. 起始弧度
            4. 截至弧度
            5. 是否顺时针
        */
        let path = UIBezierPath(arcCenter: center, radius: r, startAngle: start, endAngle: end, clockwise: true)
        
        // 添加到中心点的连线
        path.addLineToPoint(center)
        path.closePath()
        
        UIColor(white: 1.0, alpha: 0.3).setFill()
        
        path.fill()
    }
}
