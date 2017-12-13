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
    
    //MARK: - click on center button
    @objc func buttonPressed() {
        if Config.getOwnID() == 0 {
            let loginVC = R.storyboard.login.loginViewController()
            self.selectedViewController?.present(loginVC!, animated: true)
        } else {
            // TODO: add TweetEditingVC
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
        
        self.tabBar.items?[2].isEnabled = false
        self.tabBar.addSubview(centerButton)
        
        let faxian = R.storyboard.discover.nav()
        self.tabBar.items?[3].title = "发现"
        self.tabBar.items?[3].image = R.image.tabbarNews()
        self.tabBar.items?[3].selectedImage = R.image.tabbarNewsSelected()
        
        let me = R.storyboard.homepage.nav()
        self.tabBar.items?[4].title = "我的"
        self.tabBar.items?[4].image = R.image.tabbarNews()
        self.tabBar.items?[4].selectedImage = R.image.tabbarNewsSelected()
        
        let center = UIViewController()
        self.viewControllers = [zonghe, dongtan, center, faxian!, me!]
        
        
        
        
        self.tabBar.isTranslucent = false
    }
    
    func navigationControllerWithSearchBar(_ controller: UIViewController) -> UINavigationController {
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
