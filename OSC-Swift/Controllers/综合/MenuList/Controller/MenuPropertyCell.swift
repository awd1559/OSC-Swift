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
    func deleteBtnClick(at cell: UICollectionViewCell)
}


class MenuPropertyCell : UICollectionViewCell {
    var isUnable = false
    var cellType: CellType = .nomal
    var delegate: MenuPropertyCellDelegate?
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.frame = self.contentView.bounds
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(hex: 0x6a6a6a)
        label.textAlignment = .center
        label.layer.cornerRadius = self.contentView.bounds.size.height / 2
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        label.layer.masksToBounds = true
        return label
    }()
    var deleteBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x:0, y:0, width:28, height:28)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 14, 14);
        button.setImage(R.image.ic_unsubscribe(), for: .normal)
        button.isHidden = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(titleLabel)
        deleteBtn.addTarget(self, action:#selector(deleteClick), for:.touchUpInside)
        self.contentView.addSubview(deleteBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func deleteClick(sender: UIButton) {
        if let delegate = self.delegate {
            delegate.deleteBtnClick(at: self)
        }
    }
    
    func beginEditing() {
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation")
        animation.duration = 0.2
        animation.isRemovedOnCompletion = true
        animation.fillMode = kCAFillModeForwards
        animation.repeatCount = Float(MAX_CANON)
        let direction: Int = Int(arc4random() % 2)
        if direction == 0 {
            animation.values = [0, Double.pi / 90, 0, Double.pi / 90, 0]
        } else {
            animation.values = [0, Double.pi / 90, 0, Double.pi / 90, 0]
        }
        self.layer.add(animation, forKey:"animation")
        deleteBtn.isHidden = false
    }
    
    func endEditing() {
        self.layer.removeAnimation(forKey: "animation")
        deleteBtn.isHidden = true
    }
    
    func setCellType(_ cellType: CellType, isUnable:Bool) {
        self.isUnable = isUnable
        self.cellType = cellType
        switch cellType {
        case .nomal:
            titleLabel.textColor = UIColor(hex:0x111111)
            if !isUnable {
                titleLabel.layer.borderColor = UIColor(hex:0xcdcdcd).cgColor
            }else{
                titleLabel.layer.borderColor = UIColor(red:205/225.0, green:205/225.0, blue:205/225.0, alpha:0.4).cgColor
                titleLabel.backgroundColor = UIColor.clear
            }
        case .select:
            titleLabel.layer.borderColor = UIColor.navigationbarColor().cgColor
            titleLabel.textColor = UIColor.navigationbarColor()
            if isUnable {
                titleLabel.backgroundColor = UIColor.clear
            }
        case .second:
            titleLabel.textColor = UIColor(hex:0x111111)
            titleLabel.layer.borderColor = UIColor(hex:0xcdcdcd).cgColor
        default:
            break
        }
    }
    
    func getType() -> CellType {
        return cellType
    }
}
