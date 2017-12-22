//
//  SyntheticalTitleBarView.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/14.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit

fileprivate let kAnimationTime = 0.5

protocol MenuBarDelegate {
    func clickAddButton(editing:Bool)
    func menubar(_ menubar: MenuBar, didClickAt index: Int)
    func menubarClosed(_ menubar: MenuBar)
}

class MenuBar: UIView {
    var delegate: MenuBarDelegate?
    var titles: [String]?
    
    lazy var titleBar: TitleBarView = {
        let frame = CGRect(x: 0, y: 0, width: kScreenSize.width - self.bounds.size.height - 10, height: self.bounds.size.height)
        let bar = TitleBarView(frame: frame, titles: titles!, needScroll: true)
        bar.backgroundColor = UIColor(hex: 0xf6f6f6)
        bar.titleButtonClicked = { [weak self] index in
            if let delegate = self?.delegate {
                delegate.menubar(self!, didClickAt: index)
            }
        }
        return bar
    }()
    
    lazy var addBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: self.bounds.size.width - self.bounds.size.height - 5, y: 0, width: self.bounds.size.height, height: self.bounds.size.height)
        button.setImage(R.image.ic_subscribe(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(addClick), for: .touchUpInside)
        return button
    }()
    
    var showAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.duration = kAnimationTime - 0.2
        animation.repeatCount = 1
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.fromValue = 0
        animation.toValue = Double.pi/4*3
        return animation
    }()
    var hideAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.duration = kAnimationTime - 0.2
        animation.repeatCount = 1
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.fromValue = Double.pi/4*3
        animation.toValue = 0
        return animation
    }()
    
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        self.backgroundColor = UIColor(hex: 0xf9f9f9)
        
        let titleBackView = UIView(frame: titleBar.frame)
        let layer = CAGradientLayer()
        layer.frame = titleBar.frame
        layer.locations = [0.01,0.13,0.87,0.99]
        layer.startPoint = CGPoint(x:0, y:0)
        layer.endPoint = CGPoint(x:1, y:0)
        layer.colors = [UIColor.white.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        titleBackView.layer.mask = layer
        titleBackView.addSubview(titleBar)
        self.addSubview(titleBackView)
        self.addSubview(addBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func reloadTitleBar(with titles: [String]) {
        titleBar.reload(with: titles)
    }
    
    func scrollToCenterWithIndex(index: Int) {
        titleBar.scrollToCenter(with: index)
    }
    
    func ClickCollectionCellWithIndex(index:Int) {
        addBtn.isEnabled = false
        addBtn.isSelected = false
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.duration = kAnimationTime - 0.2
        animation.repeatCount = 1
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.fromValue = -Double.pi/4 * 3
        animation.toValue = 0
        addBtn.layer.add(animation, forKey:"hideAni")
        titleBar.scrollToCenter(with: index)
    }
    
    func endAnimation() {
        addBtn.isEnabled = true
    }
    
    @objc func addClick() {
        addBtn.isSelected = !addBtn.isSelected
        addBtn.isEnabled = false
        if addBtn.isSelected {
            addBtn.layer.add(showAnimation, forKey: "showAni")
        } else {
            addBtn.layer.add(hideAnimation, forKey: "hideAni")
            if let delegate = self.delegate {
                delegate.menubarClosed(self)
            }
        }
        
        if let delegate = self.delegate {
            delegate.clickAddButton(editing: addBtn.isSelected)
        }
    }
    
}
