//
//  ViewController.swift
//  RAlertView
//
//  Created by ray on 2017/8/10.
//  Copyright © 2017年 ray. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }

    @IBAction func successAction(_ sender: Any) {
        
       let alert = RAlertView.init(title: "警告", detailText: "请看这是个警告", cancelTitle: "确定",style: .Warning)
        alert.enterModel = .Bottom
        alert.leaveModel = .Bottom
        alert.show()
        
        
    }
    @IBAction func errorAction(_ sender: Any) {
        
        let alert = RAlertView.init(title: "错误", detailText: "错误详情", cancelTitle: "取消", style: .Error, delegate: self, otherTitles: ["确认"])
        alert.enterModel = .Left
        alert.leaveModel = .Right
        alert.show()
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController: RAlertViewDelegate{
    func alertView(alertView: RAlertView, didClickIndex: Int) {
        print(didClickIndex)
    }
}
