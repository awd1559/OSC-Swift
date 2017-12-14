//
//  OSCInformationListCollectionViewController.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/14.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit

protocol InformationListCollectionDelegate {
    func ScrollViewDidEndWithIndex(index:Int)
}

class OSCInformationListCollectionViewController: UICollectionViewController {
    var informationListCollectionDelegate: InformationListCollectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let todo = UILabel()
        todo.text = "this infomation list todo"
        self.view.addSubview(todo)
    }
}
