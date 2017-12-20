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
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    var delegate: MenuPropertyCellDelegate?
    
    var titleLabel = UILabel()
    var deleteBtn = UIButton(type: .custom)
    var isSelect = false
    var isAble = false
    var cellType: CellType = .nomal
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addContentView() {
        titleLabel.frame = self.contentView.frame
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.textColor = UIColor(hex: 0x6a6a6a)
        titleLabel.textAlignment = .center
        titleLabel.layer.cornerRadius = self.contentView.bounds.size.height / 2
        titleLabel.layer.borderWidth = 1
        titleLabel.layer.borderColor = UIColor.lightGray.cgColor
        titleLabel.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        titleLabel.layer.masksToBounds = true
        self.contentView.addSubview(titleLabel)
        
        deleteBtn.frame = CGRect(x:0, y:0, width:28, height:28)
        deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 14, 14);
        deleteBtn.setImage(R.image.ic_subscribe(), for: .normal)
        deleteBtn.addTarget(self, action:#selector(deleteClick), for:.touchUpInside)
        self.contentView.addSubview(deleteBtn)
        deleteBtn.isHidden = true
    }
    
    @objc func deleteClick(sender: UIButton) {
        
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
