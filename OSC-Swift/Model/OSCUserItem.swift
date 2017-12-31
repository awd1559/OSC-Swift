//
//  OSCUserItem.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/16.
//  Copyright © 2017年 awd. All rights reserved.
//

import ObjectMapper

struct OSCUserStatistics {

    var follow: Int = 0

    var score: Int = 0

    var answer: Int = 0

    var collect: Int = 0

    var tweet: Int = 0

    var discuss: Int = 0

    var fans: Int = 0

    var blog: Int = 0
}


struct OSCUserMoreInfo {

    var expertise: String

    var joinDate: String

    var province: String

    var city: String

    var platform: String

    var company: String

    var position: String

    var skill: [String]//技能

    var field: [String]//领域

}


/* 活动出席人员节点 */
struct OSCUserEventInfo {
    var name: String
    var company: String
    var job: String
}

struct OSCUserIdentity: Mappable {
    init() {}
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        officialMember <- map["officialMember"]
        softwareAuthor <- map["softwareAuthor"]
    }
    
    var officialMember: Bool = false
    var softwareAuthor: Bool = false
}
