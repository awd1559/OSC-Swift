//
//  OSCTabBarController.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/11.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit

class OSCTabBarController : UITabBarController{
    //MARK: - property
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
    
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
}

// MARK: - center button
extension OSCTabBarController {
    @objc func buttonPressed() {
        if Config.getOwnID() == 0 {
            let loginVC = R.storyboard.login.loginViewController()
            self.selectedViewController?.present(loginVC!, animated: true)
        } else {
            // TODO: add TweetEditingVC
            let loginVC = R.storyboard.login.loginViewController()
            self.selectedViewController?.present(loginVC!, animated: true)
            //            let tweetEditingVC = TweetEditingVC()
            //            self.selectedViewController?.present(tweetEditingVC, animated: true)
        }
    }
}

// MARK: - private
extension OSCTabBarController {
    fileprivate func setupTabBar() {
        let zonghe = self.navigationControllerWithSearchBar(OSCSyntheticalController())
        zonghe.tabBarItem.title = "综合"
        zonghe.tabBarItem.image = R.image.tabbarNews()
        zonghe.tabBarItem.selectedImage = R.image.tabbarNewsSelected()
        
        let dongtan = self.navigationControllerWithSearchBar(OSCTweetsController())
        dongtan.tabBarItem.title = "动弹"
        dongtan.tabBarItem.image = R.image.tabbarNews()
        dongtan.tabBarItem.selectedImage = R.image.tabbarNewsSelected()
        
        let faxian = R.storyboard.discover.nav()
        faxian?.topViewController?.tabBarItem.title = "发现"
        faxian?.topViewController?.tabBarItem.image = R.image.tabbarNews()
        faxian?.topViewController?.tabBarItem.selectedImage = R.image.tabbarNewsSelected()
        
        let me = R.storyboard.homepage.nav()
        me?.topViewController?.tabBarItem.title = "我的"
        me?.topViewController?.tabBarItem.image = R.image.tabbarNews()
        me?.topViewController?.tabBarItem.selectedImage = R.image.tabbarNewsSelected()
        
        let center = UIViewController()
        self.viewControllers = [zonghe, dongtan, center, faxian!, me!]
        
        self.tabBar.items![2].isEnabled = false
        self.tabBar.addSubview(centerButton)
        
        self.tabBar.isTranslucent = false
    }
    
    fileprivate func setupOptionButton() {
//        var optionButtons = [Any]
//        let screenHeight = UIScreen.main.bounds.size.height
//        let screenWidth  = UIScreen.main.bounds.size.height
//        let length = 60
//        let animator = UIDynamicAnimator(referenceView: self.view)
//
//        let buttonTitles = ["文字", "相册", "拍照", "语音", "扫一扫", "找人"]
        let buttonImages = [R.image.tweetEditing(),
                            R.image.picture()]
    }
    
    fileprivate func navigationControllerWithSearchBar(_ controller: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: controller)
        let item = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(pushSearchViewController))
        controller.navigationItem.rightBarButtonItem = item
        return nav
    }
    
    @objc func pushSearchViewController() {
        let nav = self.selectedViewController
        let searchVC = OSCSearchViewController()
        let rootNav = UINavigationController(rootViewController: searchVC)
        nav?.present(rootNav, animated: true)
    }
}

//MARK: - UITabBarControllerDelegate
extension OSCTabBarController : UITabBarControllerDelegate {
    
}

//MARK: - UINavigationControllerDelegate
extension OSCTabBarController : UINavigationControllerDelegate {
    
}

//MARK: - UIImagePickerControllerDelegate
extension OSCTabBarController : UIImagePickerControllerDelegate {
    
}
