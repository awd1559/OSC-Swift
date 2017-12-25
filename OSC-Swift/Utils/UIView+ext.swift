//
//  UIView+ext.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/21.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit
import SnapKit

fileprivate let LOADING_PAGE = Int.max - 1
fileprivate let ERROR_PAGE = Int.max - 2
fileprivate let BLANK_PAGE = Int.max - 3
fileprivate let LOGININ_PAGE = Int.max - 4
fileprivate let CUSTOM_PAGE = Int.max - 5

class LoadingPage: UIView {
    var isLoading = false
    var activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var loadingTipLabel =  UILabel()
    
    init() {
        super.init(frame: CGRect.zero)
        self.tag = LOADING_PAGE
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tag = LOADING_PAGE
        
        loadingTipLabel.numberOfLines = 1
        loadingTipLabel.font = UIFont.systemFont(ofSize: 15)
        loadingTipLabel.textAlignment = .center
        loadingTipLabel.textColor = UIColor.gray
        loadingTipLabel.text = "正在加载..."
        
        self.addSubview(activityIndicatorView)
        self.addSubview(loadingTipLabel)
        
        activityIndicatorView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(25)
            make.bottom.equalTo(self.snp.centerY).offset(-5)
        }
        loadingTipLabel.snp.makeConstraints{ make in
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(self.snp.centerY).offset(5)
        }
    }
    func startAnimation() {
        self.isHidden = false
        self.activityIndicatorView.startAnimating()
        self.isLoading = true
    }
    
    func stopAnimation() {
        self.isHidden = true
        self.activityIndicatorView.stopAnimating()
        self.isLoading = false
    }
}


class ErrorPage: UIView {
    var didClickReloadBlock: (()->Void)?
    var errorImageView = UIImageView(image: R.image.ic_tip_fail())
    var errorTipLabel = UILabel()
    var reloadButton = UIButton(type: .custom)
    
    init() {
        super.init(frame: CGRect.zero)
        self.tag = ERROR_PAGE
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tag = ERROR_PAGE
        
        self.addSubview(errorImageView)
        
        errorTipLabel.numberOfLines = 1
        errorTipLabel.font = UIFont.systemFont(ofSize: 15)
        errorTipLabel.textAlignment = .center
        errorTipLabel.textColor = UIColor.gray
        errorTipLabel.text = "很抱歉,网络似乎出了点状况..."
        self.addSubview(errorTipLabel)
        
        reloadButton.layer.masksToBounds = true
        reloadButton.layer.cornerRadius = 15
        reloadButton.layer.borderColor = UIColor.gray.cgColor
        reloadButton.layer.borderWidth = 1.0
        reloadButton.setBackgroundImage(Utils.createImageWithColor(UIColor.clear), for: .normal)
        reloadButton.setBackgroundImage(Utils.createImageWithColor(UIColor.gray.withAlphaComponent(0.3)), for: .highlighted)
        reloadButton.setTitle("重新加载", for: .normal)
        reloadButton.setTitleColor(UIColor.gray, for: .normal)
        reloadButton.addTarget(self, action: #selector(clickReloadButton), for: .touchUpInside)
        self.addSubview(reloadButton)
        
        errorImageView.snp.makeConstraints{ make in
            make.width.equalTo(120)
            make.height.equalTo(140)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.snp.centerY).offset(-80)
        }
        errorTipLabel.snp.makeConstraints{ make in
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(errorImageView.snp.bottom).offset(5)
        }
        reloadButton.snp.makeConstraints{ make in
            make.width.equalTo(120)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalTo(errorTipLabel.snp.bottom).offset(10)
        }
    }
    
    @objc func clickReloadButton(sender: UIButton) {
        self.didClickReloadBlock?()
    }
}


class BlankPage: UIView {
    var nodataImageView = UIImageView(image: R.image.ic_tip_smile())
    var nodataTipLabel = UILabel()
    
    init() {
        super.init(frame: CGRect.zero)
        self.tag = BLANK_PAGE
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tag = BLANK_PAGE
        
        self.addSubview(nodataImageView)

        nodataTipLabel.numberOfLines = 1
        nodataTipLabel.font = UIFont.systemFont(ofSize: 15)
        nodataTipLabel.textAlignment = .center
        nodataTipLabel.textColor = UIColor.gray
        nodataTipLabel.text = "这里没有数据呢,赶紧弄出点动静吧~"
        self.addSubview(nodataTipLabel)
        
        nodataImageView.snp.makeConstraints{ make in
            make.width.equalTo(120)
            make.height.equalTo(140)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.snp.centerY).offset(-30)
        }
        
        nodataTipLabel.snp.makeConstraints{ make in
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(nodataImageView.snp.bottom).offset(5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class LoginPage: UIView {
    var didClickLogInBlock: (()->Void)?
    var loginImageView = UIImageView(image: R.image.ic_tip_fail())
    var loginTipLabel = UILabel()
    var loginButton = UIButton(type: .custom)
    
    init() {
        super.init(frame: CGRect.zero)
        self.tag = LOGININ_PAGE
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tag = LOGININ_PAGE
        
        self.addSubview(loginImageView)
        
        loginTipLabel.numberOfLines = 1
        loginTipLabel.font = UIFont.systemFont(ofSize: 15)
        loginTipLabel.textAlignment = .center
        loginTipLabel.textColor = UIColor.gray
        loginTipLabel.text = "亲,您还没登录呢~"
        self.addSubview(loginTipLabel)
        
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 15
        loginButton.layer.borderColor = UIColor.gray.cgColor
        loginButton.layer.borderWidth = 1.0
        loginButton.setBackgroundImage(Utils.createImageWithColor(UIColor.clear), for: .normal)
        loginButton.setBackgroundImage(Utils.createImageWithColor(UIColor.gray.withAlphaComponent(0.3)), for: .highlighted)
        loginButton.setTitle("马上登录", for: .normal)
        loginButton.setTitleColor(UIColor.gray, for:.normal)
        loginButton.addTarget(self, action:#selector(gotoLogIn), for: .touchUpInside)
        self.addSubview(loginButton)
        
        loginImageView.snp.makeConstraints{ make in
            make.width.equalTo(120)
            make.height.equalTo(140)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.snp.centerY).offset(-80)
        }
        loginTipLabel.snp.makeConstraints{ make in
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(loginImageView.snp.bottom).offset(5)
        }
        loginButton.snp.makeConstraints{ make in
            make.width.equalTo(120)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalTo(loginTipLabel.snp.bottom).offset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func gotoLogIn() {
        self.didClickLogInBlock?()
    }
}


class CustomPage: UIView {
    var customImageView = UIImageView()
    var tipLabel = UILabel()
    
    init(frame: CGRect, image: UIImage, tip: String) {
        super.init(frame: frame)
        self.tag = CUSTOM_PAGE
        
        customImageView.image = image
        self.addSubview(customImageView)
        
        tipLabel.numberOfLines = 1
        tipLabel.font = UIFont.systemFont(ofSize: 15)
        tipLabel.textAlignment = .center
        tipLabel.textColor = UIColor.gray
        tipLabel.text = tip
        self.addSubview(tipLabel)
        
        customImageView.snp.makeConstraints{ make in
            make.width.equalTo(120)
            make.height.equalTo(140)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.snp.centerY).offset(-30)

        }
        tipLabel.snp.makeConstraints{ make in
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(customImageView.snp.bottom).offset(5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension UIView {
    func hideAllGeneralPage() {
        self.viewWithTag(LOADING_PAGE)?.removeFromSuperview()
        self.viewWithTag(ERROR_PAGE)?.removeFromSuperview()
        self.viewWithTag(BLANK_PAGE)?.removeFromSuperview()
        self.viewWithTag(LOGININ_PAGE)?.removeFromSuperview()
        self.viewWithTag(CUSTOM_PAGE)?.removeFromSuperview()
    }
    
    func showLoadingPage() {
        hideAllGeneralPage()
        
        let page = LoadingPage(frame: self.bounds)
        self.addSubview(page)
        self.bringSubview(toFront: page)
        page.startAnimation()
    }
    
    func showErrorPage(reload: @escaping (()->Void)) {
        hideAllGeneralPage()
        
        let page = ErrorPage(frame: self.bounds)
        page.didClickReloadBlock = reload
        self.addSubview(page)
        self.bringSubview(toFront: page)
    }
    
    func showBlankPageView() {
        hideAllGeneralPage()
        
        let page = BlankPage(frame: self.bounds)
        self.addSubview(page)
        self.bringSubview(toFront: page)
    }
    
    func showLoginPageView() {
        let page = LoginPage(frame: self.bounds)
        self.addSubview(page)
        self.bringSubview(toFront: page)
    }
    
    func showCustomPage(_ image: UIImage, tip: String) {
        let page = CustomPage(frame: self.bounds, image: image, tip: tip)
        self.addSubview(page)
        self.bringSubview(toFront: page)
    }
}
