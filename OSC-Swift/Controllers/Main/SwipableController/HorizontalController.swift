//
//  HorizontalController.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/14.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit
//FIXME: this is HorizonalTableViewController

fileprivate let kHorizonalCellID = "HorizonalCell"

class HorizontalController : UITableViewController {
    var currentIndex: Int?
    var controllers: [UIViewController]?
    var changeIndex: ((Int)->Void)?
    var scrollView: ((Float, Int, Int)->Void)?
    var viewDidAppear: ((Int) -> Void)?
    var viewDidScroll: (()->Void)?
    
    
    //MARK: - create
    init(_ viewControllers:[UIViewController]) {
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .none
        self.tableView.scrollsToTop = false
        self.tableView.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2));
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.isPagingEnabled = true
        self.tableView.backgroundColor = UIColor.themeColor()
        self.tableView.bounces = false
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: kHorizonalCellID)
    }
    
   
    
    
    //MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (controllers?.count)!
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.width
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: kHorizonalCellID, for: indexPath)
        cell.contentView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 2))
        cell.contentView.backgroundColor = UIColor.themeColor()
        cell.selectionStyle = .none
        
        let controller = controllers![indexPath.row]
        controller.view.frame = cell.contentView.bounds
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        cell.contentView.addSubview(controller.view)
        
        return cell
    }
    
    //MARK: - UIScrollViewDelegate
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollStop(true)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollStop(false)
        if let viewDidScroll = viewDidScroll {
            viewDidScroll()
        }
    }
}

//MARK: - private
extension HorizontalController {
    func scrollToViewAtIndex(_ index: Int) {
        self.tableView.scroll(toRow: UInt(index), inSection: 0, at: .none, animated: false)
        currentIndex = index
        
        if let viewDidAppear = viewDidAppear {
            viewDidAppear(index)
        }
    }
    
    func scrollStop(_ didScrollStop: Bool) {
        let horizonalOffset: CGFloat = self.tableView.contentOffset.y
        let screenWidth: CGFloat = self.tableView.frame.size.width
        var offsetRatio: CGFloat = horizonalOffset.truncatingRemainder(dividingBy: screenWidth) / screenWidth
        let focusIndex: Int = Int((horizonalOffset + screenWidth / 2) / screenWidth)
        
        if horizonalOffset != CGFloat(focusIndex) * screenWidth {
            let animationIndex: Int = horizonalOffset > CGFloat(focusIndex) * screenWidth ? focusIndex + 1: focusIndex - 1
            if focusIndex > animationIndex {
                offsetRatio = 1 - offsetRatio
            }
            if let scrollView = scrollView {
                scrollView(Float(offsetRatio), focusIndex, animationIndex);
            }
        }
        
        if didScrollStop {
            currentIndex = focusIndex
            if let changeIndex = changeIndex {
                changeIndex(focusIndex)
            }
        }

        
    }
}



