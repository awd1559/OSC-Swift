//
//  HorizontalController.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/14.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit
//FIXME: this is HorizonalTableViewController

fileprivate let kHorizonalCellID = "HorizonalCell"

class HorizontalController : UITableViewController {
    var currentIndex: Int?
    var controllers: [UIViewController]?
    var changeIndex: ((Int)->Void)?
    var scrollView: ((Float, Int, Int)->Void)?
    var viewDidAppear: ((Int) -> Void)?
    var viewDidScroll: (()->Void)?
    
    init(_ viewControllers:[UIViewController]) {
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollToViewAtIndex(_ index: Int) {
        
    }
    
    
    //MARK: - UITableViewDelegate
    //MARK: - UIScrollViewDelegate
}
