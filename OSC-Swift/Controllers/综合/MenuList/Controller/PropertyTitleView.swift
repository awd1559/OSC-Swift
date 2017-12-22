//
//  PropertyTitleView.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/22.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit

class PropertyTitleView: UIView {
    var label = UILabel()
    var editBtn = UIButton(type: .custom)
    var collectionDelegate: PropertyCollectionDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.titleBarColor()
        
        self.label = UILabel(frame: CGRect(x:10, y:0, width: 100, height: frame.size.height))
        self.label.font = UIFont.systemFont(ofSize: 14)
        
        self.label.textColor = UIColor(hex:0x9d9d9d)
        self.label.text = "切换栏目"
        self.addSubview(self.label)
        
        self.editBtn = UIButton(type: .custom)
        self.editBtn.frame = CGRect(x: frame.size.width - 60, y: frame.size.height/2 - 12, width: 60, height: 24)
        self.editBtn.setTitle("排序删除", for: .normal)
        self.editBtn.setTitle("完成", for: .selected)
        self.editBtn.setBackgroundImage(Utils.createImageWithColor(UIColor.white), for:.normal)
        self.editBtn.setBackgroundImage(Utils.createImageWithColor(UIColor.navigationbarColor()), for:.highlighted)
        self.editBtn.setTitleColor(UIColor.navigationbarColor(), for:.normal)
        self.editBtn.setTitleColor(UIColor.white, for:.highlighted)
        self.editBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.editBtn.layer.cornerRadius = 4
        self.editBtn.layer.masksToBounds = true
        self.editBtn.layer.borderColor = UIColor.navigationbarColor().cgColor
        self.editBtn.layer.borderWidth = 1
        self.editBtn.addTarget(self, action:#selector(editBtnClick), for:.touchUpInside)
        self.addSubview(editBtn)
        self.alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func editBtnClick(button: UIButton) {
        button.isSelected = !button.isSelected
        self.collectionDelegate?.changeStateWithEdit(button.isSelected)
        if (button.isSelected) {
            label.text = "拖动排序"
        }else{
            label.text = "切换栏目"
        }
    }
    
    func beginEdit() {
        self.editBtnClick(button: self.editBtn)
    }
}
