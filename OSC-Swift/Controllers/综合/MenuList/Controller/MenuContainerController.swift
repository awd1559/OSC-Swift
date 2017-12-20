//
//  OSCSyntheticalController.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/13.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit

fileprivate let kTitleHeigh = 60
fileprivate let kScreenSize = UIScreen.main.bounds.size
fileprivate let kAnimationTime = 0.4

class  MenuContainerController: UIViewController {
    var label = UILabel()
    var editBtn = UIButton()
    var titleView: MenuBarView?
    lazy var collectionView: MenuPropertyCollection = {
        let height = kScreenSize.height - (self.titleView?.frame.maxY)!
        let frame = CGRect(x: 0, y: (self.titleView?.frame.maxY)! - height, width: kScreenSize.width, height: height)
        let view = MenuPropertyCollection(frame: frame, selectIndex: self.currentIndex)
        view.menuPropertyDelegate = self
        return view
    }()
    
    lazy var propertyTitleView: UIView = {
        let view = UIView(frame: (self.titleView?.titleBarFrame)!)
        view.backgroundColor = UIColor.titleBarColor()
        
        self.label = UILabel(frame: CGRect(x:10, y:0, width: 100, height: view.bounds.size.height))
        self.label.font = UIFont.systemFont(ofSize: 14)
        
        self.label.textColor = UIColor(hex:0x9d9d9d)
        self.label.text = "切换栏目"
        view.addSubview(self.label)
        
        self.editBtn = UIButton(type: .custom)
        self.editBtn.frame = CGRect(x: (self.titleView?.titleBarFrame?.size.width)! - 60, y: (self.titleView?.titleBarFrame?.size.height)!/2 - 12, width: 60, height: 24)
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
        view.addSubview(editBtn)
        view.alpha = 0
        
        return view
    }()
    var currentIndex = 0
    var informationListController: MenuCollectionController?
    
    var selectArray: [String]?
//    var unSelectArray: []
    
    var bgV: UIView?
    var updateUrl: String?
    var message: String?
    
    //MARK: - lifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.backgroundColor = .red
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBar.isTranslucent = true
        self.tabBarController?.tabBar.isTranslucent = true
        if collectionView.isEditing {
            collectionView.changeStateWithEdit(isEditing: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tabBarController?.tabBar.isTranslucent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isTranslucent = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "综合"
        self.view.backgroundColor = .white
        
        selectArray = Utils.buildinMenuNames()
        selectArray?.append(contentsOf: Utils.selectedMenuNames())
        let frame = CGRect(x: 0, y: 64, width: Int(kScreenSize.width), height: kTitleHeigh)
        titleView = MenuBarView(frame: frame, titles: selectArray!)
        titleView?.delegate = self
        self.view.addSubview(titleView!)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: kScreenSize.width, height: kScreenSize.height - ((titleView?.frame.maxY)! - 49))
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 49, 0);
        informationListController = MenuCollectionController(collectionViewLayout: layout)
        informationListController?.delegate = self
        informationListController?.menuItem = Utils.menuItems(names: selectArray!)
        self.addChildViewController(informationListController!)
        
        informationListController?.collectionView?.frame = CGRect(x:0, y:(titleView?.frame.maxY)!, width: kScreenSize.width, height:kScreenSize.height - (titleView?.frame.maxY)!)
        self.view.addSubview((informationListController?.collectionView!)!)

        //TODO: introduce
//        let introView = OSCFunctionIntroManager.showIntroPage()
//        introView.didClickAddButtonBlock = ^(){
//            [self.titleView addClick];
//        };
    }
    
    
}

//MARK: - private
extension MenuContainerController {
    func beginRefresh() {
        informationListController?.beginRefreshWithIndex(currentIndex)
    }
    
    @objc func editBtnClick(button: UIButton) {
        button.isSelected = !button.isSelected
        self.collectionView.changeStateWithEdit(isEditing: button.isSelected)
        if (button.isSelected) {
            label.text = "拖动排序"
        }else{
            label.text = "切换栏目"
        }
    }
    
    func beginChoseProperty() {
        self.view.addSubview(self.collectionView)
        titleView?.addSubview(self.propertyTitleView)
        self.view.bringSubview(toFront: titleView!)
        UIView.animate(withDuration: kAnimationTime) {
            self.propertyTitleView.alpha = 1
            self.collectionView.frame = CGRect(x: 0, y: (self.titleView?.frame.maxY)!, width: kScreenSize.width, height: kScreenSize.height - (self.titleView?.frame.maxY)!)
        }
    }
    
    func endChoseProperty() {
        let height = kScreenSize.height - (titleView?.frame.maxY)!
        UIView.animate(withDuration: kAnimationTime,
           animations: {
            self.propertyTitleView.alpha = 0
            self.collectionView.frame = CGRect(x: 0, y: (self.titleView?.frame.maxY)!, width: kScreenSize.width, height: height)
        }, completion: { _ in
            self.collectionView.removeFromSuperview()
            self.propertyTitleView.removeFromSuperview()
//            self.propertyTitleView = nil
//            self.collectionView = nil
        })
    }
}

//MARK: - MenuBarDelegate
extension MenuContainerController: MenuBarDelegate {
    func clickAddButton(editing: Bool) {
        if editing {
            UIView.animate(withDuration: kAnimationTime, animations: {
                let frame = CGRect(x: 0, y: kScreenSize.height, width: kScreenSize.width, height: (self.tabBarController?.tabBar.bounds.size.height)!)
                self.tabBarController?.tabBar.frame = frame
            }, completion: { finished in
                self.titleView?.endAnimation()
            })
            self.beginChoseProperty()
        } else {
            UIView.animate(withDuration: kAnimationTime, animations: {
                let frame = CGRect(x: 0, y: kScreenSize.height - (self.tabBarController?.tabBar.bounds.size.height)!, width: kScreenSize.width, height: (self.tabBarController?.tabBar.bounds.size.height)!)
                self.tabBarController?.tabBar.frame = frame
            }, completion: {finished in
                self.titleView?.endAnimation()
            })
            self.endChoseProperty()
        }
    }
    
    func clickMenuBarItem(at index: Int) {
        currentIndex = index
        informationListController?.collectionView?.setContentOffset(CGPoint(x: CGFloat(index) * kScreenSize.width, y: 0), animated: true)
    }
    
    func closeMenuBarView() {
        collectionView.endEditing(true)
        selectArray = collectionView.CompleteAllEditings()
        titleView?.reloadAllButtonsOfTitleBarWithTitles(titles: selectArray!)
        Utils.updateSelectedMenuList(names: selectArray!)
        informationListController?.menuItem = Utils.menuItems(names: selectArray!)
        currentIndex = collectionView.getSelectIdenx()
        titleView?.scrollToCenterWithIndex(index: currentIndex)
        informationListController?.collectionView?.setContentOffset(CGPoint(x: CGFloat(currentIndex) * kScreenSize.width, y: 0), animated: true)
    }
}

//MARK: - PropertyCollectionDelegate
extension MenuContainerController: MenuPropertyDelegate {
    func clickPropertyItem(at index: Int) {
        currentIndex = index
        self.titleView?.reloadAllButtonsOfTitleBarWithTitles(titles: collectionView.CompleteAllEditings())
        self.titleView?.ClickCollectionCellWithIndex(index: index)
        self.clickAddButton(editing: false)
        selectArray = collectionView.CompleteAllEditings()
        Utils.updateSelectedMenuList(names: selectArray!)
        informationListController?.menuItem = Utils.menuItems(names: selectArray!)
        informationListController?.collectionView?.setContentOffset(CGPoint(x: CGFloat(index) * kScreenSize.width, y:0), animated: true)
    }
    
    func propertyCollectionBeginEdit() {
        self.editBtnClick(button: editBtn)
    }
}


//MARK: - InfoCollectionDelegate
extension MenuContainerController : MenuCollectionDelegate {
    func ScrollViewDidEndWithIndex(index: Int) {
        currentIndex = index
        self.titleView?.scrollToCenterWithIndex(index: index)
    }
}

