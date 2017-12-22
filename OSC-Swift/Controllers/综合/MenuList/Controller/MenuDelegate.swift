//
//  MenuDelegate.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/22.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit

protocol MenuContainerDelegate {
    
}

protocol MenuCollectionDelegate {
    func ScrollViewDidEndWithIndex(index:Int)
}

protocol MenuTopDelegate {
    
}

protocol MenuCellDelegate {
    
}

//FIXME: OSCInformationListCollectionViewCellDelegate
protocol MenuCollectionCellDelegate {
    func cell(_ cell: MenuCollectionCell, update dataSourceDic:[String: InfoResultItem])
    
    func cell(_ cell: MenuCollectionCell, onclick tableViewCell: UITableViewCell,  push controller: UIViewController, url: String)
}

extension MenuCollectionCellDelegate {
    //optional
    func cell(_ cell: MenuCollectionCell, onclick banner: UIView, push controller: UIViewController, url:String) {
    }
}

