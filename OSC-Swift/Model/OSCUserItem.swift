//
//  OSCUserItem.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/16.
//  Copyright © 2017年 awd. All rights reserved.
//

struct OSCUserStatistics {

    var follow: Int

    var score: Int

    var answer: Int

    var collect: Int

    var tweet: Int

    var discuss: Int

    var fans: Int

    var blog: Int

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

struct OSCUserIdentity {
    var officialMember: Bool
    var softwareAuthor: Bool
}
