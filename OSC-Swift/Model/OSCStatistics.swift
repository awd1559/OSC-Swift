//
//  OSCStatistics.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/16.
//  Copyright © 2017年 awd. All rights reserved.
//

import ObjectMapper

struct OSCStatistics:  Mappable{
    init(){}
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        comment  <- map["comment"]
        favCount <- map["favCount"]
        like <- map["like"]
        transmit <- map["transmit"]
        view <- map["view"]
    }
    // : NSObject <NSMutableCopying>

    var comment: Int = 0

    var view: Int = 0

    var like: Int = 0

    var transmit: Int = 0

    var favCount: Int = 0

}

