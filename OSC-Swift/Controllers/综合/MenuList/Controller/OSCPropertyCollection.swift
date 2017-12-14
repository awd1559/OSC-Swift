//
//  OSCPropertyCollection.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/14.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit

protocol OSCPropertyCollectionDelegate {
    func clickCellWithIndex(index: Int)
    func beginEdit()
}

class OSCPropertyCollection: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let todo = UILabel()
        todo.text = "property collection sorting"
        self.view.addSubview(todo)
    }
    
    func changeStateWithEdit(isEditing: Bool) {
        
    }
}
