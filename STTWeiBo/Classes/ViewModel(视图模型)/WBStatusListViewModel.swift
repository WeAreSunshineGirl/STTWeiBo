
//
//  WBStatusListViewModel.swift
//  STTWeiBo
//
//  Created by user on 16/12/9.
//  Copyright © 2016年 user. All rights reserved.
//

import Foundation

/// 微博数据列表视图模型
/*
 父类的选择
 -如果类需要使用 'KVC' 或者字典转模型框架设置对象值 类就需要继承自 NSObject
 -如果类只是包装一些代码逻辑（写了一些函数）,可以不用任何父类 好处：更加轻量级
 -提示：如果OC写 一律继承自 NSObject即可
 
 使命 ：负责微博的数据处理
 1 字典转模型
 2 下拉/上拉刷新数据处理
 */

/// 上拉刷新最大尝试次数
private let maxPullupTryTimes = 3

class WBStatusListViewModel {
    
    /// 微博视图模型 数组 懒加载
    lazy var statusList = [WBStatusViewModel]()
    /// 上拉刷新错误次数
    private var pullupErrorTimes = 0
    
    /**
     加载微博列表
     
     - parameter pullup:     是否上拉刷新标记
     - parameter completion: 完成回调[网络请求是否成功,是否刷新表格]
     */
    func loadStatus(pullup:Bool,completion:(isSuccess:Bool,shouldRefresh:Bool)->()) {
        
        //判断是否是上拉刷新 同时检查刷新错误
        if pullup && pullupErrorTimes > maxPullupTryTimes{
            
            completion(isSuccess: true, shouldRefresh: false)
            
            return
        }
        
        //since_id 下拉 取出数组中第一条微博的id
        let since_id = pullup ? 0 : (statusList.first?.status.id ?? 0)
        //上拉刷新 取出数组中最后一条微博的id
        let max_id = !pullup ? 0 : (statusList.last?.status.id ?? 0)
        
        WBNetworkManager.shared.statusList(since_id,max_id: max_id) { (list, isSuccess) in
//            print(list) //list 是一个字典数组
            
            // 0 判断网络请求失败 直接返回
            if !isSuccess{
                //直接回调返回
                completion(isSuccess: false, shouldRefresh: false)
                
                return
            }

            //1 字典转模型 (所有第三方框架都支持嵌套的字典转模型)
            // 1> 定义结果可变数组
            var array = [WBStatusViewModel]()
            
            // 2> 遍历服务器返回的字典数组 字典转模型 
            for dict in list ?? []{
                
//                // a)创建微博模型 - 如果创建模型失败 继续后续的遍历
//                guard let model = WBStatus.yy_modelWithJSON(dict) else{
//                    
//                    continue
//                }
//                
//                // b) 将 视图模型 添加到数组
//                array.append(WBStatusViewModel(model: model))
                
//                print(dict)
                // 1> 创建微博模型
                let status = WBStatus()
                
                //2> 使用字典设置模型数组
                status.yy_modelSetWithDictionary(dict)
                
                //3> 使用 微博 模型创建 微博视图 模型
                let viewModel = WBStatusViewModel(model: status)
                
                //4> 添加到数组
                array.append(viewModel)
            }
            print("刷新到 \(array.count)条数据\(array)")
            
            //2 拼接数据
            if pullup{
                //上拉刷新结束后 将结果拼接在数组末尾
                self.statusList += array
            }else{
                //下拉刷新 应该将结果数组拼接在数组前面
                self.statusList = array + self.statusList
            }
            
            //3 判断上拉刷新的数据量
            if pullup && array.count == 0{
                
                self.pullupErrorTimes += 1
                
                completion(isSuccess: isSuccess, shouldRefresh: false)
                
            }else{
                //4 完成回调
                completion(isSuccess: isSuccess,shouldRefresh: true)
            }
            
            
        }
    }
}