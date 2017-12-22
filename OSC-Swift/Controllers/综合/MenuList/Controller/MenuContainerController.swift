//
//  OSCSyntheticalController.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/13.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit

fileprivate let kTitleHeigh = 60
fileprivate let kAnimationTime = 0.4

class  MenuContainerController: UIViewController {
    var label = UILabel()
    var editBtn = UIButton()
    
    lazy var menuNavTab: MenuNavTab = {
        let frame = CGRect(x: 0, y: 64, width: Int(kScreenSize.width), height: kTitleHeigh)
        let menu = MenuNavTab(frame: frame, titles: selectArray!)
        menu.delegate = self
        return menu
    }()
    lazy var propertyTopView: MenuPropertyTopView = {
        let view = MenuPropertyTopView(frame: (self.menuNavTab.titleBar?.frame)!)
        view.collectionDelegate = self.propertyCollection
        return view
    }()
    
    lazy var propertyCollection: MenuPropertyCollection = {
        let height = kScreenSize.height - self.menuNavTab.frame.maxY
        let frame = CGRect(x: 0, y: self.menuNavTab.frame.maxY - height, width: kScreenSize.width, height: height)
        let view = MenuPropertyCollection(frame: frame, selectIndex: self.currentIndex)
        view.menuPropertyDelegate = self
        return view
    }()
    
    var currentIndex = 0
    lazy var pageCollection: MenuPageCollection = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: kScreenSize.width, height: kScreenSize.height - (menuNavTab.frame.maxY - 49))
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 49, 0);
        let page = MenuPageCollection(collectionViewLayout: layout)
        page.delegate = self
        page.menuItem = Utils.menuItems(names: selectArray!)
        return page
    }()
    
    var selectArray: [String]?
    
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
        if propertyCollection.isEditing {
            propertyCollection.changeStateWithEdit(true)
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
        
        self.view.addSubview(menuNavTab)

        self.addChildViewController(pageCollection)
        
        pageCollection.collectionView?.frame = CGRect(x:0, y:menuNavTab.frame.maxY, width: kScreenSize.width, height:kScreenSize.height - menuNavTab.frame.maxY)
        self.view.addSubview(pageCollection.collectionView!)

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
        pageCollection.beginRefreshWithIndex(currentIndex)
    }
    
    func beginChoseProperty() {
        self.view.addSubview(self.propertyCollection)
        menuNavTab.addSubview(self.propertyTopView)
        self.view.bringSubview(toFront: menuNavTab)
        UIView.animate(withDuration: kAnimationTime) {
            self.propertyTopView.alpha = 1
            self.propertyCollection.frame = CGRect(x: 0, y: self.menuNavTab.frame.maxY, width: kScreenSize.width, height: kScreenSize.height - self.menuNavTab.frame.maxY)
        }
    }
    
    func endChoseProperty() {
        let height = kScreenSize.height - menuNavTab.frame.maxY
        UIView.animate(withDuration: kAnimationTime,
           animations: {
            self.propertyTopView.alpha = 0
            self.propertyCollection.frame = CGRect(x: 0, y: self.menuNavTab.frame.maxY, width: kScreenSize.width, height: height)
        }, completion: { _ in
            self.propertyCollection.removeFromSuperview()
            self.propertyTopView.removeFromSuperview()
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
                self.menuNavTab.endAnimation()
            })
            self.beginChoseProperty()
        } else {
            UIView.animate(withDuration: kAnimationTime, animations: {
                let frame = CGRect(x: 0, y: kScreenSize.height - (self.tabBarController?.tabBar.bounds.size.height)!, width: kScreenSize.width, height: (self.tabBarController?.tabBar.bounds.size.height)!)
                self.tabBarController?.tabBar.frame = frame
            }, completion: {finished in
                self.menuNavTab.endAnimation()
            })
            self.endChoseProperty()
        }
    }
    
    func clickMenuBarItem(at index: Int) {
        currentIndex = index
        pageCollection.collectionView?.setContentOffset(CGPoint(x: CGFloat(index) * kScreenSize.width, y: 0), animated: true)
    }
    
    func closeMenuBarView() {
        propertyCollection.endEditing(true)
        selectArray = propertyCollection.CompleteAllEditings()
        menuNavTab.reloadAllButtonsOfTitleBarWithTitles(titles: selectArray!)
        Utils.updateSelectedMenuList(names: selectArray!)
        pageCollection.menuItem = Utils.menuItems(names: selectArray!)
        currentIndex = propertyCollection.getSelectIdenx()
        menuNavTab.scrollToCenterWithIndex(index: currentIndex)
        pageCollection.collectionView?.setContentOffset(CGPoint(x: CGFloat(currentIndex) * kScreenSize.width, y: 0), animated: true)
    }
}

//MARK: - MenuPropertyDelegate
extension MenuContainerController: MenuPropertyDelegate {
    func clickPropertyItem(at index: Int) {
        currentIndex = index
        self.menuNavTab.reloadAllButtonsOfTitleBarWithTitles(titles: propertyCollection.CompleteAllEditings())
        self.menuNavTab.ClickCollectionCellWithIndex(index: index)
        self.clickAddButton(editing: false)
        selectArray = propertyCollection.CompleteAllEditings()
        Utils.updateSelectedMenuList(names: selectArray!)
        pageCollection.menuItem = Utils.menuItems(names: selectArray!)
        pageCollection.collectionView?.setContentOffset(CGPoint(x: CGFloat(index) * kScreenSize.width, y:0), animated: true)
    }
    
    func propertyCollectionBeginEdit() {
        self.propertyTopView.beginEdit()
    }
}


//MARK: - MenuPageDelegate
extension MenuContainerController : MenuPageDelegate {
    func scrollViewDidEnd(at index: Int) {
        currentIndex = index
        self.menuNavTab.scrollToCenterWithIndex(index: index)
    }
}

