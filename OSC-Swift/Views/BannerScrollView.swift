//
//  BannerScrollView.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/21.
//  Copyright © 2017年 awd. All rights reserved.
//


//import UIKit
//
//let TITLE_HEIGHT:CGFloat = 30.0
//let PAGECONTROLLER_WIDTH = 60
//
/** BannerScrollView cycle show the way */
//enum BannerScrollViewStyle: Int {
//    case autoAndspringback  = 0 //Automatic cycle display pictures and springback
//    case auto               = 1 //Single direction automatically round
//    case none               = -1//Manual sliding banner
//}
//
/** The alignment of widget (titleLabel or pageController) in horizontal way */
//enum WidgetHorizontalAlignment: Int {
//    case left              = 0
//    case center             = 1
//    case right              = 2
//}
//
//protocol BannerScrollViewDelegate {
//    func clickedScrollViewBanners(bannerTag: Int)
//}
//
//
/**
 *  BannerScrollViewConfiguration is in the service of "BannerScrollView" configuration model object .
 *  Use BannerScrollViewConfiguration (quickConfigurationTitleFontSize:) method can realize rapid configuration .
 *  Use BannerScrollViewConfiguration (instanceBannerConfigurationPlaceholderImage:) method implement a custom configuration .
 */
//
//struct BannerScrollViewConfiguration {
//
//
//    var style: BannerScrollViewStyle
//
/** when value is nil using the "color" property as a gradient color */
//    var placeholderImage: UIImage///< default is nil
/** Priority is lower than "placeholderImage" property , Direction: from top to bottom */
//    var colors: [UIColor]///< default is nil , used as a placeholder gradient background
//
//    var needTitle = false///< default is YES
//    var titleAlignment: WidgetHorizontalAlignment///< default is WidgetHorizontalAlignmenttLeft
//    var titleHeight: CGFloat///< default is 50px
//    var fontName: String///< default is nil , using System font
//    var fontSize: CGFloat
//    var titleColor: UIColor
//
//    var needPage = false///< default is YES
//    var pageAlignment: WidgetHorizontalAlignment///< default is WidgetHorizontalAlignmentRight
//    var defaultColor: UIColor///< default is white
//    var selectedColor: UIColor
//
//    var needDiskCache = false///< default is YES
//}
//
//struct OSCBannerModel {
//
//    var title: String
//
//    var netImagePath: String
//
//    var localImageData: NSData?
//}
//
/** BannerScrollView is an independent control based on "SDWebImage" kit */
//class BannerScrollView : UIView {
//    var isDone = false
//    var banners: [OSCBannerModel]?
//    var delegate: BannerScrollViewDelegate?
//
//    var configuration: BannerScrollViewConfiguration?
//    lazy var imageView: UIImageView = {
//        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
//        view.backgroundColor = UIColor.lightGray
//        view.contentMode = .scaleAspectFill
//        view.clipsToBounds = true
//        return view
//    }()
//    lazy var bottomView: UIView = {
//        let view = UIView(frame: CGRect(x:0, y:self.frame.height - 50, width: self.frame.width, height: 50))
//        return view
//    }()
//    lazy var titleLable: UILabel = {
//        let label = UILabel(frame:CGRect(x: 16, y: self.frame.height-TITLE_HEIGHT, width: self.frame.width-96, height: TITLE_HEIGHT))
//        label.font = UIFont.systemFont(ofSize: 15)
//        label.textColor = UIColor(red:((0xffffff & 0xFF0000) >> 16)/255.0,
//            green:((0xffffff & 0xFF00) >> 8)/255.0,
//            blue:(0xffffff & 0xFF)/255.0,
//            alpha:1.0)
//        label.backgroundColor = UIColor.clear
//        return label
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        self.addSubview(imageView)
//        self.layerForCycleScrollViewTitle(bottomView)
//        self.imageView.addSubview(bottomView)
//        self.imageView.addSubview(titleLable)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
















import UIKit
import FSPagerView
import Kingfisher

class BannerScrollView: UIView {
    var banners = [OSCBanner]()
    var pagerView: FSPagerView?
    var pageControl: FSPageControl?
    
    init(frame: CGRect, banners: [OSCBanner]) {
        super.init(frame: frame)
        
        self.banners = banners
        pagerView = FSPagerView(frame: frame)
        pagerView?.dataSource = self
        pagerView?.delegate = self
        pagerView?.isInfinite = true
        pagerView?.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        self.addSubview(pagerView!)
        // Create a page control
        var controlFrame = CGRect(x: frame.minX, y: frame.maxY - 20, width: frame.width, height: 20)
        pageControl = FSPageControl(frame: controlFrame)
        pageControl?.numberOfPages = banners.count
        pageControl?.contentHorizontalAlignment = .right
        pageControl?.setStrokeColor(.white, for: .normal)
        pageControl?.setStrokeColor(.green, for: .selected)
        pageControl?.setFillColor(.white, for: .normal)
        pageControl?.setFillColor(.green, for: .selected)
        self.addSubview(pageControl!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BannerScrollView: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.banners.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        let url = URL(string: self.banners[index].img)
        cell.imageView?.kf.setImage(with: url)
        cell.contentView.layer.shadowColor = UIColor.clear.cgColor
        cell.textLabel?.text = self.banners[index].name
        return cell
    }
}

extension BannerScrollView: FSPagerViewDelegate {
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
        self.pageControl?.currentPage = index
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        //TODO: goto
    }
}
