//
//  FFLabel.swift
//  SinaWeibo
//
//  Created by user on 16/8/23.
//  Copyright © 2016年 user. All rights reserved.
//

import UIKit

@objc
public protocol FFLabelDelegate:NSObjectProtocol{
    /**
     选择链接文本
     
     - parameter label: label
     - parameter text:  选中的文本
     */
    @objc optional func labelDidSelectedLinkText(label:FFLabel,text:String)
}


public class FFLabel: UILabel {

    public var linkTextColor = UIColor.blueColor()
    public var selectedBackgroundColor = UIColor.lightGrayColor()
    public weak var delegate:FFLabelDelegate?
    
    /// MarK:重写属性
    public override var text: String?{
        didSet{
            updateTextStorage()
        }
    }
    public override var attributedText: NSAttributedString?{
          didSet{
         updateTextStorage()
        }
    }
    public override var font: UIFont!{
          didSet{
         updateTextStorage()
        }
    }
    public override var textColor: UIColor!{
        didSet{
             updateTextStorage()
        }
    }
//MARK: 更新文本内容
    private func updateTextStorage(){
        if attributedText == nil{
            return
        }
        let attrStringM = addLineBreak(attributedText!)
        regexLinkRanges(attrStringM)
        addLinkAttribute(attrStringM)
            
        textStorage.setAttributedString(attrStringM)
    
        setNeedsDisplay()
    
    
    }
    private func addLinkAttribute(attrStringM:NSMutableAttributedString){
        if attrStringM.length == 0 {
            return
        }
        var range = NSRange(location: 0, length: 0)
        var attributes = attrStringM.attributesAtIndex(0, effectiveRange: &range)
        
        attributes[NSFontAttributeName] = font!
        attributes[NSForegroundColorAttributeName] = textColor
        attrStringM.addAttributes(attributes, range: range)
        attributes[NSForegroundColorAttributeName] = linkTextColor
        
        for r in linkRanges {
            attrStringM.setAttributes(attributes, range: r)
        }
    }
    
    private let patterns = ["[a-zA-Z]*://[a-zA-Z0-9/\\.]*","#.*?#","@[\\u4e00-\\u9fa5a-zA-Z0-9_-]*"]
    
    private func regexLinkRanges(attrString:NSAttributedString){
        linkRanges.removeAll()
        let regexRange = NSRange(location: 0, length: attrString.string.characters.count)
        for pattern in patterns {
            let regex = try? NSRegularExpression(pattern: pattern, options: [])
            let results = regex?.matchesInString(attrString.string, options: [], range: regexRange)
            for r in results! {
                linkRanges.append(r.rangeAtIndex(0))
            }
        }
    }
   
    // add line break mode
    private func addLineBreak(attrString:NSAttributedString)->NSMutableAttributedString{
        let attrStringM = NSMutableAttributedString(attributedString: attrString)
        
        if attrStringM.length == 0 {
            return attrStringM
        }
        var range = NSRange(location: 0, length: 0)
        var attributes = attrStringM.attributesAtIndex(0, effectiveRange: &range)
        var paragraphStyle = attributes[NSParagraphStyleAttributeName] as? NSMutableParagraphStyle
        
        if paragraphStyle != nil {
            paragraphStyle?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        }else{
            paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle?.lineBreakMode = NSLineBreakMode.ByWordWrapping
            attributes[NSParagraphStyleAttributeName] = paragraphStyle
            
            attrStringM.setAttributes(attributes, range: range)
        }
        return attrStringM
    }
    
    public override func drawTextInRect(rect: CGRect) {
        let range = glyphsRange()
        let offset = glyphsOffset(range)
        layoutManager.drawBackgroundForGlyphRange(range, atPoint: offset)
        layoutManager.drawGlyphsForGlyphRange(range, atPoint: CGPoint.zero)
    }
    
    
    private func glyphsRange()->NSRange{
        return NSRange(location: 0, length: textStorage.length)
    }
    
    
    private func glyphsOffset(range:NSRange)->CGPoint{
        let rect = layoutManager.boundingRectForGlyphRange(range, inTextContainer: textContainer)
        let height = (bounds.height - rect.height) * 0.5
        return CGPoint(x: 0, y: height)
    }
    
    
    
    
    
    
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let location = touches.first!.locationInView(self)
        selectedRange = linkRangeAtLocation(location)
        motifySelectedAttribute(true)
    }
    public override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let location = touches.first!.locationInView(self)
        if let range = linkRangeAtLocation(location){
            if !(range.location == selectedRange?.location && range.length == selectedRange?.length) {
                motifySelectedAttribute(false)
                selectedRange = range
                motifySelectedAttribute(true)
            }
        }else{
            motifySelectedAttribute(false)
        }
    }
    public override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if selectedRange != nil {
            let text = (textStorage.string as NSString).substringWithRange(selectedRange!)
            delegate?.labelDidSelectedLinkText?(self, text: text)
            let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * NSEC_PER_SEC))
            dispatch_after(popTime , dispatch_get_main_queue()) {
                self.motifySelectedAttribute(false)
            }
        }
    }
    public override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
       motifySelectedAttribute(false)
    }
    
    private func motifySelectedAttribute(isSet:Bool){
        
        if selectedRange == nil{
            return
        }
        var attributes = textStorage.attributesAtIndex(0, effectiveRange: nil)
        attributes[NSForegroundColorAttributeName] = linkTextColor
        let range = selectedRange!
        if isSet{
            attributes[NSBackgroundColorAttributeName] = selectedBackgroundColor
        }else{
            attributes[NSBackgroundColorAttributeName] = UIColor.clearColor()
            selectedRange = nil
        }
        textStorage.addAttributes(attributes, range: range)

        setNeedsDisplay()
    }

    
    private func linkRangeAtLocation(location:CGPoint)->NSRange?{
        if textStorage.length == 0 {
            return nil
        }
        let offset =  glyphsOffset(glyphsRange())
        let point = CGPoint(x: offset.x + location.x, y: offset.y + location.y)
        let index = layoutManager.glyphIndexForPoint(point, inTextContainer: textContainer)
        
        for r in linkRanges {
            if index >= r.location && index <= r.location + r.length {
                return r
            }
        }
        return nil
    }
    
    //MARK:构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareLabel()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareLabel()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        textContainer.size = bounds.size
    }
    
    
    private func prepareLabel(){
        textStorage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)
        textContainer.lineFragmentPadding = 0
        userInteractionEnabled = true
    }
//    MARK: 懒加载
    private lazy var linkRanges = [NSRange]()
    private var selectedRange:NSRange?
    private lazy var textStorage = NSTextStorage()
    private lazy var layoutManager = NSLayoutManager()
    private lazy var textContainer = NSTextContainer()
}
