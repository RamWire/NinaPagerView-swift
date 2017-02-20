//
//  PushViewController.swift
//  NinaPagerView
//
//  Created by RamWire on 16/4/19.
//  Copyright © 2016年 RamWire. All rights reserved.
//

import UIKit

class PushViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var myTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Hello Swift"
        self.view.backgroundColor = UIColor.blue
//        self.myTableView = UITableView(frame: self.view.frame,style: UITableViewStyle.Plain)
//        self.myTableView.delegate = self
//        self.myTableView.dataSource = self
//        self.view.addSubview(self.myTableView)
        //        self.myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellId)
        //        self.myTableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellId)
//        self.view.addSubview(self.imageView)
        self.imageView.backgroundColor = UIColor.yellow;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: cellId)
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.default,reuseIdentifier: cellId)
            cell.textLabel!.text = "NinaPagerView-swift"
            cell.textLabel?.textColor = UIColor.black
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let websViewController = PushViewController()
        self.navigationController?.pushViewController(websViewController, animated: true)
    }
    lazy var imageView:UIImageView = {
        var yourImageView = UIImageView()
        yourImageView.frame = CGRect(x: 100,y: 100,width: 50,height: 50)
        yourImageView.image = UIImage(named:"share_wx")
        yourImageView.layer.cornerRadius = 10
        yourImageView.layer.borderWidth = 2
        return yourImageView
    }()}
