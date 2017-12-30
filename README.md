base on OSChina iphone app [v3.8.6](https://gitee.com/oschina/iphone-app/tree/v3.8.6/)

- test of ui is a big problem

TODO:

- replace [AFNetworking](https://github.com/AFNetworking/AFNetworking) with Alamofire
- [MJRefresh](https://github.com/CoderMJLee/MJRefresh) in swift
- [MBProgressHUD](https://github.com/jdg/MBProgressHUD) in swift
- [Kingfisher](https://github.com/onevcat/Kingfisher)

- OSCMenuItem: Decodable, use PropertyListDecoder, in Utils.allMenuItems from subMenuItems.plist
- MenuPageCollection: use UIPageViewController
- BannerScrollView:  FSPageView
    the textLabel shadow is with alpha 0.6,  it is unconfigable, must change the source code
    FSPageViewCell.textLabel get{
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    }



- remove R.swift
- use objectmap to map json to model
