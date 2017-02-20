//
//  TestView.swift
//  NinaPagerView
//
//  Created by RamWire on 16/4/19.
//  Copyright © 2016年 RamWire. All rights reserved.
//

import UIKit

class TestView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        let button = UIButton(type: UIButtonType.contactAdd)
        button.backgroundColor = UIColor.black
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        button.addTarget(self, action: #selector(TestView.pushAction), for: UIControlEvents.touchUpInside)
        self.addSubview(button)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func pushAction() {
        let pushVC = PushViewController()
        self.viewController().navigationController?.pushViewController(pushVC, animated: true)
    }
    
}
