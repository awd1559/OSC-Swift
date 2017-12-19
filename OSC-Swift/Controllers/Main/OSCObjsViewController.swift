//
//  OSCObjsViewController.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/19.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit
import Ono
import MJRefresh
import Alamofire
import MBProgressHUD

protocol networkingJsonDataDelegate {
    func getJsonDataWithParametersDic(paraDic:[String:Any], isRefresh:Bool)
}


class OSCObjsViewController<T: OSCParseable>: UITableViewController {
    //MARK: - property
    var parseExtraInfo: ((ONOXMLDocument)->Void)?
    var generateURL: ((Int)->String)?
    var tableWillReload: ((Int)->Void)?
    var didRefreshSucceed: (()->Void)?
    var shouldFetchDataAfterLoaded = true
    
    var needRefreshAnimation  = true
    var needCache = false
    var objects = [Any]()
    var allCount = 0
//    var lastCell: LastCell?
    var label = UILabel()
    var page = 0
    var needAutoRefresh = false
    var kLastRefreshTime: String?
    var refreshInterval: TimeInterval?
    var anotherNetWorking: (()->Void)?
    
    
    //新接口相关
    var isJsonDataVc = false
    var generateUrl: (()->String)?
    var parametersDic: [String:Any]?
    var responseJsonObject: AnyClass?
    var netWorkingDelegate: networkingJsonDataDelegate?
    
    var lastRefreshTime: Date?
    var imageView: UIImageView?
    
    func viewWillAppear(animated:Bool)
    {
        super.viewWillAppear(animated)
        imageView?.isHidden = true

    
        if needAutoRefresh {
            let currentTime = Date()
            if currentTime.timeIntervalSince(lastRefreshTime!) > refreshInterval! {
                lastRefreshTime = currentTime
    
                self.refresh()
            }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        imageView = self.findHairlineImageViewUnder(view: (self.navigationController?.navigationBar)!)
    
        self.tableView.backgroundColor = UIColor.themeColor()
    
//        lastCell = LastCell(frame:CGRect(x:0, y:0, width: self.tableView.bounds.size.width, height:44))
//        lastCell.addGestureRecognizer(UITapGestureRecognizer(target:self, action:#selector(fetchMore)))
//        lastCell.status = .more
//        self.tableView.tableFooterView = lastCell
    
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction:#selector(refresh))
        header?.lastUpdatedTimeLabel.isHidden = true
        header?.stateLabel.isHidden = true
        self.tableView.mj_header = header
    
        label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.boldSystemFont(ofSize:14)
//        lastCell.textLabel.textColor = UIColor.titleColor()
        
    
    /*** 自动刷新 ***/
    
    if needAutoRefresh {
        lastRefreshTime = UserDefaults.standard.object(forKey: kLastRefreshTime!) as! Date
        self.tableView.mj_header.beginRefreshing()
        if lastRefreshTime != nil {
            lastRefreshTime = Date()
            UserDefaults.standard.set(lastRefreshTime, forKey: kLastRefreshTime!)
        }
    }
    
    if isJsonDataVc {
//        manager = AFHTTPRequestOperationManager.OSCJsonManager()
        if needAutoRefresh {
            if let netWorkingDelegate = netWorkingDelegate {
                netWorkingDelegate.getJsonDataWithParametersDic(paraDic: parametersDic!, isRefresh:true)
            }
        }
        } else {
//            manager = [AFHTTPRequestOperationManager.OSCManager()
        self.fetchObjects(page: 0, refresh:true)
        }
    
        if shouldFetchDataAfterLoaded {
            return
        }
        if isJsonDataVc && needRefreshAnimation {
            self.tableView.mj_header.beginRefreshing()
            self.tableView.setContentOffset(CGPoint(x:0, y:self.tableView.contentOffset.y-(self.refreshControl?.frame.size.height)!), animated:true)
        }
    
        if needCache {
//            manager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataElseLoad
        }
    }
    
    func findHairlineImageViewUnder(view: UIView) -> UIImageView? {
        if view.isKind(of: UIImageView.self) && view.bounds.size.height <= 1.0 {
            return view as! UIImageView
        }
        for subview in view.subviews {
            imageView = self.findHairlineImageViewUnder(view: subview)
            if let imageView = imageView {
                return imageView
            }
        }
        return nil
    }
    
    //MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableView.separatorColor = UIColor.separatorColor()
        return objects.count
    }
    
    //MARK: - 刷新
    
    @objc func refresh() {
        DispatchQueue.global().async {
//            manager.requestSerializer.cachePolicy = .cachepolicy
            if self.isJsonDataVc {
                if let delegate = self.netWorkingDelegate {
                    delegate.getJsonDataWithParametersDic(paraDic: self.parametersDic!, isRefresh: true)
                }
            } else {
                self.fetchObjects(page: 0, refresh:true)
            }
        }
    
        //刷新时，增加另外的网络请求功能
        if let another = anotherNetWorking {
            another()
        }
    }
    
    
    //MARK: - 上拉加载更多
    
    func scrollViewDidScroll(scrollView:UIScrollView) {
        if (scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height - 150) && self.tableView.mj_header.state != MJRefreshState.refreshing) {
            self.fetchMore()
        }
    }
    
    func fetchMore() {
//        if (!_lastCell.shouldResponseToTouch) {return;}
//
//        lastCell.status = LastCellStatusLoading;
//        manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
//
//        if (_isJsonDataVc) {
//            if ([_netWorkingDelegate respondsToSelector:@selector(getJsonDataWithParametersDic:isRefresh:)]) {
//                [_netWorkingDelegate getJsonDataWithParametersDic:_parametersDic isRefresh:NO];
//            }
//        } else {
//            [self fetchObjectsOnPage:++_page refresh:NO];
//        }
    }
    
    
    //MARK: - 请求数据
    
    func fetchObjects(page:Int, refresh:Bool) {
        Alamofire.request(self.generateURL!(page))
            .responseXMLDocument{response in
                switch response.result {
                case .success(let doc) :
                    let rootElement: ONOXMLElement = doc.rootElement
                    self.allCount = rootElement.firstChild(withTag: "allCount").numberValue().intValue
                    let objectsXML = self.parseXML(xml: doc)
                    
                    if refresh {
                        self.page = 0
                        self.objects.removeAll()
                        if let didRefreshSucceed = self.didRefreshSucceed {
                            didRefreshSucceed()
                        }
                    }
                    
                    if let parseExtraInfo = self.parseExtraInfo {
                        parseExtraInfo(doc)
                    }
                    
                    for objectXML in objectsXML! {
                        var shouldBeAdded = true
                        let obj = T.init(objectXML)
                        
                        for baseobj in self.objects {
//                            if obj == baseobj) {
//                                shouldBeAdded = false
//                                break
//                            }
                        }
                        if shouldBeAdded {
                            self.objects.append(obj)
                        }
                    }
                    
                    if self.needAutoRefresh {
                        UserDefaults.standard.set(self.lastRefreshTime, forKey: self.kLastRefreshTime!)
                        
                    }
                    
                    DispatchQueue.main.async {
                        if let tableWillReload = self.tableWillReload {
                            tableWillReload((objectsXML?.count)!)
                        } else {
                            if self.page == 0 && objectsXML?.count == 0 {
//                                _lastCell.status = LastCellStatusEmpty;
                            } else if objectsXML?.count == 0 || (self.page == 0 && (objectsXML?.count)! < 20) {
//                                _lastCell.status = LastCellStatusFinished;
                            } else {
//                                _lastCell.status = LastCellStatusMore;
                            }
                        }
                        
                        if self.tableView.mj_header.isRefreshing {
                            self.tableView.mj_header.endRefreshing()
                        }
                        
                        self.tableView.reloadData()
                    }
                    
                case .failure(let error):
                    let HUD = Utils.createHUD()
                    HUD.mode = .customView
//                    HUD.mode = MBProgressHUDMode.MBProgressHUDModeCustomView
                    HUD.detailsLabel.text = error.localizedDescription
                    
                    HUD.hide(animated: true, afterDelay: 1)
                    
//                    _lastCell.status = LastCellStatusError;
                    if self.tableView.mj_header.isRefreshing {
                        self.tableView.mj_header.endRefreshing()
                    }
                    self.tableView.reloadData()
                default:
                    break
                }
        }
    }
    
    
    func parseXML(xml: ONOXMLDocument) -> [ONOXMLElement]? {
        assert(false, "Over ride in subclasses")
        return nil
    }
    
    

}
