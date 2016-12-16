//
//  WBOAuthViewController.swift
//  STTWeiBo
//
//  Created by user on 16/12/13.
//  Copyright © 2016年 user. All rights reserved.
//

import UIKit
import SVProgressHUD

/// 通过webView加载新浪微博授权页面
class WBOAuthViewController: UIViewController {

    private lazy var webView = UIWebView()
    
    
    override func loadView() {
        /**
         换了根视图
         */
        view = webView
        
        view.backgroundColor = UIColor.whiteColor()
        
        //取消滚动视图 -新浪微博的服务器返回的授权界面默认就是手机全屏
        webView.scrollView.scrollEnabled = false
        
        //设置代理
        webView.delegate = self
        
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
    /**
     关闭控制器
     */
    @objc private func close(){
        
        SVProgressHUD.dismiss()
        dismissViewControllerAnimated(true, completion: nil)
    }
    //Mark 自动填充 - webView 的注入 直接通过js 修改‘本地浏览器’ 缓存的页面内容
    //点击登录按钮 执行 submit() 将本地数据提交给服务器！
    @objc private func autoFill(){
        //准备 js
        let js = "document.getElementById('userId').value = '18848950901';" + "document.getElementById('passwd').value = '18848950901';"
        //让webView执行 js
        webView.stringByEvaluatingJavaScriptFromString(js)
        
    }
}

// MARK: - UIWebViewDelegate
extension WBOAuthViewController:UIWebViewDelegate{
    
    /**
     webView 将要加载请求
     
     - parameter webView:        webView
     - parameter request:        要加载的请求
     - parameter navigationType: 导航类型
     
     - returns: 是否加载 request
     */
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        //确认思路：
        //1 如果请求地址包含 http://www.baidu.com 不加载页面  / 否则加载页面
        //request.URL?.absoluteString.hasPrefix(WBRedirectURI) 返回的是可选项 true/false/nil
        if request.URL?.absoluteString.hasPrefix(WBRedirectURI) == false{
            return true
        }
        print("加载请求 ---\(request.URL?.absoluteString)")
        //query 就是  URL 中 '?' 后面的所有部分
        print("加载请求 ---\(request.URL?.query)")
        // 2 从http://baidu.com 回调地址的 查询字符串 中 查找 'code='
        //  如果有 就说明授权成功  否则 授权失败
        if request.URL?.query?.hasPrefix("code=") == false {
            
            print("取消授权")
            close()
            
            return false
        }
        
        // 3 从query 字符串中取出授权码
        //代码走到这此处 url 中一定有查询字符串 并且包含'code'
        //  code=109d37eb09a74964e8c99195bb719093
        let code = request.URL?.query?.substringFromIndex("code=".endIndex) ?? ""
       
        print("获取授权码---\(code)")
        // 4 使用授权码获取（换取） Accesstoken
        WBNetworkManager.shared.loadAccessToken(code) { (isSuccess) in
            
            if !isSuccess{
                SVProgressHUD.showInfoWithStatus("网络请求失败")
            }else{
//                SVProgressHUD.showInfoWithStatus("登陆成功")
                
                //下一步做什么？通过通知发送登录成功消息 跳转界面
                // 1 发送通知
                NSNotificationCenter.defaultCenter().postNotificationName(WBUserLoginSuccessNotification, object: nil)
                
                // 2 关闭窗口
                self.close()
            }
        }
        
        return false
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.show()
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
}
