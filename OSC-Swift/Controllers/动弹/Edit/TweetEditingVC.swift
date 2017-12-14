//
//  TweetEditingVC.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/13.
//  Copyright © 2017年 awd. All rights reserved.
//

import Foundation
import UIKit
import YYKit

class TweetEditingVC: UIViewController {
    //MARK: - property
    var isTeamTweet = false
    var images = [UIImage]()
    var imageToken = ""
    var imageIndex = 0
    var failCount = 0
    var isGotTweetAddImage = false
    var isAddImage = false
    var itemImageArr : [OSCPhotoGroupItem] = {
        var array = [OSCPhotoGroupItem]()
        array.reserveCapacity(9)
        return array
    }()
    var imagesData : [NSData] = {
        var array = [NSData]()
        array.reserveCapacity(9)
        return array
    }()
    var edittingArea = YYTextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "弹一弹"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self,
                                                                action: #selector(cancelButtonClicked))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .plain, target: self,
                                                                 action: #selector(pubTweet))

        self.view.backgroundColor = UIColor.white
        self.initSubViews()
        self.setlayout()
        if !edittingArea.isFirstResponder {
            edittingArea.becomeFirstResponder()
        }
        
        if edittingArea.text.count != 0 {
            edittingArea.attributedText = Utils.handle_TagString(Config.getTweetText(), fontSize: 16)
        }
    }
    
    fileprivate func initSubViews() {
        
    }
    
    fileprivate func setlayout() {
        
    }
    
    @objc func cancelButtonClicked() {
        
    }
    
    @objc func pubTweet() {
        
    }
}
