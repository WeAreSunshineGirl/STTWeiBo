//
//  PicturePickerController.swift
//  01-照片选择
//
//  Created by male on 15/10/26.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

/// 可重用 cell
private let PicturePickerCellId = "PicturePickerCellId"
/// 最大选择照片数量 － 开发测试的时候，尽量把所有的边界测试到位
/// 建议：先将临界数值设置小一些，保证能够测试到，再修改到目标数值！
private let PicturePickerMaxCount = 3

/// 照片选择控制器
class PicturePickerController: UICollectionViewController {

    /// 配图数组
    lazy var pictures = [UIImage]()
    /// 当前用户选中的照片索引
    private var selectedIndex = 0
    
    // MARK: - 构造函数
    init() {
        super.init(collectionViewLayout: PicturePickerLayout())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 在 CollectionViewController 中 collectionView != view
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        
        // 注册可重用 Cell
        self.collectionView!.registerClass(PicturePickerCell.self, forCellWithReuseIdentifier: PicturePickerCellId)
    }
    
    // MARK: - 照片选择器布局
    private class PicturePickerLayout: UICollectionViewFlowLayout {
        
        private override func prepareLayout() {
            super.prepareLayout()
            
            // iOS 9.0 之后，尤其是 iPad 支持分屏，不建议过分依赖 UIScreen 作为布局参照！
            // iPhone 6s- 2/iPhone 6s+ 3
            let count: CGFloat = 4
            let margin = UIScreen.mainScreen().scale * 4
            let w = (collectionView!.bounds.width - (count + 1) * margin) / count
            
            itemSize = CGSize(width: w, height: w)
            sectionInset = UIEdgeInsetsMake(margin, margin, 0, margin)
            minimumInteritemSpacing = margin
            minimumLineSpacing = margin
        }
    }
}

extension PicturePickerController {
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        // 保证末尾有一个加号按钮，如果达到上限，不显示 + 按钮！
        return pictures.count + (pictures.count == PicturePickerMaxCount ? 0 : 1)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PicturePickerCellId, forIndexPath: indexPath) as! PicturePickerCell
        
        // 设置图像
        cell.image = (indexPath.item < pictures.count) ? pictures[indexPath.item] : nil
        // 设置代理
        cell.pictureDelegate = self
        
        return cell
    }
}

// MARK: - PicturePickerCellDelegate
extension PicturePickerController: PicturePickerCellDelegate {
    
    @objc private func picturePickerCellDidAdd(cell: PicturePickerCell) {
        
        // 判断是否允许访问相册
        /**
            PhotoLibrary            保存的照片(可以删除) + 同步的照片(不允许删除)
            SavedPhotosAlbum        保存的照片/屏幕截图/拍照
        */
        if !UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            print("无法访问照片库")
            return
        }
        
        // 记录当前用户选中的照片索引
        selectedIndex = collectionView?.indexPathForCell(cell)?.item ?? 0
        
        // 显示照片选择器
        let picker = UIImagePickerController()
        
        // 设置代理
        picker.delegate = self
        // picker.allowsEditing = true
        
        presentViewController(picker, animated: true, completion: nil)
    }
    
    @objc private func picturePickerCellDidRemove(cell: PicturePickerCell) {

        // 1. 获取照片索引
        let indexPath = collectionView!.indexPathForCell(cell)!
        
        // 2. 判断索引是否超出上限
        if indexPath.item >= pictures.count {
            return
        }
        
        // 3. 删除数据
        pictures.removeAtIndex(indexPath.item)
        
        // 4. 动画刷新视图 - 重新调用数据行数的数据源方法(内部实现要求 3 － 删除一个 indexPath － 数据源方法如果不返回 2，就会崩溃！)
        // collectionView?.deleteItemsAtIndexPaths([indexPath])
        // reloadData 方法只是单纯的刷新数据，没有动画，但是不会检测具体的 item 的数量
        collectionView?.reloadData()
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension PicturePickerController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /// 照片选择完成
    ///
    /// - parameter picker: 照片选择控制器
    /// - parameter info:   info 字典
    /// - 提示：一旦实现代理方法，必须自己 dismiss
    /// - picker.allowsEditing = true
    /// - 适合用于`头像`选择
    /// - UIImagePickerControllerEditedImage
    /**
        如果使用 cocos2dx 开发一个`空白的模板`游戏，内存占用 70M，iOS UI的空白应用程序，大概 19M
    
        一般应用程序，内存在 100M 左右都是能够接受的！再高就需要注意！
    */
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let scaleImage = image.scaleToWith(600)
        
        // 将图像添加到数组
        // 判断当前选中的索引是否超出数组上限
        if selectedIndex >= pictures.count {
            pictures.append(scaleImage)
        } else {
            pictures[selectedIndex] = scaleImage
        }
        
        // 刷新视图
        collectionView?.reloadData()
        
        // 释放控制器
        dismissViewControllerAnimated(true, completion: nil)
    }
}

/// PicturePickerCellDelegate 代理
/// 如果协议中包含 optional 的函数，协议需要使用 @objc 修饰
@objc
private protocol PicturePickerCellDelegate: NSObjectProtocol {
    
    /// 添加照片
    optional func picturePickerCellDidAdd(cell: PicturePickerCell)
    
    /// 删除照片
    optional func picturePickerCellDidRemove(cell: PicturePickerCell)
}

/// 照片选择 Cell - private修饰类，内部的一切方法和属性，都是私有的
private class PicturePickerCell: UICollectionViewCell {

    /// 照片选择代理
    weak var pictureDelegate: PicturePickerCellDelegate?
    
    var image: UIImage? {
        didSet {
            addButton.setImage(image ?? UIImage(named: "compose_pic_add"), forState: .Normal)
            
            // 隐藏删除按钮 image == nil 就是新增按钮
            removeButton.hidden = (image == nil)
        }
    }
    
    // MARK: - 监听方法
    @objc func addPicture() {
        pictureDelegate?.picturePickerCellDidAdd?(self)
    }
    
    @objc func removePicture() {
        pictureDelegate?.picturePickerCellDidRemove?(self)
    }
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 设置控件
    private func setupUI() {
        // 1. 添加控件
        contentView.addSubview(addButton)
        contentView.addSubview(removeButton)
        
        // 2. 设置布局
        addButton.frame = bounds
        
        removeButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp_top)
            make.right.equalTo(contentView.snp_right)
        }
        
        // 3. 监听方法
        addButton.addTarget(self, action: "addPicture", forControlEvents: .TouchUpInside)
        removeButton.addTarget(self, action: "removePicture", forControlEvents: .TouchUpInside)
        
        // 4. 设置填充模式
        addButton.imageView?.contentMode = .ScaleAspectFill
    }
    
    // MARK: - 懒加载控件
    /// 添加按钮
    private lazy var addButton: UIButton = UIButton(imageName: "compose_pic_add", backImageName: nil)
    /// 删除按钮
    private lazy var removeButton: UIButton = UIButton(imageName: "compose_photo_close", backImageName: nil)
}