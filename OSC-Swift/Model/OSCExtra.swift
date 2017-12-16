//
//  OSCExtra.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/15.
//  Copyright © 2017年 awd. All rights reserved.
//


struct OSCExtra {

/** 活动相关 额外参数*/
    var eventStartDate: String

    var eventEndDate: String

    var eventApplyCount: Int

    var eventApplyStatus: ApplyStatus

    var eventStatus: ActivityStatus

    var eventType: ActivityType

    var eventLocation: String

    var eventProvince: String
    var eventCity: String
    var eventSpot: String

    var eventCostDesc: String


/** 翻译相关 额外参数*/
    var translationTitle: String


/** 博客相关 额外参数*/
    var blogCategory: String

    var blogPayNotify: String


/** 软件相关 额外参数*/
    var softwareLicense: String
    var softwareHomePage: String
    var softwareDocument: String
    var softwareDownload: String

    var softwareLanguage: String
    var softwareSupportOS: String
    var softwareCollectionDate: String
    var softwareIdentification: String

    var softwareName: String
    var softwareStar: Int
    var softwareScore: Int
    var softwareTitle: String

}
