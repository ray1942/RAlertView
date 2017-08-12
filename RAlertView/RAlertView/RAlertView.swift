//
//  RAlertView.swift
//  RAlertView
//
//  Created by ray on 2017/8/10.
//  Copyright © 2017年 ray. All rights reserved.
//

import UIKit

protocol RAlertViewDelegate:NSObjectProtocol {
    func alertView(alertView: RAlertView, didClickIndex: Int)
}


class RAlertView: UIView {

    
    var delegate: RAlertViewDelegate?
    
    var completClosure:(()->())?
//    警告样式
    var style: RAlertStyle?
//    划入模式
    var enterModel: RAlertModel?
//    滑出模式
    var leaveModel: RAlertModel?
//    标题文字
    var titleText: String?
//    详情文字
    var detailText: String?
//    自定义视图
    var customView:UIView?
//    x偏移量
    var offSetX: CGFloat?
//    y偏移量
    var offSetY: CGFloat?
//    视图圆角
    var radius: CGFloat?
//    取消标题
    var cancelTitle: String?
//    其他标题数组
    var otherTitles: Array<String>?
//    是否已出父视图
    var removeFromSuperViewOnHide: Bool?
    
//    标题
    var tLabel: UILabel?
    var titleLable: UILabel?{
        set{
           tLabel = newValue
        }
        get{
            if tLabel == nil {
                tLabel = UILabel.init()
            }
            return tLabel
        }
    }
//    副标题
    var dLabel: UILabel?
    var detailLabel: UILabel?{
        set{
           dLabel = newValue
        }
        get{
            if dLabel == nil {
            dLabel = UILabel.init()
            }
            return dLabel
        }
    }
//    取消按钮
    var cancelBtn: UIButton?
//    其他按钮
    var otherBtn: Array<UIButton>?
//    logo
    var logo: UIView?
    var logoView: UIView?{
        set{
           logo = newValue
        }
        get{
            if logo == nil {
                logo = UIView.init(frame: CGRect.init(x: 0, y: 0, width: RLOGOVIEW_SIZE, height: RLOGOVIEW_SIZE))
            }
            return logo
        }
    }
//    标志视图
    var symbol: UIView?
    var symbolView: UIView?{
        set{
            symbol = newValue
        }
        get{
            if symbol == nil  {
                symbol = UIView.init(frame: self.bounds)
                symbol?.backgroundColor = UIColor.black
                symbol?.alpha = 0.2
            }
            return symbol
        }
    }
//    主界面
    var mainAlert: UIView?
    var mainAlertView: UIView?{
        set{
            mainAlert = newValue
        }
        get{
            if mainAlert == nil {
            mainAlert = UIView.init(frame: CGRect.init(x: 0, y: 0, width: RALERTVIEW_WIDTH, height: RALERTVIEW_HEIGHT))
            mainAlert?.center = self.center
            }
            return mainAlert
        }
    }
    
//    MARK:重写initWithFrame
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.offSetX = 0.0
        self.offSetY = 0.0
        self.radius = RDEFAULTRADIUS
        self.style = RAlertStyle.Default
        self.alpha = 0.0
        self.removeFromSuperViewOnHide = true
        self.registerKVC()
    }
//      MARK: 添加便利构造器
    convenience init(title:String, detailText: String, cancelTitle: String){
        self.init(title: title, detailText: detailText, cancelTitle: cancelTitle,style: .Default,delegate: nil, otherTitles: nil, completClosure: nil)
    }
    convenience init(title:String, detailText: String, cancelTitle: String,style: RAlertStyle){
        self.init(title: title, detailText: detailText, cancelTitle: cancelTitle,style: style,delegate: nil, otherTitles: nil, completClosure: nil)
    }
    convenience init(title:String, detailText: String, cancelTitle: String,style: RAlertStyle, completClosure:(()->())?){
        self.init(title: title, detailText: detailText, cancelTitle: cancelTitle,style: style,delegate: nil, otherTitles: nil, completClosure: completClosure)
    }
    convenience init(title:String, detailText: String, cancelTitle: String,style: RAlertStyle,delegate: RAlertViewDelegate?, otherTitles: Array<String>?){
        self.init(title: title, detailText: detailText, cancelTitle: cancelTitle,style: style, delegate: delegate, otherTitles: otherTitles, completClosure: nil)
    }
    convenience init(title:String, detailText: String, cancelTitle: String,style: RAlertStyle,delegate: RAlertViewDelegate?, otherTitles: Array<String>?,completClosure:(()->())?) {
        self.init(frame: UIScreen.main.bounds)
        self.style = style
        self.delegate = delegate
        self.titleText = title
        self.detailText = detailText
        self.cancelTitle = cancelTitle
        self.otherTitles = otherTitles
        self.completClosure = completClosure
        self.layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: 添加子视图
    func addView() {
        self.addSubview(self.symbolView!)
        self.addSubview(self.mainAlertView!)
        self.mainAlertView?.addSubview(self.logoView!)
        self.mainAlertView?.addSubview(self.titleLable!)
        self.mainAlertView?.addSubview(self.detailLabel!)
    }
//    MARK: 判断显示样式
    func updateModeStyle() {
        if self.style == RAlertStyle.Default || self.style == RAlertStyle.Success {
            self.logoView?.drawSuccessSymbol()
            self.cancelBtn?.setTitleColor(SUCCESS_COLOR, for: UIControlState.normal)
            self.cancelBtn?.layer.borderColor = SUCCESS_COLOR.cgColor
            if self.otherBtn != nil || self.otherBtn?.count == 0 {
                for btn in self.otherBtn! {
                    btn.backgroundColor = SUCCESS_COLOR
                }
            }
        }
        if self.style == RAlertStyle.Warning {
            self.logoView?.drawWarningSymbol()
            self.cancelBtn?.setTitleColor(WARNING_COLOR, for: UIControlState.normal)
            self.cancelBtn?.layer.borderColor = WARNING_COLOR.cgColor
            if self.otherBtn != nil || self.otherBtn?.count == 0 {
                for btn in self.otherBtn! {
                    btn.backgroundColor = WARNING_COLOR
                }
            }
        }
        if self.style == RAlertStyle.Error{
            self.logoView?.drawErrorSymbol()
            self.cancelBtn?.setTitleColor(ERROR_COLOR, for: UIControlState.normal)
            self.cancelBtn?.layer.borderColor = ERROR_COLOR.cgColor
            if self.otherBtn != nil || self.otherBtn?.count == 0 {
                for btn in self.otherBtn! {
                    btn.backgroundColor = SUCCESS_COLOR
                }
            }
        }
        if self.style == RAlertStyle.Custom{
            if let tmp = self.customView  {
                self.logoView?.drawCustomeView(customView: tmp)
            }
            self.cancelBtn?.setTitleColor(SUCCESS_COLOR, for: UIControlState.normal)
            self.cancelBtn?.layer.borderColor = SUCCESS_COLOR.cgColor
            if self.otherBtn != nil || self.otherBtn?.count != 0 {
                for btn in self.otherBtn! {
                    btn.backgroundColor = ERROR_COLOR
                }
            }
        }
    }
    
    //    MARK：设置标题文字
    func setupLabel() {
        self.titleLable?.text = self.titleText
        self.titleLable?.sizeToFit()
        self.detailLabel?.text = self.detailText
        self.detailLabel?.textColor = UIColor.gray
        self.detailLabel?.font = UIFont.systemFont(ofSize: 14)
        self.detailLabel?.numberOfLines = 0
    }
    //    MARK：设置按钮
    func setupButton() {
        if self.cancelTitle == nil && self.otherBtn == nil {
            assert(false, "error")
        }
        if self.cancelTitle != nil {
            self.cancelBtn = UIButton.init()
            self.cancelBtn?.setTitle(self.cancelTitle, for: UIControlState.normal)
            self.cancelBtn?.addTarget(self, action: #selector(handleBtn(btn:)), for: UIControlEvents.touchUpInside)
            self.cancelBtn?.layer.cornerRadius = 4.0
            self.cancelBtn?.layer.borderWidth = 1.0
            self.mainAlertView?.addSubview(self.cancelBtn!)
        }
        
        if self.otherTitles != nil {
            var tmpArray = Array<UIButton>()
            for title in self.otherTitles! {
                let button = UIButton.init()
                button.setTitle(title, for: UIControlState.normal)
                button.tag = RBUTTON_TAG + (self.otherTitles?.index(of: title))!
                button.addTarget(self, action: #selector(handleBtn(btn:)), for: UIControlEvents.touchUpInside)
                button.layer.cornerRadius = 4.0
                tmpArray.append(button)
                self.mainAlertView?.addSubview(button)
            }
            self.otherBtn = tmpArray
        }
    }
    
//    MARK: 初始化alertView
    func layout() {
        self.addView()
        self.setupLabel()
        self.setupButton()
        self.updateModeStyle()
        let currentWindow = (UIApplication.shared.delegate?.window)!
        currentWindow?.addSubview(self)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.mainAlertView?.backgroundColor = UIColor.white
        self.mainAlertView?.layer.cornerRadius = self.radius!
        
        let logoCenter = CGPoint.init(x: (self.mainAlertView?.frame.width)!/2, y: RLOGOVIEW_MARGIN_TOP+RLOGOVIEW_SIZE/2)
        self.logoView?.center = logoCenter
        
        let titleCenter = CGPoint.init(x: (self.mainAlertView?.frame.width)!/2, y: 20+(self.titleLable?.frame.height)!/2+(self.logoView?.frame.maxY)!)
        self.titleLable?.center = titleCenter
        
        self.detailLabel?.frame = CGRect.init(x: 0, y: 0, width: (self.mainAlertView?.frame.width)!-RALERTVIEW_PADDING*2, height: 0)
        self.detailLabel?.sizeToFit()
        
        let detailCenter = CGPoint.init(x: (self.mainAlertView?.frame.width)!/2, y: 10+(self.detailLabel?.frame.height)!/2+(self.titleLable?.frame.maxY)!)
        self.detailLabel?.center = detailCenter
        
        if self.cancelTitle != nil && self.otherTitles == nil {
            let btnFrame = CGRect.init(x: 0, y: 0, width: RALERTVIEW_WIDTH-RALERTVIEW_PADDING*2, height: 40)
            self.cancelBtn?.frame = btnFrame
            
            let btnCenter = CGPoint.init(x: (self.mainAlertView?.frame.width)!/2, y: RALERTVIEW_HEIGHT-RALERTVIEW_PADDING-20)
            self.cancelBtn?.center = btnCenter
        }
        if self.cancelTitle != nil && self.otherTitles?.count == 1{
            let btnFrame = CGRect.init(x: 0, y: 0, width: (RALERTVIEW_WIDTH-RALERTVIEW_PADDING*3)/2, height: 40)
            self.cancelBtn?.frame = btnFrame
            
            let leftBtnCenter = CGPoint.init(x: (self.cancelBtn?.frame.width)!/2+RALERTVIEW_PADDING, y: RALERTVIEW_HEIGHT-RALERTVIEW_PADDING-20)
            self.cancelBtn?.center = leftBtnCenter
            
            let rightBtn = self.otherBtn?.first
            rightBtn?.frame = btnFrame
            
            let rightBtnCenter = CGPoint.init(x: RALERTVIEW_WIDTH-(rightBtn?.frame.width)!/2-RALERTVIEW_PADDING, y: RALERTVIEW_HEIGHT-RALERTVIEW_PADDING-20)
            rightBtn?.center = rightBtnCenter
        }
        if self.cancelTitle != nil && self.otherTitles != nil && (self.otherTitles?.count)! > 1 {
            let btnFrame = CGRect.init(x: 0, y: 0, width: RALERTVIEW_WIDTH-RALERTVIEW_PADDING*2, height: 40)
            for btn in self.otherBtn!.reversed() {
                btn.frame = btnFrame
                let pointCenter = CGPoint.init(x: (self.mainAlertView?.frame.width)!/2, y: (self.mainAlertView?.frame.height)! - RALERTVIEW_PADDING - 10.0*(CGFloat((self.otherBtn?.count)! - (self.otherBtn?.index(of: btn))! - 1)-40*CGFloat(self.otherBtn!.count-(self.otherBtn?.index(of: btn))!)+20))
                btn.center = pointCenter
            }
            self.cancelBtn?.frame = btnFrame
            let leftBtnCenter = CGPoint.init(x: (self.mainAlertView?.frame.width)!/2, y: (self.mainAlertView?.frame.height)!-RALERTVIEW_PADDING-CGFloat(10*((self.otherBtn?.count)!))-40*CGFloat((self.otherBtn?.count)!)-20.0)
            self.cancelBtn?.center = leftBtnCenter
            
            if CGFloat(50*(self.otherBtn?.count)!+1)+(self.detailLabel?.frame.maxY)! > (self.mainAlertView?.frame.height)!{
                var frame = self.mainAlertView?.frame
               frame?.size.height = CGFloat(50*(self.otherBtn?.count)!+1)+(self.detailLabel?.frame.maxY)!
                self.mainAlertView?.frame = frame!
                self.setNeedsLayout()
            }
        }
        if self.cancelTitle == nil && self.otherTitles?.count == 1 {
            let rightBtn = self.otherBtn?.first
            let btnFrame = CGRect.init(x: 0, y: 0, width: RALERTVIEW_WIDTH-RALERTVIEW_PADDING*2, height: 40)
            rightBtn?.frame = btnFrame
            let btnCenter = CGPoint.init(x: (self.mainAlertView?.frame.width)!/2, y: RALERTVIEW_WIDTH-RALERTVIEW_PADDING-20)
            rightBtn?.center = btnCenter
        }
        
        
    }


//    按钮响应方法
    func handleBtn(btn: UIButton) {
        
        if btn.isEqual(self.cancelBtn) {
            
            if let tmpClosure = self.completClosure {
                tmpClosure()
            }
        }else{
            if let tmp = self.delegate {
                tmp.alertView(alertView: self, didClickIndex: (self.otherBtn?.index(of: btn))!)
            }
        }
        self.hideAlert()
    }
    
//    MARK：显示
    func show()  {
        var frame = self.mainAlertView?.frame
        if self.enterModel != nil {
            if let enterM = self.enterModel {
                switch enterM {
                case .Top:
                    frame?.origin.y = (frame?.origin.y)! - UIScreen.main.bounds.height
                case .Bottom:
                    frame?.origin.y = (frame?.origin.y)! + UIScreen.main.bounds.height
                case .Left:
                    frame?.origin.x = (frame?.origin.x)! - UIScreen.main.bounds.width
                case .Right:
                    frame?.origin.x = (frame?.origin.x)! + UIScreen.main.bounds.width
                case .Fade:
                    print("")
                }
            }
        }
        self.mainAlertView?.frame = frame!
        UIView.animate(withDuration: RALERT_DURATION, animations: {
            self.alpha = 1
            self.mainAlertView?.center = CGPoint.init(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
        })
    }
//    MARK: 隐藏
    func hideAlert() {
        var frame = self.mainAlertView?.frame
        if let leaveM = self.leaveModel {
            switch leaveM {
            case .Top:
                frame?.origin.y = (frame?.origin.y)! - UIScreen.main.bounds.height
            case .Bottom:
                frame?.origin.y = (frame?.origin.y)! + UIScreen.main.bounds.height
            case .Left:
                frame?.origin.x = (frame?.origin.x)! - UIScreen.main.bounds.width
            case .Right:
                frame?.origin.x = (frame?.origin.x)! + UIScreen.main.bounds.width
            case .Fade:
                print("")
            }
        }
        UIView.animate(withDuration: RALERT_DURATION, animations: { 
            self.alpha = 0
            self.mainAlertView?.frame = frame!
        }) { (finished) in
            if self.removeFromSuperViewOnHide != nil {
                self.alertDestroy()
                if self.removeFromSuperViewOnHide! {
                    self.removeFromSuperview()
                }
                self.unregisterKVC()
                
                
            }
        }
    }
    
    func alertDestroy() {
        tLabel?.removeFromSuperview()
        tLabel = nil
        dLabel?.removeFromSuperview()
        dLabel = nil
        cancelBtn?.removeFromSuperview()
        cancelBtn = nil
        if self.otherBtn != nil {
            for btn in self.otherBtn! {
                btn.removeFromSuperview()
            }
            self.otherBtn = nil
        }
    }
    
//    MARK: KVC
    func registerKVC() {
        for keyPath in self.observableKeyPaths() {
            self.addObserver(self, forKeyPath: keyPath, options: NSKeyValueObservingOptions.new, context: nil)
        }
    }
    func unregisterKVC() {
        for keyPath in self.observableKeyPaths() {
            self.removeObserver(self, forKeyPath: keyPath)
        }
    }
//    keypath 数组
    func observableKeyPaths() -> Array<String> {
        return Array.init(arrayLiteral: "model","customView")
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if Thread.isMainThread {
            self.performSelector(onMainThread: #selector(updateUIForKeyPath(keyPath:)), with: keyPath, waitUntilDone: false)
        }else{
            self.updateUIForKeyPath(keyPath: keyPath!)
        }
    }
    func updateUIForKeyPath(keyPath: String) {
        if keyPath == "mode" || keyPath == "customView" {
            self.updateModeStyle()
        }
    }
    
}
