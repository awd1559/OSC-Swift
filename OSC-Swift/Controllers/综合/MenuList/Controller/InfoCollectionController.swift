//
//  OSCInformationListCollectionViewController.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/14.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit

fileprivate let kScreenSize = UIScreen.main.bounds.size

protocol InfoCollectionDelegate {
    func ScrollViewDidEndWithIndex(index:Int)
}

class InfoCollectionController: UICollectionViewController {
    var delegate: InfoCollectionDelegate?
    var menuItem: [OSCMenuItem]? {
        didSet {
            if dataSources_dic == nil {
                dataSources_dic = [String:InfoResultItem]()
                for curMenuItem in menuItem! {
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
        self.collectionView?.register(InfoCollectionCell.self, forCellWithReuseIdentifier:kInformationListCollectionViewCellIdentifier)
        self.collectionView?.isPagingEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        for (menuItem_token, resultItem) in dataSources_dic! {
            if menuItem_token != curMenuItem?.token {
                resultItem.bannerArr = nil
                resultItem.tableViewArr = nil
                resultItem.pageToken = nil
                resultItem.offestDistance = 0
//                dataSources_dic setObject:resultItem forKey:menuItem_token];
            }
        }
    }
    
    func beginRefreshWithIndex(_ index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        let cell = self.collectionView?.cellForItem(at: indexPath)
        cell.beginRefreh()
    }
    
    func getCurrentListDataSource() -> [String: InfoResultItem]{
        let curMenuToken = curMenuItem?.token
        let resultItem = dataSources_dic![curMenuToken!]!
        let curResultDic: [String: InfoResultItem] = [curMenuToken! : resultItem]
        return curResultDic
    }
    
    
    //MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.menuItem?.count)!
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = UICollectionViewCell()
        
        curMenuItem = self.menuItem?[indexPath.row]
        let curDic = self.getCurrentListDataSource()
        let cell = InfoCollectionCell.returnReuseInformationListCollectionViewCell(collectionView, identifier:kInformationListCollectionViewCellIdentifier, indexPath:indexPath, model:curMenuItem!)

        cell.configurationPostBackDictionary(curDic)
        cell.delegate = self
        
        return cell
    }
    
    //MARK: - scrollviewDelegate
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / kScreenSize.width)
        if let delegate = self.delegate {
            delegate.ScrollViewDidEndWithIndex(index: index)
        }
    }
}


//MARK: - InfoCollectionCellDelegate
extension InfoCollectionController: InfoCollectionCellDelegate {
    func cell(_ cell: InfoCollectionCell, update dataSourceDic: [String : InfoResultItem]) {
        
    }
    
    func cell(_ cell: InfoCollectionCell, onclick tableViewCell: UITableViewCell, push controller: UIViewController, url: String) {
        
    }
    
    func cell(_ cell: InfoCollectionCell, onclick banner: UIView, push controller: UIViewController, url: String) {
        
    }
    
    
}
