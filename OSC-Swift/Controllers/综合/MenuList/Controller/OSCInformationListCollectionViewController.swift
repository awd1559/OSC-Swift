//
//  OSCInformationListCollectionViewController.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/14.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit

fileprivate let kScreenSize = UIScreen.main.bounds.size

protocol InformationListCollectionDelegate {
    func ScrollViewDidEndWithIndex(index:Int)
}

class OSCInformationListCollectionViewController: UICollectionViewController {
    var informationListCollectionDelegate: InformationListCollectionDelegate?
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

//    init(_ layout: UICollectionViewLayout) {
//        super.init(collectionViewLayout: layout)
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView?.contentInsetAdjustmentBehavior = .automatic
        isTouchSliding = false
        self.collectionView?.backgroundColor = .white
        self.collectionView?.register(InfoCell.self, forCellWithReuseIdentifier:kInformationListCollectionViewCellIdentifier)
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
        let cell = InfoCell.returnReuseInformationListCollectionViewCell(collectionView, identifier:kInformationListCollectionViewCellIdentifier, indexPath:indexPath, model:curMenuItem!)

        cell.configurationPostBackDictionary(curDic)
        cell.delegate = self
        
        return cell
    }
    
    //MARK: - scrollviewDelegate
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / kScreenSize.width)
        if let delegate = self.informationListCollectionDelegate {
            delegate.ScrollViewDidEndWithIndex(index: index)
        }
    }
}

extension OSCInformationListCollectionViewController: InfoCellDelegate {
    func cell(_ cell: InfoCell, update dataSourceDic: [String : InfoResultItem]) {
        
    }
    
    func cell(_ cell: InfoCell, onclick tableViewCell: UITableViewCell, push controller: UIViewController, url: String) {
        
    }
    
    func cell(_ cell: InfoCell, onclick banner: UIView, push controller: UIViewController, url: String) {
        
    }
    
    
}
