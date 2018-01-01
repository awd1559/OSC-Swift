//
//  NSTextAttachment+ext.swift
//  OSC-Swift
//
//  Created by awd on 2018/1/1.
//  Copyright © 2018年 awd. All rights reserved.
//

import Foundation

extension NSTextAttachment {
    func adjustY(_ y: CGFloat)
    {
        self.bounds = CGRect(x:0, y:y, width: self.image!.size.width, height: self.image!.size.height)
    }
}
