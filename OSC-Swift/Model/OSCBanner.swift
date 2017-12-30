//
//  OSCBanner.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/15.
//  Copyright © 2017年 awd. All rights reserved.
//
import ObjectMapper

struct OSCBanner : Mappable{

    var name: String = ""

    var detail: String = ""

    var img: String = ""

    var href: String = ""

    var type: InformationType = .linknews

    var id: Int = 0

    var time: String = ""
    
    mutating func mapping(map: Map) {
        detail <- map["detail"]
        href <- map["href"]
        id <- map["id"]
        img <- map["img"]
        name <- map["name"]
        //        pubDate <- map[""]
        type <- map["type"]
    }
    
    init() {}
    init?(map: Map) {
    }
}
