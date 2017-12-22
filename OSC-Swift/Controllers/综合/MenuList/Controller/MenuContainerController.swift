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
    var currentIndex = 0
    var selectArray: [String]?
    var bgV: UIView?
    var updateUrl: String?
    var message: String?
    
    lazy var menuBar: MenuBar = {
        let frame = CGRect(x: 0, y: 64, width: Int(kScreenSize.width), height: kTitleHeigh)
        let menu = MenuBar(frame: frame, titles: selectArray!)
        menu.delegate = self
        return menu
    }()
    
    lazy var propertyTopView: MenuPropertyTopView = {
        let view = MenuPropertyTopView(frame: self.menuBar.titleBar.frame)
        view.topviewDelegate = self.propertyCollection
        return view
    }()
    
    lazy var propertyCollection: MenuPropertyCollection = {
        let height = kScreenSize.height - self.menuBar.frame.maxY
        let frame = CGRect(x: 0, y: self.menuBar.frame.maxY - height, width: kScreenSize.width, height: height)
        let view = MenuPropertyCollection(frame: frame, selectIndex: self.currentIndex)
        view.menuPropertyDelegate = self
        return view
    }()
    
    lazy var pageCollection: MenuPageCollection = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: kScreenSize.width, height: kScreenSize.height - (menuBar.frame.maxY - 49))
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 49, 0);
        let page = MenuPageCollection(collectionViewLayout: layout)
        page.delegate = self
        page.menuItems = Utils.menuItems(names: selectArray!)
        page.collectionView?.frame = CGRect(x:0, y:menuBar.frame.maxY, width: kScreenSize.width, height:kScreenSize.height - menuBar.frame.maxY)
        return page
    }()
    
    
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
        
        self.view.addSubview(menuBar)
        self.addChildViewController(pageCollection)
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
}

//MARK: - MenuBarDelegate
extension MenuContainerController: MenuBarDelegate {
    func menubarWillShow() {
        UIView.animate(withDuration: kAnimationTime) {
            let frame = CGRect(x: 0, y: kScreenSize.height, width: kScreenSize.width, height: (self.tabBarController?.tabBar.bounds.size.height)!)
            self.tabBarController?.tabBar.frame = frame
        }
        
        self.view.addSubview(self.propertyCollection)
        menuBar.addSubview(self.propertyTopView)
        self.view.bringSubview(toFront: menuBar)
        UIView.animate(withDuration: kAnimationTime) {
            self.propertyTopView.alpha = 1
            self.propertyCollection.frame = CGRect(x: 0, y: self.menuBar.frame.maxY, width: kScreenSize.width, height: kScreenSize.height - self.menuBar.frame.maxY)
        }
    }
    func menubarWillClose() {
        propertyCollection.endEditing(true)
        selectArray = propertyCollection.CompleteAllEditings()
        menuBar.reloadTitleBar(with: selectArray!)
        Utils.updateSelectedMenuList(names: selectArray!)
        pageCollection.menuItems = Utils.menuItems(names: selectArray!)
        menuBar.scrollToCenter(with: currentIndex)
        pageCollection.collectionView?.setContentOffset(CGPoint(x: CGFloat(currentIndex) * kScreenSize.width, y: 0), animated: true)
        
        //show tabbar
        UIView.animate(withDuration: kAnimationTime) {
            let frame = CGRect(x: 0, y: kScreenSize.height - (self.tabBarController?.tabBar.bounds.size.height)!, width: kScreenSize.width, height: (self.tabBarController?.tabBar.bounds.size.height)!)
            self.tabBarController?.tabBar.frame = frame
        }
        
        //hide menu property collection, and remove it
        let height = kScreenSize.height - menuBar.frame.maxY
        UIView.animate(withDuration: kAnimationTime, animations: {
            self.propertyTopView.alpha = 0
            self.propertyCollection.frame = CGRect(x: 0, y: self.menuBar.frame.maxY, width: kScreenSize.width, height: height)
        }, completion: { _ in
            self.propertyCollection.removeFromSuperview()
            self.propertyTopView.removeFromSuperview()
            //            self.propertyTitleView = nil
            //            self.collectionView = nil
        })
    }
    
    func menubardidClickAt(_ index: Int) {
        currentIndex = index
        pageCollection.collectionView?.setContentOffset(CGPoint(x: CGFloat(index) * kScreenSize.width, y: 0), animated: true)
    }
}

//MARK: - MenuPropertyDelegate
extension MenuContainerController: MenuPropertyDelegate {
    func clickPropertyItem(at index: Int) {
        currentIndex = index
        self.menuBar.reloadTitleBar(with: propertyCollection.CompleteAllEditings())
        self.menuBar.ClickCollectionCellWithIndex(index: index)
        self.menubarWillClose()
        selectArray = propertyCollection.CompleteAllEditings()
        Utils.updateSelectedMenuList(names: selectArray!)
        pageCollection.menuItems = Utils.menuItems(names: selectArray!)
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
        self.menuBar.scrollToCenter(with: index)
    }
}

