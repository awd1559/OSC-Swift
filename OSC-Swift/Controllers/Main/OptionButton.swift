//
//  OptionButton.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/13.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit
import SnapKit

class OptionButton: UIView {
    var button = UIView()
    var titleLabel = UILabel()
    var imageView = UIImageView()
    
    init(title: String, image: UIImage, color: UIColor) {
        super.init(frame: CGRect())
        
        button.backgroundColor = color
        
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(imageView)
        
        titleLabel.textColor = UIColor(hex: 0x666666)
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.text = title
        
        self.addSubview(button)
        self.addSubview(titleLabel)
        
        self.setLayout()
        
    }
    
    fileprivate func setLayout() {
       for view in self.subviews {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        button.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
            make.bottom.equalTo(titleLabel.snp.top).offset(8)
            make.trailing.equalToSuperview().offset(8)
        }
        
        titleLabel.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(8)
        }
        
        imageView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(15)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
