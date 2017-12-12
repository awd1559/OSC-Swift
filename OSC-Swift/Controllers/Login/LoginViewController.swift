//
//  NewLoginViewController.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/12.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    //MARK: property
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var thirdLoginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var forgetButton: UIButton!
    
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var passWordView: UIView!
    @IBOutlet weak var oscLogView: UIImageView!
    
    @IBOutlet weak var nameToTopHeight: NSLayoutConstraint!
    @IBOutlet weak var moveBottomView: UIView!
    
    @IBOutlet weak var bakImageView: UIImageView!
    
    @IBOutlet weak var thirdLoginView: UIView!
    @IBOutlet weak var weChatButtonRight: NSLayoutConstraint!
    @IBOutlet weak var weChatButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var weChatButtonWidth: NSLayoutConstraint!
    
    fileprivate let viewHeight = UIScreen.main.bounds.height
    fileprivate let navBarHeight = 64
    fileprivate let affsetHeight = 250
    
    //MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - private
    
    
    
    //MARK: - button actions
    @IBAction func backAction(_ sender: UIButton) {
        //back button is clicked
    }
    
    @IBAction func highlightedState(_ sender: UIButton) {
        //touch down inside login/register button
    }
    
    @IBAction func outSideState(_ sender: UIButton) {
        //touch up outside login/register button
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        //touch up inside login button
    }
    
    @IBAction func registerAction(_ sender: UIButton) {
        //touch up inside register button
    }
    
    // MARK: - third party login
    @IBAction func thirdLoginAction(_ sender: UIButton) {
        //
    }
    
    @IBAction func weiboLoginAction(_ sender: UIButton) {}
    @IBAction func weChatLoginAction(_ sender: UIButton) {}
    @IBAction func QQLoginAction(_ sender: UIButton) {}
    @IBAction func CSDNLoginAction(_ sender: UIButton) {}
}

extension LoginViewController : UITextFieldDelegate {
    
}

//extension LoginViewController : WeiboSDKDelegate {
//
//}
//
//extension LoginViewController : WXApiDelegate {
//
//}
//
//extension LoginViewController : TencentSessionDelegate {
//
//}

