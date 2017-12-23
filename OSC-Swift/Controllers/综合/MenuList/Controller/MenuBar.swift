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
    func propertyWillShow()
    func propertyWillHide()
    func menubardidClickAt(_ index: Int)
}

class MenuBar: UIView {
    var delegate: MenuBarDelegate?
    var titles: [String]?
    var index = 0
    var isPropertyViewDisplayed = false
    
    lazy var titleBar: TitleBarView = {
        let frame = CGRect(x: 0, y: 0, width: kScreenSize.width - self.bounds.size.height - 10, height: self.bounds.size.height)
        let bar = TitleBarView(frame: frame, titles: titles!, needScroll: true)
        bar.backgroundColor = UIColor(hex: 0xf6f6f6)
        bar.titleButtonClicked = { [weak self] index in
            self?.index = index
            if let delegate = self?.delegate {
                delegate.menubardidClickAt(index)
            }
        }
        return bar
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: self.bounds.size.width - self.bounds.size.height - 5, y: 0, width: self.bounds.size.height, height: self.bounds.size.height)
        button.setImage(R.image.ic_subscribe(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(addClick), for: .touchUpInside)
        return button
    }()
    
    var AddButtonOpenAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.duration = kAnimationTime - 0.2
        animation.repeatCount = 1
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.fromValue = 0
        animation.toValue = Double.pi/4*3
        return animation
    }()
    var AddButtonCloseAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.duration = kAnimationTime - 0.2
        animation.repeatCount = 1
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.fromValue = -Double.pi/4*3
        animation.toValue = 0
        return animation
    }()
    
    lazy var topView: MenuPropertyTopView = {
        let view = MenuPropertyTopView(frame: self.titleBar.frame)
        view.topviewDelegate = self
        return view
    }()
    
    lazy var collectionView: MenuPropertyCollection = {
        let height = kScreenSize.height - self.frame.maxY
        let frame = CGRect(x: 0, y: self.frame.maxY - height, width: kScreenSize.width, height: height)
        let view = MenuPropertyCollection(frame: frame)
        view.menuPropertyDelegate = self
        return view
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
        self.addSubview(addButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func addClick() {
        if isPropertyViewDisplayed {
            self.delegate?.propertyWillHide()
            self.closePropertyView()
        } else {
            self.delegate?.propertyWillShow()
            self.showPropertyView()
        }
    }
    
    fileprivate func showPropertyView() {
        addButton.layer.add(AddButtonOpenAnimation, forKey: "showAni")
        self.addSubview(self.topView)
        self.superview?.addSubview(self.collectionView)
        self.collectionView.index = self.titleBar.currentIndex!
        
        //show property collection
        UIView.animate(withDuration: kAnimationTime) {
            self.topView.alpha = 1
            self.collectionView.frame = CGRect(x: 0, y: self.frame.maxY, width: kScreenSize.width, height: kScreenSize.height - self.frame.maxY)
        }
        self.isPropertyViewDisplayed = true
    }
    fileprivate func closePropertyView() {
        addButton.layer.add(AddButtonCloseAnimation, forKey: "hideAni")
        topView.stopEdit()
        let _ = collectionView.stopEdit()
        titles = collectionView.getSelectedTitles()
        index = collectionView.getSelectIdenx()
        self.titleBar.reload(with: titles!)
        titleBar.scrollToCenter(with: index)
        
        //hide menu property collection, and remove it
        let height = kScreenSize.height - self.frame.maxY
        UIView.animate(withDuration: kAnimationTime, animations: {
            self.topView.alpha = 0
            self.collectionView.frame = CGRect(x: 0, y: self.frame.maxY, width: kScreenSize.width, height: height)
        }, completion: { _ in
            self.collectionView.removeFromSuperview()
            self.topView.removeFromSuperview()
        })
        
        self.isPropertyViewDisplayed = false
    }
    
    func scrollToCenter(with index: Int) {
        titleBar.scrollToCenter(with: index)
    }
}


//MARK: - PropertyTopViewDelegate
extension MenuBar: PropertyTopViewDelegate {
    func startEdit() {
        self.collectionView.startEdit()
    }
    
    func stopEdit() {
        let _ = self.collectionView.stopEdit()
    }
}


//MARK: - MenuPropertyDelegate
extension MenuBar: MenuPropertyDelegate {
    func clickPropertyItem(at index: Int) {
        self.topView.stopEdit()
        let _ = self.collectionView.stopEdit()
        self.closePropertyView()
        
        self.titleBar.scrollToCenter(with: index)
        self.delegate?.menubardidClickAt(index)
    }
    
    func propertyCollectionBeginEdit() {
        self.topView.startEdit()
    }
}
