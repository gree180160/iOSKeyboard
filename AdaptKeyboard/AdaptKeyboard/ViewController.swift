//
//  ViewController.swift
//  AdaptKeyboard
//
//  Created by WillowRivers on 2020/11/18.
//

import UIKit

class ViewController: UIViewController, KeyboardUpDownProtocol {
    var textV: UITextView!   //input item
    let textVMinY: CGFloat = 500  //orignal
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Just keyboard"
        textV = UITextView(frame: CGRect(x: (UIScreen.main.bounds.width - 300)/2, y: textVMinY, width: 300, height: 150))
        textV.layer.borderWidth = 1.0
        textV.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(textV)
        addNoticeForKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(tap:)))
        self.view.addGestureRecognizer(tap)
        
        let btn = UIButton(frame: CGRect(x: 100, y: UI.navigationBarMaxY + 50, width: 170, height: 100))
        btn.setTitle("gotoFormVC", for: .normal)
        btn.backgroundColor = UIColor.brown
        self.view.addSubview(btn)
        btn.addTarget(self, action: #selector(goToFormAction(_:)), for: .touchUpInside)
    }
    
    deinit {
        removeNotice()
    }
    
    @objc func goToFormAction(_ sender: Any) {
        self.navigationController?.pushViewController(PersonInfoVC(), animated: true)
    }
    
    @objc func tapAction(tap :UITapGestureRecognizer) {
        hiddenKeyboard(sender: textV)
    }
    
    func safeMaxHeight() -> CGFloat {
        return textV.frame.origin.y + textV.frame.size.height
    }
    
    func addNoticeForKeyboard() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateSubviewFrame(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(recoverSubViewFrame(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    //deinit 调用
    func removeNotice() {
        NotificationCenter.default.removeObserver(self)
    }
    //键盘出现调用
    @objc func updateSubviewFrame(notification: NSNotification)  {
        // 获取键盘信息
        let keyboardinfo = notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey]

        let keyboardheight:CGFloat = ((keyboardinfo as AnyObject).cgRectValue.size.height)

               print("键盘弹起")

               print(keyboardheight)
        
        let coincide = safeMaxHeight() - (self.view.frame.size.height - UI.keyboardHeight - UI.beautifulSpace)
        if coincide >= 0 { //need adjust
            self.textV.frame = CGRect(x: textV.frame.origin.x, y: textVMinY - coincide, width: textV.frame.width, height: textV.frame.height)
        }else {
            self.textV.frame = CGRect(x: textV.frame.origin.x, y: textVMinY, width: textV.frame.width, height: textV.frame.height)
        }
    }
    //键盘消失调用
    @objc func recoverSubViewFrame(notification: NSNotification)  {
        if self.textV.frame.origin.y != textVMinY {
            self.textV.frame = CGRect(x: textV.frame.origin.x, y: textVMinY, width: textV.frame.width, height: textV.frame.height)
        }
    }
    
    func hiddenKeyboard(sender: UIView) {
        sender.resignFirstResponder()
    }
}



