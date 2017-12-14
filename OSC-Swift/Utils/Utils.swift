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
}
