//
//  UIColor+ext.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/13.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: Int) {
        self.init(hex:hex, alpha: 1.0)
    }
    
    convenience init(hex: Int, alpha: Float) {
        let r = ((Float) ((hex & 0xFF0000) >> 16) ) / 255.0
        let g = ((Float) ((hex & 0xFF00) >> 8) ) / 255.0
        let b = ((Float) ((hex & 0xFF)) ) / 255.0
        
        self.init(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: CGFloat(alpha))
    }
}
