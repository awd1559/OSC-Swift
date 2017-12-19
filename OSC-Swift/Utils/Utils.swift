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
    
    static func getAppToken() -> String {
        #if DEBUG
            return Debug_App_Token
        #else
            let defaults = UserDefaults.standard
            let key = "token_key_\(Application_BundleID)\(Application_BuildNumber)"
            let value = defaults.objectForKey(key)
            if let value = vlaue {
                var array = [Application_BuildNumber, Application_Version, App_Token_Key]
                let value = Utils.sha1(array, componentsJoinedByString: "-")
                defaults.set(value, forKey: key)
                defaults.synchronize()
                return self.getAppToken()
            } else {
                return value
            }
        #endif
    }

    static func handle_TagString(_ originStr: String, fontSize: CGFloat) -> NSAttributedString {
        let needHandleStr = originStr
        var mAttrStr = NSAttributedString(string: needHandleStr)
        
        //TODO:
//        mAttrStr.setFont(UIFont.systemFontSize(fontSize))
//        mAttrStr.setColor(UIColor.black, range: mAttrStr.rangeOfAll())
        
        return mAttrStr
    }

    static func buildinMenuNames() -> [String] {
        let fixedLocalTokens = ["开源资讯", "推荐博客", "技术问答", "每日一搏"]
     
        return fixedLocalTokens
    }
    
    static func buildinMenuTokens() -> [String] {
        return [
            "d6112fa662bc4bf21084670a857fbd20",//开源资讯
            "df985be3c5d5449f8dfb47e06e098ef9",//推荐博客
            "98d04eb58a1d12b75d254deecbc83790",//技术问答
            "1abf09a23a87442184c2f9bf9dc29e35",//每日一搏
        ]
    }
    
    static func allMenuNames() -> [String] {
        return [
            "开源资讯",
            "推荐博客",
            "技术问答",
            "每日一搏"
        ]
    }
    
    static func allMenuTokens() -> [String] {
        let items = self.allMenuItems()
        var tokens = [String]()
        for item in items {
            tokens.append(item.token)
        }
        return tokens
    }

    static func selectedMenuNames() -> [String] {
        let menuItems = self.allMenuItems()
        var names = [String]()
        for item in menuItems {
            names.append(item.name)
        }
        return names
    }
    
    static func selectedMenuTokens() -> [String] {
        var mutableChooseItemTokens = UserDefaults.standard.array(forKey: kUserDefaults_ChooseMenus) as! Array<String>
        var allTokens = self.allMenuTokens()
        
        if mutableChooseItemTokens.count == 0 {
            mutableChooseItemTokens = self.buildinMenuTokens()
            self.updateUserSelectedMenuList(tokens: mutableChooseItemTokens)
        }
        
        var deleteFixedLocalTokens = [String]()
        deleteFixedLocalTokens.reserveCapacity(mutableChooseItemTokens.count)
        let fixedLocalTokens = self.buildinMenuTokens()
        for menuToken in mutableChooseItemTokens {/** 去除fixed分栏 */
            if !fixedLocalTokens.contains(menuToken) {
                deleteFixedLocalTokens.append(menuToken)
            }
        }
        
        mutableChooseItemTokens = deleteFixedLocalTokens
        var resultMuatbleArray = [String]()
        resultMuatbleArray.reserveCapacity(mutableChooseItemTokens.count)
        for menuToken in mutableChooseItemTokens {/** 去除不合法分栏 */
            if allTokens.contains(menuToken) {
                resultMuatbleArray.append(menuToken)
            }
        }
        
        mutableChooseItemTokens = resultMuatbleArray
        self.updateUserSelectedMenuList(tokens: mutableChooseItemTokens)
        return mutableChooseItemTokens
    }
    
    static func unselectedMenuNames() -> [String] {
        let chooseItemTokens = self.selectedMenuTokens()
        var allChooseMenuItems = self.menuItems(tokens: chooseItemTokens)
        var allNames = [String]()
        for item in allChooseMenuItems {
            allNames.append(item.name)
        }
        return allNames
    }
    
    static func unselectedMenuTokens() -> [String] {
        let allTokens = self.allMenuTokens()
        let allSelectedMenuTokens = self.selectedMenuTokens()
        
        var unselectedTokens = [String]()
        for token in allTokens {
            if !allSelectedMenuTokens.contains(token) {
                unselectedTokens.append(token)
            }
        }
        var deleteFixedLocalTokens = [String]()
        deleteFixedLocalTokens.reserveCapacity(unselectedTokens.count)
        let fixedLocalTokens = self.buildinMenuTokens()
        
        for menuToken in unselectedTokens {/** 去除fixed分栏 */
            if !fixedLocalTokens.contains(menuToken) {
                deleteFixedLocalTokens.append(menuToken)
            }
        }
        unselectedTokens = deleteFixedLocalTokens
        
        return unselectedTokens
    }

    static func allMenuItems() -> [OSCMenuItem] {
        let fileUrl = R.file.subMenuItemsPlist()
        let localMenusArr = NSArray(contentsOf: fileUrl!)
        var menuItems = [OSCMenuItem]()
        for arrItem in (localMenusArr?.enumerated())! {
            let dict = arrItem.element as! [String: Any]
            var item = OSCMenuItem()
            item.name = dict["name"] as! String
            //TODO: more property as long as name
            
            menuItems.append(item)
        }
        return menuItems
    }
    
    static func menuItems(names:[String]) -> [OSCMenuItem] {
        let allMenuItems = self.allMenuItems()
        var menuItems = [OSCMenuItem]()
        var allNames = [String]()
        for item in allMenuItems {
            allNames.append(item.name)
        }
        
        for name in names {
            let index = allNames.index(of: name)
            if let index = index {
                let item = allMenuItems[index]
                menuItems.append(item)
            }
        }
        return menuItems
    }
    
    static func menuItems(tokens:[String]) -> [OSCMenuItem] {
        let allMenuItems = self.allMenuItems()
        var menuItems = [OSCMenuItem]()
        var allTokens = [String]()
        for item in allMenuItems {
            allTokens.append(item.token)
        }
        
        for token in tokens {
            let index = allTokens.index(of: token)
            if let index = index {
                let item = allMenuItems[index]
                menuItems.append(item)
            }
        }
        return menuItems
    }
    
    static func menuNames(_ items: [OSCMenuItem]) -> [String] {
        var names = [String]()
        for item in items {
            names.append(item.name)
        }
        return names
    }
    
    static func menuTokens(_ items: [OSCMenuItem]) -> [String] {
        var tokens = [String]()
        for item in items {
            tokens.append(item.token)
        }
        return tokens
    }
    
    static func updateSelectedMenuList(_ items: [OSCMenuItem]) {
        let tokens = self.menuTokens(items)
        self.updateUserSelectedMenuList(tokens: tokens)
    }
    
    static func updateUserSelectedMenuList(tokens: [String]) {
        UserDefaults.standard.set(tokens, forKey: kUserDefaults_ChooseMenus)
        UserDefaults.standard.synchronize()
    }
    
    static func updateUserSelectedMenuList(names: [String]) {
        let items = self.menuItems(names: names)
        let tokens = self.menuTokens(items)
        self.updateUserSelectedMenuList(tokens: tokens)
    }
}
