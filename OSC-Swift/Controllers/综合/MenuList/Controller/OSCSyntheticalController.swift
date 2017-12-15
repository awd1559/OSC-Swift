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
    
    func editBtnClick(button: UIButton) {
        button.isSelected = !button.isSelected
        self.collectionView?.changeStateWithEdit(isEditing: button.isSelected)
        if (button.isSelected) {
            label.text = "拖动排序"
        }else{
            label.text = "切换栏目"
        }
    }
    
    func beginChoseProperty() {
        self.view.addSubview(self.collectionView!)
        titleView?.addSubview(self.propertyTitleView!)
        self.view.bringSubview(toFront: titleView!)
        UIView.animate(withDuration: kAnimationTime) {
            self.propertyTitleView?.alpha = 1
            self.collectionView?.frame = CGRect(x: 0, y: (self.titleView?.frame.maxY)!, width: kScreenSize.width, height: kScreenSize.height - (self.titleView?.frame.maxY)!)
        }
    }
    
    func endChoseProperty() {
        
    }
}

//MARK: - OSCPropertyCollectionDelegate
extension OSCSyntheticalController: OSCPropertyCollectionDelegate {
    func clickCellWithIndex(index: Int) {
        
    }
    
    func beginEdit() {
        self.editBtnClick(button: editBtn)
    }
}

//MARK: - SyntheticaltitleBarDelegate
extension OSCSyntheticalController: SyntheticalTitleBarDelegate {
    func addBtnClickWithIsBeginEdit(isEdit: Bool) {
        if isEdit {
            UIView.animate(withDuration: kAnimationTime, animations: {
                let frame = CGRect(x: 0, y: kScreenSize.height, width: kScreenSize.width, height: (self.tabBarController?.tabBar.bounds.size.height)!)
                self.tabBarController?.tabBar.frame = frame
            }, completion: { finished in
                self.titleView?.endAnimation()
            })
//            self.beginChoseProperty()
        }else{
            UIView.animate(withDuration: kAnimationTime, animations: {
                let frame = CGRect(x: 0, y: kScreenSize.height - (self.tabBarController?.tabBar.bounds.size.height)!, width: kScreenSize.width, height: (self.tabBarController?.tabBar.bounds.size.height)!)
                self.tabBarController?.tabBar.frame = frame
            }, completion: {finished in
                self.titleView?.endAnimation()
            })
//            self.endChoseProperty()
        }
    }
    
    func titleBtnClickWithIndex(index: Int) {
        currentIndex = index
        informationListController?.collectionView?.setContentOffset(CGPoint(x: CGFloat(index) * kScreenSize.width, y: 0), animated: true)
    }
    
    func closeSyntheticalTitleBarView() {
        
    }
}

//MARK: - InformationListCollectionDelegate
extension OSCSyntheticalController : InformationListCollectionDelegate {
    func ScrollViewDidEndWithIndex(index: Int) {
        
    }
}
