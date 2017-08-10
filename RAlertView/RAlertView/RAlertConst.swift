//
//  RAlertConst.swift
//  RAlertView
//
//  Created by ray on 2017/8/10.
//  Copyright © 2017年 ray. All rights reserved.
//

import UIKit

let RALERTVIEW_WIDTH:CGFloat = 260
let RALERTVIEW_HEIGHT:CGFloat = 300
let RALERTVIEW_PADDING:CGFloat = 10

let RLOGOVIEW_SIZE:CGFloat = 60
let RLOGOVIEW_MARGIN_TOP:CGFloat = 20
let RDEFAULTRADIUS:CGFloat = 5.0
let RBUTTON_TAG:CGFloat = 19888

let SUCCESS_COLOR = UIColor.init(red: 126/255, green: 216/255, blue: 33/255, alpha: 1)
let WARNING_COLOR = UIColor.init(red: 245/255, green: 166/255, blue: 35/255, alpha: 1)
let ERROR_COLOR = UIColor.init(red: 208/255, green: 2/255, blue: 27/255, alpha: 1)


//弹窗样式
enum RAlertViewModel: Int {
    case Success,Error,Warning,Info,Custom;
}

//显示样式
enum RAlertModel: Int{
    case Fade,Top,Bottom,Left,Right;
}


extension UIView{
    func cleanLayer(view: UIView) {
        if view.layer.sublayers?.count == 0 {
            return
        }
        for layer in view.layer.sublayers! {
            layer.removeFromSuperlayer()
        }
    }
    func drawSuccessSymbol() {
        self.cleanLayer(view: self)
        let path = UIBezierPath.init(arcCenter: CGPoint.init(x: RLOGOVIEW_SIZE/2, y: RLOGOVIEW_SIZE/2), radius: RLOGOVIEW_SIZE/2, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        
        path.move(to: CGPoint.init(x: RLOGOVIEW_SIZE/4, y: RLOGOVIEW_SIZE/2))
        let p1 = CGPoint.init(x: RLOGOVIEW_SIZE/4+10, y: RLOGOVIEW_SIZE/2)
        path .addLine(to: p1)
        
        let p2 = CGPoint.init(x: RLOGOVIEW_SIZE/4*3, y: RLOGOVIEW_SIZE/4)
        path.addLine(to: p2)
        
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        
        layer.strokeColor = SUCCESS_COLOR.cgColor
        layer.lineWidth = 5
        layer.path = path.cgPath
        self.layer.addSublayer(layer)
    }
    func drawWarningSymbol() {
        self.cleanLayer(view: self)
        let path = UIBezierPath.init(arcCenter: CGPoint.init(x: RLOGOVIEW_SIZE/2, y: RLOGOVIEW_SIZE/2), radius: RLOGOVIEW_SIZE/2, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
       
        path.move(to: CGPoint.init(x: RLOGOVIEW_SIZE/2, y: RLOGOVIEW_SIZE/6))
        let p1 = CGPoint.init(x: RLOGOVIEW_SIZE/2, y: RLOGOVIEW_SIZE/6*38)
        path.addLine(to: p1)
        
        let layer = CAShapeLayer.init()
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = WARNING_COLOR.cgColor
        layer.lineWidth = 5
        layer.path = path.cgPath
        self.layer.addSublayer(layer)
    }
    func drawErrorSymbol() {
        
        self.cleanLayer(view: self)
        let path = UIBezierPath.init(arcCenter: CGPoint.init(x: RLOGOVIEW_SIZE/2, y: RLOGOVIEW_SIZE/2), radius: RLOGOVIEW_SIZE/2, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
        let p1 = CGPoint.init(x: RLOGOVIEW_SIZE/4, y: RLOGOVIEW_SIZE/4)
        path.move(to: p1)
        
        let p2 = CGPoint.init(x: RLOGOVIEW_SIZE/4*3, y: RLOGOVIEW_SIZE/4*3)
        path.addLine(to: p2)
        
        let p3 = CGPoint.init(x: RLOGOVIEW_SIZE/4*3, y: RLOGOVIEW_SIZE/4)
        path.move(to: p3)
        
        let p4 = CGPoint.init(x: RLOGOVIEW_SIZE/4, y: RLOGOVIEW_SIZE/4*3)
        path.addLine(to: p4)
        
        let layer = CAShapeLayer.init()
        layer.lineWidth = 5
        layer.path = path.cgPath
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = ERROR_COLOR.cgColor
        self.layer.addSublayer(layer)
        
    }
    
    func drawCustomeView(customView: UIView) {
        self.cleanLayer(view: self)
        customView.frame = self.frame
        self.addSubview(customView)
    }
}



		
