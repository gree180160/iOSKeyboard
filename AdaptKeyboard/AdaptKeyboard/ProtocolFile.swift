//
//  ProtocolFile.swift
//  AdaptKeyboard
//
//  Created by WillowRivers on 2020/11/18.
//
import UIKit

protocol KeyboardUpDownProtocol {
    //
    //1. 把所有键盘相关的操作函数加到协议里
    /// 设置完subView 调用
    /// 不用担心被键盘挡住的最大高度
   func safeMaxHeight() -> CGFloat
    /// 添加对键盘的活动的监控
   func addNoticeForKeyboard()
    //deinit 调用
   func removeNotice()
    //键盘出现调用
   func updateSubviewFrame(notification: NSNotification)
    //键盘消失调用
   func recoverSubViewFrame(notification: NSNotification)
    
    /// 让键盘消失
    /// - Parameter sender: active input item
    func hiddenKeyboard(sender: UIView)
}

protocol FormTableVCProtocol {
    
    /// 用户开始输入信息
    func inputString()
    
    /// 用户开始选择信息
    func selectItem()
    
    /// 赋值操作
    /// - Parameters:
    ///   - newValue: newValue description
    ///   - forIndexpath: forIndexpath description
    func configureModel(newValue: String?, forIndexpath: IndexPath)
}
 
