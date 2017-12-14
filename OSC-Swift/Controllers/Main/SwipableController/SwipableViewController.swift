//
//  SwipableViewController.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/14.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit

class SwipableViewController: UIViewController {
    var viewPager: HorizontalController?
    var titleBar: TitleBarView?
    var controllers: [UIViewController]?
    
    
    init(title: String, subTitles:[String], controllers:[UIViewController], underTabbar:Bool = false) {
        super.init(nibName: nil, bundle: nil)
        
        self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        self.title = title
        
        let titleBarHeight: CGFloat = 36
        var frame = self.view.frame
        frame.size.height = 36
        titleBar = TitleBarView(frame: frame, titles: subTitles)
        titleBar?.backgroundColor = UIColor.titleBarColor()
        self.view.addSubview(titleBar!)
        viewPager = HorizontalController(controllers)
        
        let height = self.view.bounds.size.height - titleBarHeight - 64 - (underTabbar ? 49 : 0)
        viewPager?.view.frame = CGRect(x: 0, y: titleBarHeight, width: self.view.bounds.size.width, height: height)
        self.addChildViewController(viewPager!)
        self.view.addSubview((viewPager?.view)!)
        
        viewPager?.changeIndex = { [weak self] index in
            self?.titleBar?.currentIndex = index
            for button in (self?.titleBar?.titleButtons)! {
                if button.tag != index {
                    button.setTitleColor(UIColor(hex: 0x909090), for: .normal)
                } else {
                    button.setTitleColor(UIColor.newSectionButtonSelectedColor(), for: .normal)
                }
            }
            self?.viewPager?.scrollToViewAtIndex(index)
        }
        
        titleBar?.titleButtonClicked = {[weak self] index in
            self?.viewPager?.scrollToViewAtIndex(index)
        };
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollToViewAtIndex(_ index: Int) {
    
    }
}
