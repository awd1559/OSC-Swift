//
//  Config.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/11.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit
import Foundation

let kUserID = "userID"

class Config {
    static func getOwnID() -> Int {
        return UserDefaults.standard.integer(forKey: kUserID)
    }
}
