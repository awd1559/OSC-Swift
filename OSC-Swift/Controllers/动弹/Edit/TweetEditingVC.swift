//
//  TweetEditingVC.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/13.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit

class TweetEditingVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let todo = UILabel(frame: self.view.frame)
        todo.text = "tweet editing vc"
        self.view.addSubview(todo)
    }
}
