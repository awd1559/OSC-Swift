//
//  enumList.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/15.
//  Copyright © 2017年 awd. All rights reserved.
//


enum InformationType: Int {
    case linknews = 0//链接新闻
    case software = 1//软件推荐
    case forum = 2//讨论区帖子（问答）
    case blog = 3//博客
    case translation = 4//翻译文章
    case activity = 5//活动类型
    case info = 6//资讯
    case linknewstwo = 7
    
    case usercenter = 11//用户中心
    
    case tweet = 100//动弹（评论）类型
}

enum UserGenderType: Int {
    case unknown = 0//未知
    case man, woman
}

enum UserRelationStatus: Int {
    case mutual = 1//双方互为粉丝
    case sself = 2//你单方面关注他
    case other = 3//他单方面关注我
    case none = 4 //互不关注
}

enum CommentStatusType: Int {
    case none = 0//none
    case like = 1 //已顶
    case nlike = 2 //已踩
}

enum ActivityStatus: Int {
    case end = 1// 活动已经结束
    case haveInHand, //活动进行中
    lose//活动报名已经截止
}

enum ActivityType: Int {
    case meeting = 1//源创会
    case technical,//技术交流
     other,// 其他
     below//站外活动(当为站外活动的时候，href为站外活动报名地址)
}

enum ApplyStatus: Int {
    case signup = -1//未报名
    case audited = 0//审核中
    case determined = 1//已经确认
    case attended,//已经出席
     canceled,//已取消
     rejected//已拒绝
}

enum OSCInformationListBannerType: Int {
    case none = 0//没有banner
    case simple = 1//通用banner (UIImageView显示图片 + UILabel显示title)
    case simpleblogs = 2//自定义banner (用于blog列表展示)
    case customactivity = 3//自定义banner (用于activity列表展示)
}

let kTopicRecommedTweetImageArray = ["bg_topic_1", "bg_topic_2", "bg_topic_3", "bg_topic_4", "bg_topic_5"]

enum TopicRecommedTweetType: Int {
    case first = 0
    case second = 1
    case third = 2
    case forth = 3
    case fifth = 4
}

/** 机型设备信息 用DeviceResolution作为下标访问*/
let kDeviceArray = ["iPhone_4","iPhone_4s","iPhone_5","iPhone_5c","iPhone_5s","iPhone_6","iPhone_6p","iPhone_6s","iPhone_6sp","iPhone_se","iPhone_7","iPhone_7p","Simulator"]

enum DeviceResolution: Int {
    case iPhone_4 = 0
    case iPhone_4s    ,
     iPhone_5     ,
     iPhone_5c    ,
     iPhone_5s    ,
     iPhone_6     ,
     iPhone_6p    ,
     iPhone_6s    ,
     iPhone_6sp   ,
     iPhone_se    ,
     iPhone_7     ,
     iPhone_7p    ,
     Simulator
}

enum SystemVersion: Int {
    case iOS7 = 0
    case iOS8        ,
     iOS9        ,
     iOS10       ,
     noSupport
}

enum AppClientType: Int {
    case phone         = 2//手机
    case android       = 3//Android
    case iPhone        = 4//iPhone
    case windowsPhone  = 5//Windows Phone
    case weChat        = 6//WeChat
}

enum EventApplyPreloadKeyType: Int { //活动报名预拉取字段提交类型
    case string = 0
    case int = 1
}

enum EventApplyPreloadFormType: Int {//活动报名预拉取界面渲染的样式
    case ddefault = -1
    case text = 0
    case textarea,  //备注等多行输入框
    select,//选择
    checkbox,//多选框
    radio,//单选框
    email,
    date,
    mobile,
    number,
    url
}

enum MsgCountType: Int {
    case mention = 1// 1 << 0,
    case letter  = 2// << 1,
    case review  = 3// << 2,
    case fans    = 4// << 3,
    case like    = 5// << 4,
    
    case all     = 6// << 5,
}

/**
 mention    :   @数量
 letter     :   私信数量
 review     :   回复数量
 fans       :   粉丝数量
 like       :   赞数量
 */

