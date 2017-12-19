//
//  PropertyCell.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/14.
//  Copyright © 2017年 awd. All rights reserved.
//

import Foundation

//TODO: this is OSCPropertyCollectionViewCell

enum CellType: Int {
    case nomal = 0
    case select, second
}

protocol MenuPropertyCellDelegate {
    func deleteBtnClickWithCell(cell: UICollectionViewCell)
}

class MenuPropertyCell : UICollectionViewCell {
    var title: String?
    var delegate: MenuPropertyCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginEditing() {
    
    }
    
    func endEditing() {
        
    }
    
    func setCellType(_ cellType: CellType, isUnable:Bool) {
        
    }
    
    func getType() -> CellType {
        return .nomal
    }
}
