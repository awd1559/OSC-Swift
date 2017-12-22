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

//FIXME: in MenuPropertyCell
protocol MenuCollectionCellDelegate {
    func cell(_ cell: MenuCollectionCell, update dataSourceDic:[String: InfoResultItem])
    
    func cell(_ cell: MenuCollectionCell, onclick tableViewCell: UITableViewCell,  push controller: UIViewController, url: String)
}

extension MenuCollectionCellDelegate {
    //optional
    func cell(_ cell: MenuCollectionCell, onclick banner: UIView, push controller: UIViewController, url:String) {
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

//FIXME: in MenuBarView
protocol MenuBarDelegate {
    func clickAddButton(editing:Bool)
    func clickMenuBarItem(at index: Int)
    func closeMenuBarView()
}

//FIXME: in MenuPropertyCell
protocol MenuPropertyCellDelegate {
    func deleteBtnClickWithCell(cell: UICollectionViewCell)
}

