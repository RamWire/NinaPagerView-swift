//
//  ViewController.swift
//  NinaPagerView
//
//  Created by RamWire on 16/4/6.
//  Copyright © 2016年 RamWire. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "Nina"
        self.navigationController?.navigationBar.isTranslucent = false
        let titleArray:NSArray =   [
                                                        "大连市",
                                                        "甘井子",
                                                        "星海广场",
                                                        "西岗",
                                                        "马栏子",
                                                        "革镇堡",
                                                        "中山",
                                                        "人民广场",
                                                        "中山广场"
                                                        ];
        let titleArrays:NSArray =   [           
                                                        "SecondViewController",
                                                        "SecondViewController",
                                                        "ThirdViewController",
                                                        "ForthViewController",
                                                        "FifthViewController",
                                                        "SixthViewController",
                                                        "SeventhViewController",
                                                        "EighthViewController",
                                                        "NinthViewController",
                                                    ];
        let colorArray:NSArray = [
                                                        UIColor.black,
                                                        UIColor.gray,
                                                        UIColor.red,
                                                        UIColor.white
                                                    ];      
        let ninaPagerView:NinaPagerView = NinaPagerView(frame: CGRect.zero,titles:titleArray,vcs:titleArrays,colorArrays:colorArray)
        self.view.addSubview(ninaPagerView)
        ninaPagerView.pushEnabled = true
    }
}

