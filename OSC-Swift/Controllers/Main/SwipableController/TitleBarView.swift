//
//  TitleBarView.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/14.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit

fileprivate let kMaxBtnWidth: CGFloat = 80.0
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
        let preTitle = self.titleButtons![self.currentIndex!];
        preTitle.setTitleColor(UIColor(hex: 0x909090), for: .normal)
        currentIndex = index
        let firstTitle = titleButtons![index]
        firstTitle.setTitleColor(UIColor.newSectionButtonSelectedColor(), for: .normal)
        let button = self.viewWithTag(index)
        if self.contentSize.width > self.frame.size.width {
            if (button?.frame.midX)! < kScreenSize.width / 2 {
                self.setContentOffset(CGPoint(x:0, y:0), animated: true)
            } else if (self.contentSize.width - (button?.frame.midX)!) < kScreenSize.width / 2 {
                self.setContentOffset(CGPoint(x:contentSize.width - frame.size.width, y:0), animated: true)
            } else {
                let needScrollWidth = (button?.frame.midX)! - contentOffset.x - kScreenSize.width / 2
                self.setContentOffset(CGPoint(x:contentOffset.x + needScrollWidth, y:0), animated: true)
            }
        }
    }
    
    /**重置所有的btn*/
    func reloadAllButtonsOfTitleBarWithTitles(_ titles: [String]) {
        if let titleButtons = titleButtons {
            for button in titleButtons {
                button.removeFromSuperview()
            }
        }
        
        currentIndex = 0
        titleButtons = [UIButton]()
        
        let titlesCount = CGFloat(titles.count)
        
        var buttonWidth = self.frame.size.width / titlesCount
        let buttonHeight = self.frame.size.height
        
        if titlesCount * kMaxBtnWidth > self.frame.size.width {
            self.contentSize = CGSize(width: titlesCount * kMaxBtnWidth, height:self.frame.size.height)
            buttonWidth = kMaxBtnWidth
        } else if isNeedScroll {
            self.contentSize = CGSize(width: self.frame.size.width + 1, height:self.frame.size.height)
            if (titles.count != 4) {
                buttonWidth = kMaxBtnWidth
            }
        } else {
            self.contentSize = CGSize(width: self.frame.size.width, height: self.frame.size.height)
        }
        
        for (index, title) in titles.enumerated() {
            var button = UIButton(type: .custom)
            button.backgroundColor = UIColor.clear
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            button.setTitleColor(UIColor(hex: 0x909090), for: .normal)
            button.setTitle(title, for: .normal)
            button.frame = CGRect(x: buttonWidth * CGFloat(index), y: 0, width: buttonWidth, height: buttonHeight)
            button.tag = index
            button.addTarget(self, action: #selector(onClick), for: .touchUpInside)
            
            titleButtons?.append(button)
            self.addSubview(button)
            self.sendSubview(toBack: button)
        }
        
        titleButtons![0].setTitleColor(UIColor.newSectionButtonSelectedColor(), for:.normal)
    }
    
    @objc func onClick(_ button: UIButton) {
        if (currentIndex != button.tag) {
            self.scrollToCenterWithIndex(button.tag)
            titleButtonClicked!(button.tag)
        }
    }
}
