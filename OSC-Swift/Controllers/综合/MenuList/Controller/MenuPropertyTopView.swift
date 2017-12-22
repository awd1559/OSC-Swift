//
//  PropertyTitleView.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/22.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit

protocol PropertyTopViewDelegate {
//    func changeStateWithEdit(_: Bool)
    func startEdit()
    func stopEdit()
}

class MenuPropertyTopView: UIView {
    var topviewDelegate: PropertyTopViewDelegate?
    
    lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x:10, y:0, width: 100, height: self.frame.size.height))
        label.font = UIFont.systemFont(ofSize: 14)
        
        label.textColor = UIColor(hex:0x9d9d9d)
        label.text = "切换栏目"
        return label
    }()
    lazy var editBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: self.frame.size.width - 60, y: frame.size.height/2 - 12, width: 60, height: 24)
        button.setTitle("排序删除", for: .normal)
        button.setTitle("完成", for: .selected)
        button.setBackgroundImage(Utils.createImageWithColor(UIColor.white), for:.normal)
        button.setBackgroundImage(Utils.createImageWithColor(UIColor.navigationbarColor()), for:.highlighted)
        button.setTitleColor(UIColor.navigationbarColor(), for:.normal)
        button.setTitleColor(UIColor.white, for:.highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.navigationbarColor().cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action:#selector(editBtnClick), for:.touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.label)
        self.addSubview(self.editBtn)
        self.backgroundColor = UIColor.titleBarColor()
        self.alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func editBtnClick(button: UIButton) {
        beginEdit()
        
        if button.isSelected {
            self.topviewDelegate?.startEdit()
        } else {
            self.topviewDelegate?.stopEdit()
        }
    }
    
    func beginEdit() {
        self.editBtn.isSelected = !self.editBtn.isSelected
        
        if (self.editBtn.isSelected) {
            label.text = "拖动排序"
        }else{
            label.text = "切换栏目"
        }
    }
}
