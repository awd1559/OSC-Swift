//
//  OSCTabBarController.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/11.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit
import MobileCoreServices

class OSCTabBarController : UITabBarController{
    //MARK: - property
    lazy var centerButton: UIButton = {
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
        //FIXME: how to use option buttons
        //click center button just goto TweetEditingVC
        setupOptionButton()
    }
    
}

// MARK: - center button
extension OSCTabBarController {
    @objc func buttonPressed() {
        if Config.getOwnID() == 0 {
            let loginVC = R.storyboard.login.loginViewController()
            self.selectedViewController?.present(loginVC!, animated: true)
        } else {
            let tweetEditingVC = TweetEditingVC()
            let nav = UINavigationController(rootViewController: tweetEditingVC)
            self.selectedViewController?.present(nav, animated: true)
        }
    }
}

// MARK: - private
extension OSCTabBarController {
    fileprivate func setupTabBar() {
        let zonghe = self.navigationControllerWithSearchBar(MenuContainerController())
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
        var optionButtons = [OptionButton]()
        let screenHeight = UIScreen.main.bounds.size.height
        let screenWidth  = UIScreen.main.bounds.size.height
        let length: CGFloat = 60.0
        let animator = UIDynamicAnimator(referenceView: self.view)

        let buttonRes = [
            (1, "文字", UIImage(named: "tweetEditing"), 0xe69961),
            (2, "相册", UIImage(named: "picture"), 0x0dac6b),
            (3, "拍照", UIImage(named: "shooting"), 0x24a0c4),
            (4, "语音", UIImage(named: "sound"), 0xe96360),
            (5, "扫一扫", UIImage(named: "scan"), 0x61b644),
            (6, "找人", UIImage(named: "search"), 0xf1c50e)
        ]
        for (index, title, image, color) in buttonRes {
            let i = CGFloat(index)
            let button = OptionButton(title: title, image: image!, color: UIColor(hex: color))
            let x = screenWidth/6.0 * (CGFloat(index%3)*2.0+1.0) - (length+16.0)/2.0
            let y = screenHeight + 150.0 + i/3.0*100.0
            let w = length + 16.0
            let h = length + UIFont.systemFont(ofSize:14).lineHeight + 24.0
            
            button.frame = CGRect(x: x, y: y, width: w, height: h)
            button.button.layer.cornerRadius = length/2.0
            
            button.tag = index
            button.isUserInteractionEnabled = true
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(onTapOptionButton))
            button.addGestureRecognizer(recognizer)
            
            optionButtons.append(button)
        }
        
    }
    
    @objc fileprivate func onTapOptionButton(_ sender: UITapGestureRecognizer) {
        switch sender.view!.tag {
        case 1:
            let tweetEditingVC = TweetEditingVC()
            let nav = UINavigationController(rootViewController: tweetEditingVC)
            self.selectedViewController?.present(nav, animated: true)
        case 2: break
        case 3:
            if !UIImagePickerController.isSourceTypeAvailable(.camera) {
                let alertController = UIAlertController(title: "Error", message: "Device has no camera", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alertController, animated: true)
            } else {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = false
                imagePicker.showsCameraControls = true
                imagePicker.cameraDevice = .rear
                imagePicker.mediaTypes = [kUTTypeImage as String]
                
                self.present(imagePicker, animated: true)
            }
        case 4:
            let voiceTweetVC = VoiceTweetEditingVC()
            let nav = UINavigationController(rootViewController: voiceTweetVC)
            self.selectedViewController?.present(nav, animated: true)
        case 5:
            let scanVC = ScanViewController()
            let nav = UINavigationController(rootViewController: scanVC)
            self.selectedViewController?.present(nav, animated: true)
        case 6: break
        default: break
        }
        
        self.buttonPressed()
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
