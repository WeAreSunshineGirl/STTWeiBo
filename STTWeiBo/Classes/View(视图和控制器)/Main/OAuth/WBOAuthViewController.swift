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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", target: self, action: #selector(autoFill))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       //加载授权界面
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(WBAppKey)&redirect_uri=\(WBRedirectURI)"
        // 1 确定要访问的资源
        guard let url = NSURL(string: urlString)else{
            return
        }
        // 2 建立请求
        let request = NSURLRequest(URL: url)
        // 3加载请求
        webView.loadRequest(request)
    }

    
//Mark: 监听方法
    @objc private func close(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    //Mark 自动填充 - webView 的注入 直接通过js 修改‘本地浏览器’ 缓存的页面内容
    //点击登录按钮 执行 submit() 将本地数据提交给服务器！
    @objc private func autoFill(){
        //准备 js
        let js = "document.getElementById('userId').value = '18848950901';" + "document.getElementById('passwd').value = '18848950901';"
        //让webView执行 js
        webView.stringByEvaluatingJavaScriptFromString(js)
        
    }}
