
//
//  WBStatusListViewModel.swift
//  STTWeiBo
//
//  Created by user on 16/12/9.
//  Copyright © 2016年 user. All rights reserved.
//

import Foundation

import SDWebImage

// 管理网络数据的

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
        
        
        
        // ===== 让数据访问层加载数据
        WBStatusListDAL.loadStatus(since_id, max_id: max_id) { (list, isSuccess) in
      
            
            
//      ========== 让数据访问层加载数据  注释之前的网络请求  其实在网络访问层方法中使用了此方法
            
//        }
//        
//        //发起网络请求 加载微博数据[字典的数组]
//        WBNetworkManager.shared.statusList(since_id,max_id: max_id) { (list, isSuccess) in
//            
            
            
//            print(list) //list 是一个字典数组
            
            // 0 判断网络请求失败 直接返回
            if !isSuccess{
                //直接回调返回
                completion(isSuccess: false, shouldRefresh: false)
                
                return
            }

            //1 字典转模型 (所有第三方框架都支持嵌套的字典转模型)
            // 1> 定义结果可变数组   遍历字典数组 字典转 模型 => 视图模型 将视图模型添加到数组
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
//            print("刷新到 \(array.count)条数据\(array)")
            
            //2 拼接数据
            if pullup{
                //上拉刷新结束后 将结果拼接在数组末尾
                self.statusList += array
            }else{
                //下拉刷新 应该将结果数组拼接在数组前面
                self.statusList = array + self.statusList
            }
            
//            print(self.statusList)
            
            //3 判断上拉刷新的数据量
            if pullup && array.count == 0{
                
                self.pullupErrorTimes += 1
                
                completion(isSuccess: isSuccess, shouldRefresh: false)
                
            }else{
                
                self.cacheSingleImage(array,finishedCompletion:
                completion)
                
                //4 真正有数据的回调   此处的回调应该完成单张缓存之后 再回调  闭包是准备好的代码 可以当做参数传递
//                completion(isSuccess: isSuccess,shouldRefresh: true)
            }
            
            
        }
    }
    /**
     缓存本次下载微博数据数组中的单张图像
     // 应该缓存完单张图像 并且修改过配图视图的大小 再回调 才能够保证表格等比例显示单张图像！
     - parameter list: 本次下载的视图模型数组
     */
    private func cacheSingleImage(list:[WBStatusViewModel],finishedCompletion:(isSuccess:Bool,shouldRefresh:Bool)->()){
        
        // 调度组
        let group = dispatch_group_create()
        
        /// 记录数据长度 （一次请求 里面 所有单张图像的长度）
        var length = 0
        
        //遍历数组 查找微博数据中有单张图像的进行缓存
        for vm in list {
            // 1> 判断图像数量
            if vm.picURLs?.count != 1 {
                continue
            }
            
            // 2> 代码执行到此 数组中有且仅有一张图片 获取 图像模型
            guard let pic = vm.picURLs?[0].thumbnail_pic,let url = NSURL(string: pic)else{
                continue
            }
            
//            print("要缓存的url是 \(url)" )
            
            
            // 3> 下载图像
            // 1） downloadImage是 SDWebImage 的核心方法
            // 2)  图像下载完成之后会自动保存在沙盒中 文件路径是URL的 MD5
            // 3) 如果沙盒中已经存在缓存的图像 后续使用SDWebImage通过url加装图像 都会加载本地沙盒的图像
            // 4) 不会发起网络请求 同时  回调方法 同样会调用
            // 5) 方法还是同样的方法 调用还是同样的调用 不过内部不会再次发起网络请求的
            // 注意 如果要缓存的图像累计很大 要找后台找接口
            
//            要缓存的url是 http://ww2.sinaimg.cn/thumbnail/625ab309jw1fb6beovporj20hi0bn0t1.jpg
//            要缓存的url是 http://ww3.sinaimg.cn/thumbnail/006ubROmgw1fb6b69m5ofj308h08mdgm.jpg
//            要缓存的url是 http://ww3.sinaimg.cn/thumbnail/905e665fgw1fam4zii2qvj20c00agwfk.jpg
            
            // A)入组
            dispatch_group_enter(group)
            
            SDWebImageManager.sharedManager().downloadImageWithURL(url, options: [], progress: nil, completed: { (image, _, _, _, _) in
                
                //将图像转换成二进制数据
                if let image = image,
                    let data = UIImagePNGRepresentation(image) {
                    
                    length += data.length
                    
                    // 图像 缓存成功 更新配图视图的大小
                    vm.updateSingleImageSize(image)
                    
                }
                
//                print("缓存的图像是 \(image) \(length)")
                
                // B）出组
                dispatch_group_leave(group)
            })
        }
        dispatch_group_notify(group, dispatch_get_main_queue()) { 
            print("图像缓存完成 \(length / 1024) k")
            
            //执行闭包回调
            finishedCompletion(isSuccess: true, shouldRefresh: true)
        }
    }
}