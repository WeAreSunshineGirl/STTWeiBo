//
//  WBComposeViewController.swift
//  STTWeiBo
//
//  Created by user on 17/1/12.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit

/// 撰写微博控制器
class WBComposeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.cz_randomColor()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "退出", target: self, action: #selector(back))

    }
     @objc private func back(){
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
