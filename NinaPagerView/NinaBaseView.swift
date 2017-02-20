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

class NinaBaseView: UIView,UIScrollViewDelegate {
    /*********************************** Property ****************************************/
    //MARK:- Property
    /**<  全局变量   **/
    var lineBottom:UIView = UIView()
    var topTabBottomLine:UIView = UIView()
    var btnArray:NSMutableArray!
    var titlesArray:NSArray! /**<  标题   **/
    var arrayCount:NSInteger! /**<  topTab数量   **/
    var selectBtn:UIColor!
    var unselectBtn:UIColor!
    var underline:UIColor!
    var topTabColors:UIColor!
    dynamic var currentPage:NSInteger = NSInteger()    
    /**<  Lazy Load   **/
    lazy var scrollView:UIScrollView = {
        var scrollViews = UIScrollView()
        scrollViews.delegate = self
        scrollViews.tag = 318
        scrollViews.backgroundColor = UIColor.white
        scrollViews.contentSize = CGSize(width: FUll_VIEW_WIDTH * CGFloat(self.titleArray.count), height: 0)
        scrollViews.isPagingEnabled = true
        scrollViews.showsHorizontalScrollIndicator = false
        scrollViews.alwaysBounceHorizontal = true
        return scrollViews
    }()
    lazy var topTab:UIScrollView = {
        var topTabs = UIScrollView()
        topTabs.delegate = self
        if (self.topTabColors != nil) {
            topTabs.backgroundColor = self.topTabColors
        }else {
            topTabs.backgroundColor = UIColor.white
        }
        topTabs.tag = 917
        topTabs.isScrollEnabled = true
        topTabs.alwaysBounceHorizontal = true
        topTabs.showsHorizontalScrollIndicator = false
        var additionCount:CGFloat = 0
        if self.arrayCount > 5 {
            additionCount = (CGFloat(self.arrayCount) - 5.0) / 5.0
        }
        topTabs.contentSize = CGSize(width: (1 + additionCount) * FUll_VIEW_WIDTH, height: PageBtn - TabbarHeight)
        /**<  如何给可变数组初始化   **/
        self.btnArray = NSMutableArray()
        for i in 0..<self.titleArray.count {
            var button:UIButton = UIButton(type:UIButtonType.custom)
            button.tag = i
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            if ((self.titleArray[i] as AnyObject) is String) {
                button.setTitle(self.titleArray[i] as? String, for: UIControlState())
            }else {
                print("您所提供的标题\(i + 1)格式不正确。 Your title\(i + 1) not fit for topTab,please correct it to NSString!")
            }
            if self.titleArray.count > 5 {
                button.frame = CGRect(x: FUll_VIEW_WIDTH / 5.0 * CGFloat(i), y: 0, width: FUll_VIEW_WIDTH / 5, height: PageBtn)
            }else {
                button.frame = CGRect(x: FUll_VIEW_WIDTH / CGFloat(self.arrayCount) * CGFloat(i), y: 0, width: FUll_VIEW_WIDTH / CGFloat(self.arrayCount), height: PageBtn)
            }
            topTabs.addSubview(button)
            button.addTarget(self, action: #selector(NinaBaseView.touchAction(_:)), for: UIControlEvents.touchUpInside)
            self.btnArray.add(button)
            if i == 0 {
                if (self.selectBtn != nil) {
                    button.setTitleColor(self.selectBtn, for: UIControlState())
                }else {
                    button.setTitleColor(UIColor.black, for: UIControlState())
                }
                UIView.animate(withDuration: 0.3, animations: {
                    button.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
                })
            }else {
                if (self.unselectBtn != nil) {
                    button.setTitleColor(self.unselectBtn, for: UIControlState())
                }else {
                    button.setTitleColor(UIColor.gray, for: UIControlState())
                }
            }
        }
        return topTabs
    }()
    /**<  set method   **/
    var titleArray:NSArray = NSArray() {
        willSet(newValue) {
            self.titleArray = newValue;
            arrayCount = titleArray.count;
            self.topTab.frame = CGRect(x: 0,y: 0,width: FUll_VIEW_WIDTH, height: PageBtn)
            self.scrollView.frame = CGRect(x: 0, y: PageBtn, width: FUll_VIEW_WIDTH, height: (FUll_VIEW_HEIGHT - PageBtn - 64))
            self.addSubview(self.topTab)
            self.addSubview(self.scrollView)
        }
    }
    /*********************************** Begin ****************************************/
    //MARK:- Begin
    /**<  init   **/
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(frame: CGRect,selectColor:UIColor,unSelectColor:UIColor,underLineColor:UIColor,topTabColor:UIColor) {
        self.init(frame:frame)
        if selectColor.isKind(of: UIColor.self) {
            selectBtn = selectColor
        }else {
            print("please change the selectColor into UIColor!")
        }
        if unSelectColor.isKind(of: UIColor.self) {
            unselectBtn = unSelectColor
        }else {
            print("please change the unselectColor into UIColor!")
        }
        if underLineColor.isKind(of: UIColor.self) {
            underline = underLineColor
        }else {
            print("please change the underlineColor into UIColor!")
        }
        if topTabColor.isKind(of: UIColor.self) {
            topTabColors = topTabColor
        }else {
            print("please change the topTabColor into UIColor!")
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /********************************** Public Methods  ***************************************/
    //MARK:- Public Methods
   /**<  BtnMethod   **/
    func touchAction(_ sender:UIButton) {
        self.scrollView.setContentOffset(CGPoint(x: FUll_VIEW_WIDTH * CGFloat(sender.tag), y: 0), animated: true)
        self.currentPage = Int((FUll_VIEW_WIDTH * CGFloat(sender.tag) + FUll_VIEW_WIDTH / 2) / FUll_VIEW_WIDTH)
    }
    /**<  UIScrollViewDelegate   **/
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.tag == 318 {
            self.currentPage = (NSInteger)((scrollView.contentOffset.x + FUll_VIEW_WIDTH / 2) / FUll_VIEW_WIDTH);
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.tag == 318 {
            let yourPage:NSInteger = Int((scrollView.contentOffset.x + FUll_VIEW_WIDTH / 2) / FUll_VIEW_WIDTH)
            var yourCount:CGFloat = 1.0 / CGFloat(self.arrayCount)
            if self.arrayCount > 5 {
                yourCount = 1.0 / 5.0
                self.lineBottom.frame = CGRect(x: scrollView.contentOffset.x / 5, y: PageBtn - 2, width: yourCount * FUll_VIEW_WIDTH, height: 2)
            }else {
                self.lineBottom.frame = CGRect(x: scrollView.contentOffset.x / CGFloat(self.arrayCount), y: PageBtn - 2, width: yourCount * FUll_VIEW_WIDTH, height: 1)
            }
            for i in 0..<self.btnArray.count {
                if (self.unselectBtn != nil) {
                    (self.btnArray[i] as AnyObject).setTitleColor(self.unselectBtn, for: UIControlState())
                }else {
                    (self.btnArray[i] as AnyObject).setTitleColor(UIColor.gray, for: UIControlState())
                }
                let changeButton:UIButton = btnArray[i] as! UIButton
                UIView.animate(withDuration: 0.3, animations: { 
                    changeButton.transform = CGAffineTransform(scaleX: 1, y: 1)
                })
            }
            if (selectBtn != nil) {
                (self.btnArray[yourPage] as AnyObject).setTitleColor(self.selectBtn, for: UIControlState())
            }else {
                (self.btnArray[yourPage] as AnyObject).setTitleColor(UIColor.black, for: UIControlState())
            }
            let changeButton:UIButton = btnArray[yourPage]as! UIButton
            UIView.animate(withDuration: 0.3, animations: { 
                changeButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
            })
        }
    }
    /**<  LayOutSubViews   **/
    override func layoutSubviews() {
        super.layoutSubviews()
        self.initUI()
    }
    func initUI() {
        /**<  创建topTab下方总览线   **/
        topTabBottomLine.backgroundColor = UIColorFromRGB(0xcecece)
        self.topTab.addSubview(topTabBottomLine)
        /**<  创建选中移动线   **/
        if  (self.underline != nil) {
            lineBottom.backgroundColor = self.underline
        }else {
            lineBottom.backgroundColor = UIColor.red
        }
        self.topTab.addSubview(lineBottom)
        
        var yourCount:CGFloat = 1.0 / CGFloat(self.arrayCount)
        var additionCount:CGFloat = 0
        if self.arrayCount > 5 {
            additionCount = (CGFloat(arrayCount) - 5.0) / 5.0
            yourCount = 1.0 / 5.0
        }
        self.lineBottom.frame = CGRect(x: 0, y: PageBtn - 2,width: yourCount * FUll_VIEW_WIDTH, height: 2)
        self.topTabBottomLine.frame = CGRect(x: 0, y: PageBtn - 1, width: (1 + additionCount) * FUll_VIEW_WIDTH, height: 1)
    }
}
