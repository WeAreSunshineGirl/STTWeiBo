//
//  WBDemoViewController.swift
//  STTWeiBo
//
//  Created by user on 16/12/1.
//  Copyright © 2016年 user. All rights reserved.
//

import UIKit

class WBDemoViewController: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置标题
        title = "第\(navigationController?.childViewControllers.count ?? 0)个"
    }
    
    //MARK:-监听方法
    /**
     继续push一个新的控制器
     */
    @objc private func showNext(){
        let vc = WBDemoViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension WBDemoViewController{
    // 重写父类方法
    override func setupUI() {
        super.setupUI()
        // 设置右侧的控制器
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", style: .Plain, target: self, action: #selector(showNext))
//        let btn:UIButton = UIButton.cz_textButton("下一个", fontSize: 16, normalColor: UIColor.darkGrayColor(), highlightedColor: UIColor.orangeColor())
//        btn.addTarget(self, action: #selector(showNext), forControlEvents: .TouchUpInside)
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        
        navItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", target: self, action: #selector(showNext))
    }
}