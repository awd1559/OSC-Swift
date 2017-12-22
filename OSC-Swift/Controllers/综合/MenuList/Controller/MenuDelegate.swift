//
//  MenuDelegate.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/22.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit

protocol MenuPageDelegate {
    func scrollViewDidEnd(at index:Int)
}

protocol MenuPageCellDelegate {
    func cell(_ cell: MenuPageCell, update dataSourceDic:[String: InfoResultItem])
    
    func cell(_ cell: MenuPageCell, onclick tableViewCell: UITableViewCell,  push controller: UIViewController, url: String)
}

extension MenuPageCellDelegate {
    //optional
    func cell(_ cell: MenuPageCell, onclick banner: UIView, push controller: UIViewController, url:String) {
    }
}

//FIXME: in PropertyCollection
protocol MenuPropertyDelegate {
    func clickPropertyItem(at index: Int)
    func propertyCollectionBeginEdit()
}

//FIXME: in PropertyTitleView
protocol PropertyCollectionDelegate {
    func changeStateWithEdit(_: Bool)
}

//FIXME: in MenuNavTab
protocol MenuBarDelegate {
    func clickAddButton(editing:Bool)
    func clickMenuBarItem(at index: Int)
    func closeMenuBarView()
}

//FIXME: in MenuPropertyCell
protocol MenuPropertyCellDelegate {
    func deleteBtnClickWithCell(cell: UICollectionViewCell)
}

