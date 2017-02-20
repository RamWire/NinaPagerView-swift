//
//  FirstViewController.swift
//  NinaPagerView
//
//  Created by RamWire on 16/4/15.
//  Copyright © 2016年 RamWire. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
        let testView = TestView(frame:CGRect(x: 0,y: 0,width: 375,height: 500))
        self.view.addSubview(testView)
    }
    
}
