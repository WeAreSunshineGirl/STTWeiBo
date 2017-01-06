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
    
    //父视图的高度
    override var parentViewHeight:CGFloat{
        
        didSet{
            print("父视图的高度 \(parentViewHeight)")
            
            if parentViewHeight < 23 {
                return
            }
            // 23 -125
            // 0.2 - 1
            // 高度差 / 最大高度差
            // 23 ==1->0.2
            // 125 == 0 ->1
            var scale:CGFloat
            
            if parentViewHeight > 125 {
                scale = 1
            }else{
                scale = 1 - ((125 - parentViewHeight) / (125 - 23))
            }
            kangarooIconView.transform = CGAffineTransformMakeScale(scale, scale)
        }
    }
    
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
        // 0>设置袋鼠动画
        let KImage1 = UIImage(named: "1")
        let KImage2 = UIImage(named: "2")
        let KImage3 = UIImage(named: "3")
        let KImage4 = UIImage(named: "4")
        kangarooIconView.image = UIImage.animatedImageWithImages([KImage1!,KImage2!,KImage3!,KImage4!], duration: 0.5)
        
        // 1>设置锚点
        kangarooIconView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)

        // 2> 设置center
        let x = self.bounds.width * 0.5
        let y = self.bounds.height - 23
        kangarooIconView.center = CGPoint(x: x, y: y)
        
        kangarooIconView.transform = CGAffineTransformMakeScale(0.2, 0.2)
        
        
    }
}
