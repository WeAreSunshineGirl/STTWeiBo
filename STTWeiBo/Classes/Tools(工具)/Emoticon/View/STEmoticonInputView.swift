//
//  STEmoticonInputView.swift
//  表情键盘
//
//  Created by user on 17/4/5.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit

//表情输入视图
class STEmoticonInputView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var toolbar: UIView!
    //加载并且返回输入视图
    class func inputView()->STEmoticonInputView{
        
        let nib = UINib(nibName: "STEmoticonInputView", bundle: nil)
        let v = nib.instantiateWithOwner(nil, options: nil)[0] as! STEmoticonInputView
        
        return v
    }
    
}
