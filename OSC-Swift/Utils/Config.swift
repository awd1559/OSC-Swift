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
    
    static func getTweetText() -> String {
        let userDefaults = UserDefaults.standard
        let idStr = "tweetTmp_\(Config.getOwnID())"
        
        return userDefaults.object(forKey: idStr) as! String
    }
//    + (NSString *)getTweetText
//    {
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//
//    NSString *IdStr = [NSString stringWithFormat:@"tweetTmp_%ld", (long)[Config getOwnID]];
//    NSString *tweetText = [userDefaults objectForKey:IdStr];
//
//    return tweetText;
//    }
}
