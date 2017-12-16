//
//  InformationCell.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/14.
//  Copyright © 2017年 awd. All rights reserved.
//

import Foundation

//TODO: this is OSCInformationCollectionViewCell
let kInformationListCollectionViewCellIdentifier = "OSCInformationListCollectionViewCell"
protocol InfoCellDelegate {
    func cell(_ cell: InfoCell, update dataSourceDic:[String: InfoResultItem])
    
    func cell(_ cell:InfoCell, onclick tableViewCell: UITableViewCell,  push controller: UIViewController, url: String)
    
//    func cell(_ cell: InfoCell, onclick banner: UIView, push controller: UIViewController, url:String)
}

extension InfoCellDelegate {
    func cell(_ cell: InfoCell, onclick banner: UIView, push controller: UIViewController, url:String) {
        
    }
}


class InfoCell: UICollectionViewCell {
    var delegate: InfoCellDelegate?
    
    func beginRefreshCurCell() {
        
    }
}

class InfoResultItem {
    var bannerArr: [OSCBanner]?
    
    var tableViewArr: [OSCListItem]?
    
    var pageToken: String?
    
    var offestDistance: Float?
    
    var isFromCache: Bool?
}
