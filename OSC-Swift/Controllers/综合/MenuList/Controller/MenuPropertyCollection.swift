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

fileprivate let kCellWidth: CGFloat = 80.0
fileprivate let kCellHeight: CGFloat = 30.0
fileprivate let kHeaderKind = UICollectionElementKindSectionHeader

protocol MenuPropertyDelegate {
    func clickPropertyItem(at index: Int)
    func propertyCollectionBeginEdit()
}


class MenuPropertyCollection: UICollectionView {
    var menuPropertyDelegate: MenuPropertyDelegate?
    var isEditing: Bool = false
    var index: Int = 0 {
        didSet {
            self.reloadData()
        }
    }
    var selectTitle: [String]?
    var unSelectTitle: [String]?
    var pressToMove: UILongPressGestureRecognizer = {
        let rec = UILongPressGestureRecognizer()
        rec.minimumPressDuration = 0.1;
        return rec
    }()
    var pressToEdit: UILongPressGestureRecognizer = {
        let rec = UILongPressGestureRecognizer()
        rec.minimumPressDuration = 1
        return rec
    }()
    var moveCell: MenuPropertyCell?
    
    init(frame: CGRect) {
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
        self.register(UICollectionReusableView.self, forSupplementaryViewOfKind: kHeaderKind, withReuseIdentifier: headerID)
        
        let buildinMenuNames = Utils.buildinMenuNames()
        let selectedMenuNames = Utils.selectedMenuNames()
        self.selectTitle = buildinMenuNames
        self.selectTitle?.append(contentsOf: selectedMenuNames)
        self.unSelectTitle = Utils.unselectedMenuNames()
        self.alwaysBounceVertical = true
        
        pressToMove.addTarget(self, action: #selector(pressToMoveAction))
        pressToEdit.addTarget(self, action: #selector(pressToEditAction))
        self.addGestureRecognizer(pressToEdit)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func pressToEditAction(longPress: UILongPressGestureRecognizer) {
        if longPress.state == .began {
            self.isEditing = true
            self.reload()
            self.menuPropertyDelegate?.propertyCollectionBeginEdit()
        }
    }

    @objc func pressToMoveAction(longgr: UILongPressGestureRecognizer) {
        switch longgr.state {
        case .began:
            let indexPath = self.indexPathForItem(at: longgr.location(in: self))
            if indexPath!.row > 3 {
                moveCell = self.cellForItem(at: indexPath!) as? MenuPropertyCell
                if let moveCell = moveCell {
                    moveCell.stopEdit()
                    self.beginInteractiveMovementForItem(at: indexPath!)
                    UIView.animate(withDuration: 0.2) {
                        moveCell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                        moveCell.alpha = 0.8
                    }
                }
            }
        case .changed:
            let point = longgr.location(in: self)
            let positionPoint = CGPoint(x: point.x - kCellWidth * 0.3, y: point.y - kCellHeight * 0.3)
            let rectOfCurrent = CGRect(x: positionPoint.x, y: positionPoint.y, width: kCellWidth*0.6, height: kCellHeight*0.6)
            var isNull = false
            for i in 0..<4 {
                let rectOfCell = self.cellForItem(at: IndexPath(row:i, section: 0))?.frame
                if rectOfCurrent.intersection(rectOfCell!).isNull {
                    isNull = true
                    break
                }
            }
            
            if isNull {
                self.updateInteractiveMovementTargetPosition(longgr.location(in: self))
            } else {
                self.endInteractiveMovement()
                UIView.animate(withDuration: 0.3) {
                    self.moveCell?.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self.moveCell?.alpha = 1
                }
                moveCell?.startEdit()
            }
            if let moveCell = self.moveCell {
                moveCell.alpha = 0.8
                moveCell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }
        default:
            if let moveCell = self.moveCell {
                self.endInteractiveMovement()
                UIView.animate(withDuration: 0.3) {
                    moveCell.transform = CGAffineTransform(scaleX: 1, y: 1)
                    moveCell.alpha = 1
                }
                moveCell.startEdit()
            }
        }
    }
    
    func reload() {
        let indexSet = IndexSet(integer: 1)
        self.reloadSections(indexSet)
        for i in 0..<selectTitle!.count {
            let indexPath = IndexPath(row: i, section: 0)
            let cell = self.cellForItem(at: indexPath) as! MenuPropertyCell
            
            if i > 3 {
                if isEditing {
                    cell.startEdit()
                    self.addGestureRecognizer(self.pressToMove)
                    self.removeGestureRecognizer(self.pressToEdit)
                } else {
                    cell.stopEdit()
                    self.removeGestureRecognizer(self.pressToMove)
                    self.addGestureRecognizer(self.pressToEdit)
                }
            }
        }
    }
    
    func startEdit() {
        self.isEditing = true
        self.reload()
    }
    
    func stopEdit() -> [String] {
        self.isEditing = false
        self.reload()
        return selectTitle!
    }
    
    func getSelectedTitles() -> [String] {
        return selectTitle!
    }
    
    func getSelectIdenx() -> Int {
        var result = 0
        for i in 0..<selectTitle!.count {
            let indexPath = IndexPath(row: i, section: 0)
            let cell = self.cellForItem(at: indexPath) as! MenuPropertyCell
            if cell.type == .select {
                result = i
            }
        }
        return result
    }
}


//MARK: - UICollectionViewDataSource
extension MenuPropertyCollection: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return self.selectTitle!.count
        } else {
            if isEditing {
                return 0
            } else {
                return self.unSelectTitle!.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MenuPropertyCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MenuPropertyCell
        cell.stopEdit()

        if indexPath.section == 0 {
            if isEditing && indexPath.row >= 4 {
                cell.startEdit()
            }
            if indexPath.row == index {
                if indexPath.row > 3 {
                    cell.setCellType(.select, withBorder: true)
                } else {
                    cell.setCellType(.select, withBorder: false)
                }
            } else {
                if indexPath.row > 3 {
                    cell.setCellType(.nomal, withBorder: true)
                } else {
                    cell.setCellType(.nomal, withBorder: false)
                }
            }
            cell.title = selectTitle?[indexPath.row]
        } else {
            cell.title = unSelectTitle?[indexPath.row]
            cell.stopEdit()
            cell.setCellType(.second, withBorder:true)
        }
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kHeaderKind, withReuseIdentifier: headerID, for: indexPath)
        
        if kind == kHeaderKind && indexPath.section == 1 && !isEditing {
            headerView.backgroundColor = UIColor(hex: 0xf9f9f9)
            let label = UILabel(frame: CGRect(x: 10, y: 0, width: 200, height: headerView.frame.size.height))
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = UIColor(hex: 0x9d9d9d)
            label.text = "点击添加更多栏目"
            headerView.addSubview(label)
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 || indexPath.row > 3 {
            return true
        }
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let sourceString = selectTitle?[sourceIndexPath.row]
        let index = self.selectTitle?.index(of: sourceString!)
        self.selectTitle?.remove(at: index!)
        self.selectTitle?.insert(sourceString!, at: destinationIndexPath.row)
        Utils.updateSelectedMenuList(names: self.selectTitle!)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MenuPropertyCollection : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: kScreenSize.width, height: 0)
        } else if self.isEditing {
            return CGSize(width: 0, height: 0)
        } else {
            return CGSize(width: kScreenSize.width, height: 40)
        }
    }
}

//MARK: - UICollectionViewDelegate
extension MenuPropertyCollection: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !self.isEditing {
            if indexPath.section == 0 {
                self.menuPropertyDelegate?.clickPropertyItem(at: indexPath.row)
            } else {
                let currentTitle = self.unSelectTitle![indexPath.row]
                unSelectTitle?.remove(at: indexPath.row)
                selectTitle?.append(currentTitle)
                let targetIndexPath = IndexPath(row: (selectTitle?.count)! - 1, section: 0)
                collectionView.moveItem(at: indexPath, to: targetIndexPath)
            }
        }
    }
}


//MARK: - PropertyCellDelegate
extension MenuPropertyCollection : MenuPropertyCellDelegate {
    func deleteCell(_ cell: UICollectionViewCell) {
        let indexPath = self.indexPath(for: cell)
        let index = (indexPath?.row)!
        let currentTitle = self.selectTitle![index]
        self.selectTitle?.remove(at: index)
        self.unSelectTitle?.insert(currentTitle, at: 0)
        Utils.updateSelectedMenuList(names: self.selectTitle!)
        self.deleteItems(at: [indexPath!])
    }
}
