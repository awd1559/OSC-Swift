//
//  NewLoginViewController.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/12.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit
import SnapKit

class NewLoginViewController: UIViewController {
    private func _initviews() {
        //easy to write
        //good for id check
        //very hard to understand
        //can not view on different devices
        //BAD !!!
        //use storyboard
        let bg_login = UIImageView(image: R.image.bg_login())
        self.view.addSubview(bg_login)
        bg_login.snp.makeConstraints{ make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.trailing.equalToSuperview()
        }
        
        let logo = UIImageView(image: R.image.logo_osc())
        self.view.addSubview(logo)
        logo.snp.makeConstraints{ make in
            make.width.equalTo(166)
            make.height.equalTo(54)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(77)
            make.centerX.equalToSuperview()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _initviews()
    }
}
