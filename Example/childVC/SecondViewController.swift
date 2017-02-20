//
//  SecondViewController.swift
//  NinaPagerView
//
//  Created by RamWire on 16/4/15.
//  Copyright © 2016年 RamWire. All rights reserved.
//

import UIKit

let cellId = "Cell"
class SecondViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    /********************************** Property *****************************************/
    //MARK:- Property
    var myTableView = UITableView()
    lazy var imageView:UIImageView = {
        var yourImageView = UIImageView()
        yourImageView.frame = CGRect(x: 100,y: 100,width: 50,height: 50)
        yourImageView.image = UIImage(named:"share_wx")
        yourImageView.layer.cornerRadius = 10
        yourImageView.layer.borderWidth = 2
        yourImageView.layer.borderColor = UIColor.red.cgColor
        return yourImageView
    }()
    /********************************** System Methods *****************************************/
    //MARK:- System Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Hello Swift"
        self.view.backgroundColor = UIColor.blue
        self.myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: FUll_VIEW_WIDTH, height: FUll_VIEW_HEIGHT - PageBtn - 64),style: UITableViewStyle.plain)
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        self.view.addSubview(self.myTableView)
//        self.view.addSubview(self.imageView)
        self.imageView.backgroundColor = UIColor.yellow;
    }
    /********************************** UITableViewDelegate && UITableViewDataSource *****************************************/
    //MARK:- UITableViewDelegate && UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
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
        tableView .deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(websViewController, animated: true)
    }
}
