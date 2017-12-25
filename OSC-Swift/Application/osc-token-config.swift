//
//  osc-token-config.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/15.
//  Copyright © 2017年 awd. All rights reserved.
//


let App_Token_Key   = "6c799b31900377884ac4517d73b4503d52b34c1e"

let Debug_App_Token = "6c799b31900377884ac4517d73b4503d52b34c1e"

let Reading_Collect_Tiken = "oschina"


//prefix.pch
/** 根据此Key取得的是已选的menuItem的Token数组 */
let kUserDefaults_ChooseMenus  = "UserDefaultsChooseMenus"
let kUserDefaults_AppVersion   = "UserDefaultsAppVersion"

/** AppToken 通过请求头传递 */
let Application_BundleID = Bundle.main.infoDictionary?["CFBundleIdentifier"]
let Application_BuildNumber = Bundle.main.infoDictionary?["CFBundleVersion"]
let Application_Version = Bundle.main.infoDictionary?["CFBundleShortVersionString"]


