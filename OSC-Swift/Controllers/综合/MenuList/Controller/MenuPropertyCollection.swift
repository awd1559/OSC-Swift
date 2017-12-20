//
//  OSCPropertyCollection.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/14.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit


fileprivate let cellID = "cell"
fileprivate let headerID = "header"
fileprivate let kScreenSize = UIScreen.main.bounds.size
fileprivate let kCellWidth: CGFloat = 80.0
fileprivate let kCellHeight: CGFloat = 30.0

protocol MenuPropertyDelegate {
    func clickPropertyItem(at index: Int)
    func propertyCollectionBeginEdit()
}

class MenuPropertyCollection: UICollectionView {
    var menuPropertyDelegate: MenuPropertyDelegate?
    var isEditing: Bool = false
    var index: Int
    var selectTitle: [String]?
    var unSelectTitle: [String]?
    var longGR: UILongPressGestureRecognizer?
    var pressToEdit: UILongPressGestureRecognizer?
    var moveCell: MenuPropertyCell?
    
    init(frame: CGRect, selectIndex: Int) {
        self.index = selectIndex
        let layout = UICollectionViewFlowLayout()
        var spacing: CGFloat = 11.0
        let count = (kScreenSize.width - kCellWidth - 2.0 * spacing) / 90.0 + 1.0
        let resultSqrt = Int(kScreenSize.width - kCellWidth - 2.0 * spacing)
        let number = resultSqrt % 90
        if number > 0 {
            spacing = (kScreenSize.width - count * kCellWidth) / (count + 1)
        }
        layout.sectionInset = UIEdgeInsetsMake(11, spacing, 11 , spacing)
        layout.minimumLineSpacing = 11
        layout.minimumInteritemSpacing = spacing
        layout.itemSize = CGSize(width: kCellWidth, height: kCellHeight)
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.backgroundColor = UIColor(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1.0)
        self.delegate = self
        self.dataSource = self
        self.register(MenuPropertyCell.self, forCellWithReuseIdentifier: cellID)
        self.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID)
        let fixArray = Utils.buildinMenuNames()
        let selectArray = Utils.selectedMenuNames()
        self.selectTitle = fixArray
        self.selectTitle?.append(contentsOf: selectArray)
        self.unSelectTitle = Utils.unselectedMenuNames()
        self.alwaysBounceVertical = true
        
        self.pressToEdit = UILongPressGestureRecognizer(target: self, action: #selector(pressToEditClick))
        self.pressToEdit?.minimumPressDuration = 1
        self.addGestureRecognizer(pressToEdit!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func pressToEditClick() {
        
    }
    
    func changeStateWithEdit(isEditing: Bool) {
        
    }
    
    func CompleteAllEditings() -> [String] {
        return selectTitle!
    }
    
    func getSelectIdenx() -> Int {
        var index = 0
        for (i, title) in (selectTitle?.enumerated())! {
            let indexPath = IndexPath(row: i, section: 0)
            let cell = self.cellForItem(at: indexPath) as! MenuPropertyCell
            if cell.getType() == .select {
                index = i
            }
        }
        return index
    }
}

//MARK: - UICollectionViewDelegate
extension MenuPropertyCollection: UICollectionViewDelegate {
    
}

//MARK: - UICollectionViewDataSource
extension MenuPropertyCollection: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return self.selectTitle!.count
        }else if isEditing {
            return 0
        }else{
            return self.unSelectTitle!.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MenuPropertyCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MenuPropertyCell
        cell.endEditing()

        if indexPath.section == 0{
            if isEditing && indexPath.row >= 4 {
                cell.beginEditing()
            }
            if indexPath.row == index {
                if indexPath.row > 3 {
                    cell.setCellType(.select, isUnable: false)
                } else {
                    cell.setCellType(.select, isUnable: true)
                }
            } else {
                if indexPath.row > 3 {
                    cell.setCellType(.nomal, isUnable: false)
                } else {
                    cell.setCellType(.nomal, isUnable: true)
                }
            }
            cell.title = selectTitle?[indexPath.row]
        }else{
            cell.title = unSelectTitle?[indexPath.row]
            cell.endEditing()
            cell.setCellType(.second, isUnable:false)
        }
        cell.delegate = self
        return cell
    }
    
    
}

//MARK: - PropertyCellDelegate
extension MenuPropertyCollection : MenuPropertyCellDelegate {
    func deleteBtnClickWithCell(cell: UICollectionViewCell) {
        
    }
}
