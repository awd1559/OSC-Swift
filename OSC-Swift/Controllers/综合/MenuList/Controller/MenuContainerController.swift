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
    //TODO: can remove, let the menu and pager mange this
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


//MARK: - MenuBarDelegate
extension MenuContainerController: MenuBarDelegate {
    func propertyWillShow() {
        //hide tabbar
        UIView.animate(withDuration: kAnimationTime) {
            let frame = CGRect(x: 0, y: kScreenSize.height, width: kScreenSize.width, height: (self.tabBarController?.tabBar.bounds.size.height)!)
            self.tabBarController?.tabBar.frame = frame
        }
        self.view.bringSubview(toFront: self.menuBar)
    }
    
    func propertyWillHide() {
        //show tabbar
        UIView.animate(withDuration: kAnimationTime) {
            let frame = CGRect(x: 0, y: kScreenSize.height - (self.tabBarController?.tabBar.bounds.size.height)!, width: kScreenSize.width, height: (self.tabBarController?.tabBar.bounds.size.height)!)
            self.tabBarController?.tabBar.frame = frame
        }
    }
    func menubardidClickAt(_ index: Int) {
        pageCollection.collectionView?.setContentOffset(CGPoint(x: CGFloat(index) * kScreenSize.width, y: 0), animated: true)
    }
}


//MARK: - MenuPageDelegate
extension MenuContainerController : MenuPageDelegate {
    func scrollViewDidEnd(at index: Int) {
        self.menuBar.scrollToCenter(with: index)
    }
}

