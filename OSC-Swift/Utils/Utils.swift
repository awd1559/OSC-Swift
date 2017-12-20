//
//  Utils.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/13.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit
import YYKit
import MBProgressHUD

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
//        mAttrStr.setColor(UIColor.black, rang: mAttrStr.rangeOfAll())
        
        return mAttrStr
    }
    
    static func createImageWithColor(_ color: UIColor) -> UIImage {
        let rect=CGRect(x:0, y:0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return theImage!
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
        let menuTokens = self.selectedMenuTokens()
        let menuItems = self.menuItems(tokens: menuTokens)
        
        var names = [String]()
        for item in menuItems {
            names.append(item.name)
        }
        return names
    }
    
    static func selectedMenuTokens() -> [String] {
        let allTokens = self.allMenuTokens()
        var chooseTokens = [String]()
        if let m = UserDefaults.standard.array(forKey: kUserDefaults_ChooseMenus) {
            chooseTokens = m as! [String]
        }
        if chooseTokens.count == 0 {
            chooseTokens = self.buildinMenuTokens()
            self.updateSelectedMenuList(tokens: chooseTokens)
        }
        
        var result = [String]()
        result.reserveCapacity(chooseTokens.count)
        let buildinTokens = self.buildinMenuTokens()
        for choose in chooseTokens {/** 去除buildin tokens分栏 */
            if !buildinTokens.contains(choose) {
                result.append(choose)
            }
        }
        chooseTokens = result
        
        result = []
        result.reserveCapacity(chooseTokens.count)
        for choose in chooseTokens {/** 去除不合法分栏 */
            if allTokens.contains(choose) {
                result.append(choose)
            }
        }
        
        chooseTokens = result
        self.updateSelectedMenuList(tokens: chooseTokens)
        return chooseTokens
    }
    
    static func unselectedMenuNames() -> [String] {
        let chooseTokens = self.unselectedMenuTokens()
        let chooseItems = self.menuItems(tokens: chooseTokens)
        var names = [String]()
        for item in chooseItems {
            names.append(item.name)
        }
        return names
    }
    
    static func unselectedMenuTokens() -> [String] {
        let allTokens = self.allMenuTokens()
        let selectedTokens = self.selectedMenuTokens()
        
        var unselectedTokens = [String]()
        for token in allTokens {
            if !selectedTokens.contains(token) {
                unselectedTokens.append(token)
            }
        }
        var result = [String]()
        result.reserveCapacity(unselectedTokens.count)
        let buildinTokens = self.buildinMenuTokens()
        
        for menuToken in unselectedTokens {/** 去除build in分栏 */
            if !buildinTokens.contains(menuToken) {
                result.append(menuToken)
            }
        }
        unselectedTokens = result
        
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
        self.updateSelectedMenuList(tokens: tokens)
    }
    
    static func updateSelectedMenuList(tokens: [String]) {
        UserDefaults.standard.set(tokens, forKey: kUserDefaults_ChooseMenus)
        UserDefaults.standard.synchronize()
    }
    
    static func updateSelectedMenuList(names: [String]) {
        let items = self.menuItems(names: names)
        let tokens = self.menuTokens(items)
        self.updateSelectedMenuList(tokens: tokens)
    }
    
    static func createHUD() -> MBProgressHUD {
        let keyWindow = UIApplication.shared.keyWindow
        let HUD = MBProgressHUD(view: keyWindow!)
        HUD.detailsLabel.font = UIFont.boldSystemFont(ofSize: 16)
        keyWindow?.addSubview(HUD)
        HUD.show(animated: true)
        HUD.removeFromSuperViewOnHide = true
        return HUD
    }
}
