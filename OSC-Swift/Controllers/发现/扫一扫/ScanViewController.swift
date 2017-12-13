//
//  ScanViewController.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/13.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit

class ScanViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let todo = UILabel()
        todo.text = "scan todo"
        self.view.addSubview(todo)
    }
}
