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
        
       let alert = RAlertView.init(title: "123123", detailText: "123123123123123123123123123123123123123123123123123123123123123123123123123123", cancelTitle: "确定",style: .Warning)
        alert.enterModel = .Bottom
        alert.leaveModel = .Bottom
        alert.show()
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

