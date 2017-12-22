//
//  OSCInformationListCollectionViewController.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/14.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit


protocol MenuPageDelegate {
    func scrollViewDidEnd(at index:Int)
}


class MenuPageCollection: UICollectionViewController {
    var delegate: MenuPageDelegate?
    var menuItems: [OSCMenuItem]? {
        didSet {
            if dataSources_dic == nil {
                dataSources_dic = [String:InfoResultItem]()
                for curMenuItem in menuItems! {
                    let postBackItem = InfoResultItem()
//                    self.fillResultPostBackItem(postBackItem, currentMenuItem:curMenuItem)
                    dataSources_dic![curMenuItem.token] =  postBackItem
                }
            }
            self.collectionView?.reloadData()
        }
    }
    var isTouchSliding: Bool?
    var curMenuItem: OSCMenuItem?
//    var HUD: MBProgressHUD
//    var pageTokens: []?
    var dataSources_dic: [String: InfoResultItem]?
    
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView?.contentInsetAdjustmentBehavior = .automatic
        isTouchSliding = false
        self.collectionView?.backgroundColor = .white
        self.collectionView?.register(MenuPageCell.self, forCellWithReuseIdentifier:kInformationListCollectionViewCellIdentifier)
        self.collectionView?.isPagingEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        for (menuItem_token, item) in dataSources_dic! {
            if menuItem_token != curMenuItem?.token {
                var resultItem = item
                resultItem.bannerArr = nil
                resultItem.tableViewArr = nil
                resultItem.pageToken = ""
                resultItem.offsetDistance = 0
                dataSources_dic![menuItem_token] = resultItem
            }
        }
    }
    
    func beginRefreshWithIndex(_ index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        let cell = self.collectionView?.cellForItem(at: indexPath) as! MenuPageCell
        cell.beginRefreshCurCell()
    }
    
    func getCurrentListDataSource() -> [String: InfoResultItem]{
        let curMenuToken = curMenuItem?.token
        let resultItem = dataSources_dic![curMenuToken!]!
        let curResultDic: [String: InfoResultItem] = [curMenuToken! : resultItem]
        return curResultDic
    }
    
    
    //MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.menuItems?.count)!
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        curMenuItem = self.menuItems?[indexPath.row]
        let curDic = self.getCurrentListDataSource()
        let cell = MenuPageCell.returnReuseInformationListCollectionViewCell(collectionView, identifier:kInformationListCollectionViewCellIdentifier, indexPath:indexPath, model:curMenuItem!)

        cell.configurationPostBackDictionary(curDic)
        cell.delegate = self
        
        return cell
    }
    
    //MARK: - scrollviewDelegate
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / kScreenSize.width)
        if let delegate = self.delegate {
            delegate.scrollViewDidEnd(at: index)
        }
    }
}


//MARK: - InfoCollectionCellDelegate
extension MenuPageCollection: MenuPageCellDelegate {
    func cell(_ cell: MenuPageCell, update dataSourceDic: [String : InfoResultItem]) {
        
    }
    
    func cell(_ cell: MenuPageCell, onclick tableViewCell: UITableViewCell, push controller: UIViewController, url: String) {
        
    }
    
    func cell(_ cell: MenuPageCell, onclick banner: UIView, push controller: UIViewController, url: String) {
        
    }
    
    
}
