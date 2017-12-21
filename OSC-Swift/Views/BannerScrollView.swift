//
//  BannerScrollView.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/21.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit


struct OSCBannerModel {

    var title: String

    var netImagePath: String

    var localImageData: NSData?

}


class BannerScrollView: UIView {
    var banners: [OSCBannerModel]?
}
