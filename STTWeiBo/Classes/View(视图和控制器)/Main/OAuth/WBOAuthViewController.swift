//
//  WBOAuthViewController.swift
//  STTWeiBo
//
//  Created by user on 16/12/13.
//  Copyright © 2016年 user. All rights reserved.
//

import UIKit

/// 通过webView加载新浪微博授权页面
class WBOAuthViewController: UIViewController {

    private lazy var webView = UIWebView()
    
    
    override func loadView() {
        /**
         换了根视图
         */
        view = webView
        
        view.backgroundColor = UIColor.whiteColor()
        
        //设置导航栏
        title = "登录新浪微博"
        //导航栏按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", target: self, action: #selector(close), isBack: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
//Mark: 监听方法
    @objc private func close(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
