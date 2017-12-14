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
    
    //TODO: - make the R.color
    static func themeColor() -> UIColor {
        return UIColor(hex:0xebebf3)
    }
    
    static func nameColor() -> UIColor {
        return UIColor(hex:0x087221)
    }
    
    static func titleColor() -> UIColor {
        return UIColor.black
    }
    
    static func separatorColor() -> UIColor {
        return UIColor(hex:0xC8C7CC)
    }
    
    static func cellsColor() -> UIColor {
        return UIColor.white
    }
    
    static func titleBarColor() -> UIColor {
        return UIColor(hex:0xf6f6f6)
    }
    
    static func contentTextColor() -> UIColor {
        return UIColor(hex:0x272727)
    }
    
    static func selectTitleBarColor() -> UIColor {
        return UIColor(hex:0xE1E1E1)
    }
    
    static func navigationbarColor() -> UIColor {
        return UIColor(hex:0x24cf5f)
    }
    
    static func selectCellSColor() -> UIColor {
        return UIColor(hex: 0xfcfcfc)
    }
    
    static func labelTextColor() -> UIColor {
        return UIColor.white
    }
    
    static func teamButtonColor() -> UIColor {
        return UIColor(hex: 0xfbfbfd)
    }
    
    static func infosBackViewColor() -> UIColor {
        return UIColor.clear
    }
    
    static func lineColor() -> UIColor {
        return UIColor(hex: 0x2bc157)
    }
    
    static func borderColor() -> UIColor {
        return UIColor.lightGray
    }
    
    static func refreshControlColor() -> UIColor {
        return UIColor(hex: 0x21B04B)
    }
    
    static func newCellColor() -> UIColor {
        return UIColor(hex: 0xffffff)
    }
    
    static func newTitleColor() -> UIColor {
        return UIColor(hex: 0x111111)
    }
    
    static func newSectionButtonSelectedColor() -> UIColor {
        return UIColor(hex: 0x24CF5F)
    }
    
    static func newSeparatorColor() -> UIColor {
        return UIColor(hex: 0xC8C7CC)
    }
    
    static func newSecondTextColor() -> UIColor {
        return UIColor(hex: 0x6A6A6A)
    }
    
    static func newAssistTextColor() -> UIColor {
        return UIColor(hex: 0x9D9D9D)
    }
    
}
