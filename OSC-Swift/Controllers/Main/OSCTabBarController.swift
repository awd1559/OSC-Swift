//
//  OSCTabBarController.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/11.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit

class OSCTabBarController : UITabBarController{
    
    lazy var centerButton: UIButton = {
        print("create a center button")
        let button = UIButton(type: .custom)
        button.setImage(R.image.ic_nav_add(), for: .normal)
        button.setImage(R.image.ic_nav_add_actived(), for: .highlighted)
        let w = self.tabBar.frame.size.width / 5 - 6
        let h = self.tabBar.frame.size.height - 4
        let origin = self.view.convert(self.tabBar.center, to: self.tabBar)
        //works on 5s, not x
        button.frame = CGRect(x: origin.x - h/2, y: origin.y - h/2, width: h, height: h)
        
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let zonghe = UIViewController()
        zonghe.tabBarItem.title = "综合"
        zonghe.tabBarItem.image = R.image.tabbarNews()
        zonghe.tabBarItem.selectedImage = R.image.tabbarNewsSelected()
        
        let dongtan = UIViewController()
        dongtan.tabBarItem.title = "动弹"
        dongtan.tabBarItem.image = R.image.tabbarNews()
        dongtan.tabBarItem.selectedImage = R.image.tabbarNewsSelected()
        
        let faxian = UIViewController()
        faxian.tabBarItem.title = "发现"
        faxian.tabBarItem.image = R.image.tabbarNews()
        faxian.tabBarItem.selectedImage = R.image.tabbarNewsSelected()
        
        let me = UIViewController()
        me.tabBarItem.title = "我的"
        me.tabBarItem.image = R.image.tabbarNews()
        me.tabBarItem.selectedImage = R.image.tabbarNewsSelected()
        
        let center = UIViewController()
        self.viewControllers = [zonghe, dongtan, center, faxian, me]
        
        self.tabBar.items?[2].isEnabled = false
        
        self.tabBar.addSubview(centerButton)
    }
    
    //MARK: click on center button
    @objc func buttonPressed() {
//        if Config.getOwnID() == 0 {
            let loginVC = R.storyboard.login.loginViewController()
            self.selectedViewController?.present(loginVC!, animated: true)
//        } else {
            //TODO: add TweetEditingVC
//            let tweetEditingVC = TweetEditingVC()
//            self.selectedViewController?.present(tweetEditingVC, animated: true)
//        }
    }
    
}
