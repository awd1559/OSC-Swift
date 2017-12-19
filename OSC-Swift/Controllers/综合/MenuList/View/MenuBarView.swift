//
//  SyntheticalTitleBarView.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/14.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit

fileprivate let kScreenSize = UIScreen.main.bounds.size
fileprivate let kAnimationTime = 0.5

protocol MenuBarDelegate {
    func addBtnClickWithIsBeginEdit(isEdit:Bool)
    func titleBtnClickWithIndex(index: Int)
    func closeSyntheticalTitleBarView()
}
class MenuBarView: UIView {
    var delegate: MenuBarDelegate?
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
        let frame = CGRect(x: 0, y: 0, width: kScreenSize.width - self.bounds.size.height - 10, height: self.bounds.size.height)
        titleBar = TitleBarView(frame: frame, titles: titleArray!, needScroll: true)
        titleBar?.titleButtonClicked = { [weak self] index in
            if let delegate = self?.delegate {
                delegate.titleBtnClickWithIndex(index: index)
            }
        }
        
        addBtn = UIButton(type: .custom)
        addBtn?.frame = CGRect(x: self.bounds.size.width - self.bounds.size.height - 5, y: 0, width: self.bounds.size.height, height: self.bounds.size.height)
        addBtn?.setImage(R.image.ic_subscribe(), for: .normal)
        addBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        addBtn?.addTarget(self, action: #selector(addClick), for: .touchUpInside)
        self.addSubview(addBtn!)
        titleBar?.backgroundColor = UIColor(hex: 0xf6f6f6)
        titleBarFrame = titleBar?.frame
        
        let titleBackView = UIView(frame: (titleBar?.frame)!)
        titleBackView.addSubview(titleBar!)
        self.addSubview(titleBackView)
        
        let layer = CAGradientLayer()
        layer.frame = (titleBar?.frame)!
        layer.locations = [0.01,0.13,0.87,0.99]
        layer.startPoint = CGPoint(x:0, y:0)
        layer.endPoint = CGPoint(x:1, y:0)
        layer.colors = [UIColor.white.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        titleBackView.layer.mask = layer
    }
    
    func reloadAllButtonsOfTitleBarWithTitles(titles: [String]) {
        
    }
    
    func scrollToCenterWithIndex(index: Int) {
        
    }
    
    func ClickCollectionCellWithIndex(index:Int) {
        
    }
    
    func endAnimation() {
        addBtn?.isEnabled = true
    }
    
    @objc func addClick() {
        addBtn?.isSelected = !(addBtn?.isSelected)!
        addBtn?.isEnabled = false
        if (addBtn?.isSelected)! {
            let animation = CABasicAnimation(keyPath: "transform.rotation")
            animation.duration = kAnimationTime - 0.2
            animation.repeatCount = 1
            animation.fillMode = kCAFillModeForwards
            animation.isRemovedOnCompletion = false
            animation.fromValue = 0
            animation.toValue = Double.pi/4*3
            addBtn?.layer.add(animation, forKey: "showAni")
        } else {
            let animation = CABasicAnimation(keyPath: "transform.rotation")
            animation.duration = kAnimationTime - 0.2
            animation.repeatCount = 1
            animation.fillMode = kCAFillModeForwards
            animation.isRemovedOnCompletion = false
            animation.fromValue = Double.pi/4*3
            animation.toValue = 0
            addBtn?.layer.add(animation, forKey: "hideAni")
            
            if let delegate = self.delegate {
                delegate.closeSyntheticalTitleBarView()
            }
        }
        
        if let delegate = self.delegate {
            delegate.addBtnClickWithIsBeginEdit(isEdit: (addBtn?.isSelected)!)
        }
    }
    
}
