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

class  OSCSyntheticalController: UIViewController {
    var label = UILabel()
    var editBtn = UIButton()
    var titleView: SyntheticalTitleBarView?
    var collectionView: OSCPropertyCollection?
    var propertyTitleView: UIView?
    var currentIndex = 0
    var informationListController: OSCInformationListCollectionViewController?
    
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
        if (collectionView != nil) && (collectionView?.isEditing)! {
            collectionView?.changeStateWithEdit(isEditing: true)
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
        
        selectArray = Utils.fixedLocalMenuNames()
        selectArray?.append(contentsOf: Utils.allSelectedMenuNames())
        self.navigationItem.title = "综合"
        self.view.backgroundColor = .white
        let frame = CGRect(x: 0, y: 64, width: Int(kScreenSize.width), height: kTitleHeigh)
        titleView = SyntheticalTitleBarView(frame: frame, titles: selectArray!)
        titleView?.delegate = self
        self.view.addSubview(titleView!)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: kScreenSize.width, height: kScreenSize.height - ((titleView?.frame.maxY)! - 49))
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 49, 0);
        informationListController = OSCInformationListCollectionViewController(collectionViewLayout: layout)
        informationListController?.informationListCollectionDelegate = self
//        informationListController.menuItem = [Utils conversionMenuItemsWithMenuNames:selectArray]
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
extension OSCSyntheticalController {
    func beginRefresh() {
        
    }
}

//MARK: - OSCPropertyCollectionDelegate
extension OSCSyntheticalController: OSCPropertyCollectionDelegate {
    
}

//MARK: - SyntheticaltitleBarDelegate
extension OSCSyntheticalController: SyntheticalTitleBarDelegate {
    func addBtnClickWithIsBeginEdit(isEdit: Bool) {
        
    }
    
    func titleBtnClickWithIndex(index: Int) {
        
    }
    
    func closeSyntheticalTitleBarView() {
        
    }
}

//MARK: - InformationListCollectionDelegate
extension OSCSyntheticalController : InformationListCollectionDelegate {
    func ScrollViewDidEndWithIndex(index: Int) {
        
    }
}
