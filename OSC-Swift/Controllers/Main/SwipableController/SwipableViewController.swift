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
    
    
    convenience init(title: String, subTitles:[String], controllers:[UIViewController]) {
        self.init(title: title, subTitles: subTitles, controllers: controllers, underTabbar: false)
    }
    
    init(title: String, subTitles:[String], controllers:[UIViewController], underTabbar:Bool) {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollToViewAtIndex(_ index: Int) {
    
    }
}
