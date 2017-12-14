//
//  TitleBarView.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/14.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit

fileprivate let kMaxBtnWidth = 80
fileprivate let kScreenSize = UIScreen.main.bounds.size

class TitleBarView: UIScrollView {
    var titleButtons: [UIButton]?
    var currentIndex: Int?
    var titleButtonClicked: ((Int) -> Void)?
    var isNeedScroll = false
    
    init(frame: CGRect, titles: [String], needScroll: Bool = false) {
        super.init(frame: frame)
        self.isNeedScroll = needScroll
        self.reloadAllButtonsOfTitleBarWithTitles(titles)
        self.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitleButtonsColor() {
        for button in self.subviews {
            button.backgroundColor = UIColor.titleBarColor()
        }
    }
    
    func scrollToCenterWithIndex(_ index: Int) {
        
    }
    
    /**重置所有的btn*/
    func reloadAllButtonsOfTitleBarWithTitles(_ titles: [String]) {
        
    }
    
    
}
