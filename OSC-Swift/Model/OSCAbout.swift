//
//  OSCAbout.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/16.
//  Copyright © 2017年 awd. All rights reserved.
//

struct OSCAbout {// : NSObject <NSMutableCopying>

    var id: Int

    var title: String

    var content: String

    var type: InformationType

    var statistics: OSCStatistics

    var href: String

    var images: [OSCNetImage]

/** 以下是布局信息*/
    var  titleLabelFrame: CGRect///< 非动弹转发 用到

    var contectTextViewFrame: CGRect///< 非动弹转发 动弹转发 用到

    var imageFrame: CGRect///< 动弹转发(单图) 用到

    var  forwardingMultipleFrame: MultipleImageViewFrame///< 动弹转发(多图) 用到

    var viewHeight: Float
}
