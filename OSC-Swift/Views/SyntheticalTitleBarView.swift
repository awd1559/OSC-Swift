//
//  SyntheticalTitleBarView.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/14.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit

protocol SyntheticalTitleBarDelegate {
    func addBtnClickWithIsBeginEdit(isEdit:Bool)
    func titleBtnClickWithIndex(index: Int)
    func closeSyntheticalTitleBarView()
}
class SyntheticalTitleBarView: UIView {
    var delegate: SyntheticalTitleBarDelegate?
    var titleBarFrame: CGRect?
    var titleBar: TitleBarView?
    var titleArray: [String]?
    var addBtn: UIButton?
    
    init(frame: CGRect, titles: [String]) {
        self.titleArray = titles
        super.init(frame: frame)
        self.addContentView()
        self.backgroundColor = UIColor(hex: 0xf9f9f9)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addContentView() {
        
    }
    
    func reloadAllButtonsOfTitleBarWithTitles(titles: [String]) {
        
    }
    
    func scrollToCenterWithIndex(index: Int) {
        
    }
    
    func ClickCollectionCellWithIndex(index:Int) {
        
    }
    
    func endAnimation() {
        
    }
    
    func addClick() {
        
    }
    
}
