//
//  Utils.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/13.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit
import YYKit

class Utils {

    static func handle_TagString(_ originStr: String, fontSize: CGFloat) -> NSAttributedString {
        let needHandleStr = originStr
        var mAttrStr = NSAttributedString(string: needHandleStr)
        
        //TODO:
//        mAttrStr.setFont(UIFont.systemFontSize(fontSize))
//        mAttrStr.setColor(UIColor.black, range: mAttrStr.rangeOfAll())
        
        return mAttrStr
    }
    
    static func fixedLocalMenuNames() -> [String] {
        let fixedLocalTokens = ["开源资讯", "推荐博客", "技术问答", "每日一搏"]
     
        return fixedLocalTokens
    }
    
    static func allSelectedMenuNames() -> [String] {
        let chooseItemTokens = self.allSelectedMenuTokens()
//        let allChooseMenuItems = [self conversionMenuItemsWithMenuTokens:chooseItemTokens]; //[OSCMenuItem]
//        var allNames = [String]()
//        for curItem in allChooseMenuItems {
//            allNames.append(curItem.name)
//        }
//        return allNames
        return chooseItemTokens
    }
    
    
    static func allUnselectedMenuNames() -> [String] {
        return ["1", "2", "3", "4", "5", "6", "7"]
    }
    
    static func allSelectedMenuTokens() -> [String] {
        return ["new", "temp", "todo"]
    }
}
