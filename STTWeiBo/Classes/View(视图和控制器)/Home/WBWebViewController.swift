//
//  WBWebViewController.swift
//  STTWeiBo
//
//  Created by user on 17/3/30.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit

/// 网页控制器
class WBWebViewController: WBBaseViewController {

    private lazy var webView = UIWebView(frame: UIScreen.mainScreen().bounds)
    
    /// 要加载的URL 字符串
    var urlString:String?{
        
        didSet{
            guard let urlString = urlString,url = NSURL(string: urlString)else{
                return
            }
            webView.loadRequest(NSURLRequest(URL: url))
        }
    }
}
extension WBWebViewController{
    
    override func setupTableView() {
        
        navItem.title = "网页"
        
        //设置 webView
        view.insertSubview(webView, belowSubview: navigationBar)
        
        webView.backgroundColor = UIColor.whiteColor()
        
        //设置contentInset
        webView.scrollView.contentInset.top = navigationBar.bounds.height

    }
}