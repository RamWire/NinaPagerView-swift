// The MIT License (MIT)
//
// Copyright (c) 2015-2016 RamWire ( https://github.com/RamWire )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

class NinaPagerView: UIView {
    /*********************************** Property ****************************************/
    //MARK:- Property
    /**< 设置控制器最大个数   **/
    let MaxNums = 10
    var currentPage = NSInteger()
    var topTab = UIScrollView()
    var lineBottom = UIView()
    /**<  全局变量   **/
    var pagerView:NinaBaseView!
    var myArray:NSArray!
    var classArray:NSArray!
    var colorArray:NSArray!
    var viewNumArray:NSMutableArray!
    var vcsTagArray:NSMutableArray!
    var vcsArray:NSMutableArray!
    var viewAlloc:Bool!
    var fontChangeColor:Bool!
    var firstVC = UIViewController()
    var viewAllocs: [Bool] =  [false,false,false,false,false,false,false,false,false,false]
    //Scrollview
    var scrollView = UIScrollView()
    var selectColor:UIColor!
    var unSelectColor = UIColor()
    var underLineColor = UIColor()
    var topTabColor = UIColor()
    
    var pushEnabled:Bool = Bool() {
        willSet(newValue) {
            if newValue == true {
                self.viewController().addChildViewController(firstVC)
            }
        }
    }    
    /*********************************** Begin ****************************************/
    //MARK:- Begin
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(frame: CGRect,titles:NSArray,vcs:NSArray,colorArrays:NSArray) {
        self.init(frame:frame)
        self.frame = CGRect(x: 0, y: 0, width: FUll_VIEW_WIDTH, height: FUll_CONTENT_HEIGHT)
        self.myArray = titles;
        self.classArray = vcs
        self.colorArray = colorArrays
        self .createPagerView(titles, vcs: vcs, colors: colorArrays)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /********************************** Public Methods  ***************************************/
    //MARK:- Public Methods
    func createPagerView(_ titles:NSArray,vcs:NSArray,colors:NSArray) {
        if colors.count > 0 {
            for i in 0..<colors.count {
                switch i {
                case 0:
                    self.selectColor = colors[0] as! UIColor
                    break
                case 1:
                    self.unSelectColor = colors[1] as! UIColor
                    break
                case 2:
                    self.underLineColor = colors[2] as! UIColor
                    break
                case 3:
                    self.topTabColor = colors[3] as! UIColor
                    break
                default:
                    break
                }
            }
        }
        if titles.count > 0 && vcs.count > 0 {
            self.pagerView = NinaBaseView(frame: CGRect(x: 0, y: 0, width: FUll_VIEW_WIDTH, height: FUll_CONTENT_HEIGHT),selectColor:self.selectColor,unSelectColor:self.unSelectColor,underLineColor:self.underLineColor,topTabColor:self.topTabColor)
            pagerView.titleArray = self.myArray
            pagerView.addObserver(self, forKeyPath: "currentPage", options: NSKeyValueObservingOptions.new, context: nil)
            self.addSubview(pagerView)
            if self.classArray.count > 0 && self.myArray.count > 0 {
                let className = Bundle.main.infoDictionary!["CFBundleName"] as! String + "." + (self.classArray[0] as! String)
                let myClass:AnyObject.Type  = NSClassFromString(className)!
                let ctrl = (myClass as! UIViewController.Type).init()
                firstVC = ctrl
                ctrl.view.frame = CGRect(x: FUll_VIEW_WIDTH * 0, y: 0, width: FUll_VIEW_WIDTH, height: FUll_VIEW_HEIGHT - PageBtn - 64)
                pagerView.scrollView.addSubview(ctrl.view)
                viewAllocs[0] = true
            }else {
                print("You should correct titlesArray or childVCs count!")
            }
        }
    }
    
    /********************************** KVO  ***************************************/
    //MARK:- KVO
    /**<  KVO   **/
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentPage" {
            let page:NSInteger = (change?[.newKey] as? Int)!
            if isDebug {
                print("现在是控制器\(page + 1)")
            }
            if self.myArray.count > 5 {
                var topTabOffsetX:CGFloat = 0
                if page >= 2 {
                    if page <= self.myArray.count - 3 {
                        topTabOffsetX = CGFloat(page - 2) * More5LineWidth;
                    }
                    else {
                        if page == myArray.count - 2 {
                            topTabOffsetX = CGFloat(page - 3) * More5LineWidth;
                        }else {
                            topTabOffsetX = CGFloat(page - 4) * More5LineWidth;
                        }
                    }
                }
                else {
                    if page == 1 {
                        topTabOffsetX = 0 * More5LineWidth;
                    }else {
                        topTabOffsetX = CGFloat(page) * More5LineWidth;
                    }
                }
                self.pagerView.topTab .setContentOffset(CGPoint(x: topTabOffsetX, y: 0), animated: true);
            }
            for i in 0..<self.myArray.count {
                if page == i && i <= classArray.count - 1 {
                    let className = Bundle.main.infoDictionary!["CFBundleName"] as! String + "." + (self.classArray[i] as! String)
                    let myClass:AnyObject.Type  = NSClassFromString(className)!
                    if viewAllocs[i] == false {
                        let ctrl = (myClass as! UIViewController.Type).init()
                        self.viewController().addChildViewController(ctrl)
                        ctrl.view.frame = CGRect(x: FUll_VIEW_WIDTH * CGFloat(i), y: 0, width: FUll_VIEW_WIDTH, height: FUll_VIEW_HEIGHT - PageBtn - 64)
                        pagerView.scrollView.addSubview(ctrl.view)
                        viewAllocs[i] = true
                    }
                }else if (page == i && i > classArray.count - 1) {
                    print("您没有配置对应Title\(i + 1)的VC")
                }
            }
        }
    }
    /********************************** Dealloc  ***************************************/
    //MARK:- Dealloc
    deinit {
        pagerView .removeObserver(self, forKeyPath: "currentPage")
    }
}


/********************************** UIView+ViewController.swift  ***************************************/
extension UIView {
    func viewController() -> UIViewController! {
        var responder = self.next
        while(responder != nil) {
            if (responder!.isKind(of: UIViewController.self)) {
                return responder as!UIViewController
            }
            responder = responder!.next
        }
        return nil
    }
}

/*********************************** UIParameter ****************************************/
/**<  是否在调试状态   **/
public let isDebug:Bool = false
/* 屏幕的宽 */
public let FUll_VIEW_WIDTH:CGFloat  = UIScreen.main.bounds.size.width
/* 屏幕的高 */
public let FUll_VIEW_HEIGHT:CGFloat  = UIScreen.main.bounds.size.height
public let FUll_CONTENT_HEIGHT = FUll_VIEW_HEIGHT - 64 - 49
public let PageBtn:CGFloat = 45 //暂时定下高度45
//tabbar的高度
public let TabbarHeight:CGFloat = 49
//TopTab相关参数
public let More5LineWidth = FUll_VIEW_WIDTH / 5.0 //超过5个标题的宽度
//UIColorFromRGB Method
public func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}


