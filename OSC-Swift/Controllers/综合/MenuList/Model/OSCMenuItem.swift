//
//  OSCMenuItem.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/14.
//  Copyright © 2017年 awd. All rights reserved.
//

import Foundation

struct OSCMenuItem {
    var token: String = ""
    
    var name: String = ""
    
    var fixed: Bool = false
    
    var needLogin: Bool = false
    
    var tag: String = ""
    
    var type: InformationType = .linknews
    
    var subtype: String = ""
    
    var order: Int = 0
    
    var href: String = ""
    
    var banner: OSCMenuItem_Banner = OSCMenuItem_Banner()
}

struct OSCMenuItem_Banner {
    var catalog: OSCInformationListBannerType = .none
    var href: String = ""
}

/**
 {
 "token":"1a320f65e0de3f3d5e2b",
 "name":"栏目名称",
 "fixed":true,
 "needLogin":true,
 "tag":"hot",
 "type":1,
 "subtype":1,
 "order":2,
 "href":"https://www.oschina.net/action/apiv2/sub_list?token=1a320f65e0de3f3d5e2b",
 "banner":{
 "catalog":1,
 "href":"https://www.oschina.net/action/apiv2/banner?catalog=1"
 }
 }
 */

