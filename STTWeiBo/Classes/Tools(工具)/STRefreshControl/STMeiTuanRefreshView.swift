//
//  STMeiTuanRefreshView.swift
//  刷新控件
//
//  Created by user on 17/1/5.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit

class STMeiTuanRefreshView: STRefreshView {

  
    @IBOutlet weak var bulidingIconView: UIImageView!

    @IBOutlet weak var earthIconView: UIImageView!
    
    @IBOutlet weak var kangarooIconView: UIImageView!
    
    
    override func awakeFromNib() {
        //1 设置房子
        let bImage1 = UIImage(named: "fangzi")
        let bImage2 = UIImage(named: "fangzi")
        
        bulidingIconView.image = UIImage.animatedImageWithImages([bImage1!,bImage2!], duration: 0.5)
        // 2设置地球
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = -2 * M_PI
        anim.repeatCount = MAXFLOAT
        anim.duration = 5
        anim.removedOnCompletion = false
        
        earthIconView.layer.addAnimation(anim, forKey: nil)
        
        // 3 袋鼠
        // 1>设置锚点
        kangarooIconView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)

        // 2> 设置center
        let x = self.bounds.width * 0.5
        let y = self.bounds.height - 10
        kangarooIconView.center = CGPoint(x: x, y: y)
        
        kangarooIconView.transform = CGAffineTransformMakeScale(0.2, 0.2)
        
        
    }
}
