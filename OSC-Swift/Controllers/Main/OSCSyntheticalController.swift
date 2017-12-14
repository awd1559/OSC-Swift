//
//  OSCSyntheticalController.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/13.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit

fileprivate let kTitleHeigh = 60
fileprivate let kScreenSize = UIScreen.main.bounds.size
fileprivate let kAnimationTime = 0.4

class  OSCSyntheticalController: UIViewController {
    var label = UILabel()
    var editBtn = UIButton()
    var titleView: SyntheticalTitleBarView?
    var collectionView: OSCPropertyCollection?
    var propertyTitleView: UIView?
    var currentIndex = 0
    var informationListController: OSCInformationListCollectionViewController?
    
    var selectArray: [String]?
//    var unSelectArray: []
    
    var bgV: UIView?
    var updateUrl: String?
    var message: String?
    
    //MARK: - lifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.backgroundColor = .red
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBar.isTranslucent = true
        self.tabBarController?.tabBar.isTranslucent = true
        if (collectionView != nil) && (collectionView?.isEditing)! {
            collectionView?.changeStateWithEdit(isEditing: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tabBarController?.tabBar.isTranslucent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isTranslucent = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}

//MARK: - private
extension OSCSyntheticalController {
    func beginRefresh() {
        
    }
}
