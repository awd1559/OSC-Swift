//
//  InformationCell.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/14.
//  Copyright © 2017年 awd. All rights reserved.
//

import MBProgressHUD
import MJRefresh
import Alamofire
import Ono

let kMenuPageCell = "kMenuPageCell"
let kScreen_Width = UIScreen.main.bounds.size.width
let BannerView_Simple_Height = UIScreen.main.bounds.size.width * 39 / 125
let BannerView_CustomActivity_Height = 215

protocol MenuPageCellDelegate {
    func cell(_ cell: MenuPageCell, update dataSourceDic:[String: InfoResultItem])
    
    func cell(_ cell: MenuPageCell, onclick tableViewCell: UITableViewCell,  push controller: UIViewController, url: String)
}

extension MenuPageCellDelegate {
    //optional
    func cell(_ cell: MenuPageCell, onclick banner: UIView, push controller: UIViewController, url:String) {
    }
}


class MenuPageCell: UICollectionViewCell {
    var delegate: MenuPageCellDelegate?
    var menuItem: OSCMenuItem?
    var pageToken: String?
    var offestDistance: Float?
    
    var HUD: MBProgressHUD?
//    optional_banner
    var bannerScrollView: BannerScrollView?
    var activityBannerView: ActivityHeadView?
    var dataSources = [OSCListItem]()
    var bannerDataSources: [OSCBanner]?
//    var updateToController_Dic: [:]
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.contentView.bounds)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(NewsCell.self, forCellReuseIdentifier:kNewsCellID)
        tableView.register(BlogCell.self, forCellReuseIdentifier:kBlogCellID)
        tableView.register(QuesAnsCell.self, forCellReuseIdentifier:kQuesAnsCellID)
        tableView.register(ActivityCell.self, forCellReuseIdentifier:kActivityCellID)
        
        let header = MJRefreshNormalHeader(refreshingBlock: {
            self.commonRefresh()
        })
        tableView.mj_header = header
        let footer = MJRefreshBackNormalFooter(refreshingBlock: {
            self.sendRequestGetListData(false)
        })
        tableView.mj_footer = footer
        
        return tableView
    }()
    
    static func returnReuseInformationListCollectionViewCell(_ collectionView: UICollectionView,
                identifier: String, indexPath: IndexPath,  model:OSCMenuItem) -> MenuPageCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:identifier, for:indexPath) as! MenuPageCell
        cell.menuItem = model
        return cell
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginRefreshCurCell() {
        self.tableView.mj_header.beginRefreshing()
    }
    
    func configurationPostBackDictionary(_ resultItem: [String: InfoResultItem]) {
        self.hideAllGeneralPage()
        self.tableView.mj_footer.state = .idle
        
        if self.dataSources.count > 0 {
            offestDistance = 0
            self.dataSources.removeAll()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        switch menuItem!.banner.catalog {
        case .simple, .simpleblogs:
            self.tableView.tableHeaderView = self.bannerScrollView
        case .customactivity:
            self.tableView.tableHeaderView = self.activityBannerView
        case .none:
            self.tableView.tableHeaderView = nil
        }
        
        let resultItemModel = Array(resultItem.values).last!
        pageToken = resultItemModel.pageToken
        
        if (resultItemModel.tableViewArr != nil) && resultItemModel.tableViewArr!.count > 0 {
            dataSources = resultItemModel.tableViewArr!
            bannerDataSources = resultItemModel.bannerArr
            
            if self.bannerDataSources != nil {
                self.configurationBannerView()
            } else {
                self.tableView.tableHeaderView = nil
            }
            self.tableView.reloadData()
            self.tableView.setContentOffset(CGPoint(x:CGFloat(0), y:CGFloat(resultItemModel.offsetDistance)), animated: true)
            
            if resultItemModel.isFromCache {
                self.tableView.mj_header.beginRefreshing()
            }
        } else {
            self.tableView.mj_header.beginRefreshing()
        }
    }
    
    func configurationBannerView() {
        switch menuItem!.banner.catalog {
        case .simple, .simpleblogs:
            let frame = CGRect(x: 0, y: 0, width: kScreen_Width, height: BannerView_Simple_Height)
            self.bannerScrollView = BannerScrollView(frame: frame, banners: self.bannerDataSources!)
            self.tableView.tableHeaderView = self.bannerScrollView
        case .customactivity:
            self.activityBannerView?.banners = self.bannerDataSources
        default:
            break
        }
    }
    
    func commonRefresh() {
        offestDistance = 0
        if let _ = menuItem?.banner.href {
            self.sendRequestGetBannerData()
        }
        self.sendRequestGetListData(true)
    }
    
    func sendRequestGetBannerData() {
        let param = ["catalog" : menuItem?.banner.catalog.rawValue]
        
        Client.banners(param: param) { banners in
            if banners.count > 0 {
                self.bannerDataSources = [OSCBanner]()
                self.bannerDataSources?.append(contentsOf: banners)
                self.configurationBannerView()
                self.tableView.reloadData()
            }
        }
    }
    
    func sendRequestGetListData(_ isRefresh: Bool) {
        if menuItem!.needLogin && Config.getOwnID() == 0 {
            self.showCustomPage(R.image.ic_tip_fail()!, tip:"很遗憾,您必须登录才能查看此处内容")
            return
        } else {
            self.hideAllGeneralPage()
        }
        
        var param = ["token" : menuItem!, "pageToken" : menuItem!.token] as [String : Any]
        if pageToken != "" && !isRefresh  {
            param["pageToken"] = pageToken
        } else {
            self.tableView.mj_footer.state = .idle
        }
        
        Client.sublist(param: param) { listitems in
            
        }
    }
}


//MARK: - UITableViewDataSource
extension MenuPageCell: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.dataSources.count > 0 {
            return self.dataSources.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.dataSources.count > 0 {
            let listItem = self.dataSources[indexPath.row]
            switch listItem.type {
            case .info:
                let curCell = tableView.dequeueReusableCell(withIdentifier: kNewsCellID, for:indexPath) as! NewsCell
                curCell.showCommentCount = true
                return curCell
            case .blog:
                return tableView.dequeueReusableCell(withIdentifier: kBlogCellID, for:indexPath)
            case .forum:
                //FIXME: use Utils.token not hard code
                if menuItem?.token == "d6112fa662bc4bf21084670a857fbd20" {//推荐
                    let curCell = tableView.dequeueReusableCell(withIdentifier: kNewsCellID, for:indexPath) as! NewsCell
                    curCell.showCommentCount = true
                    
                    return curCell
                } else {
                    return tableView.dequeueReusableCell(withIdentifier: kQuesAnsCellID, for:indexPath)
                }
            case .activity:
                if menuItem?.token == "d6112fa662bc4bf21084670a857fbd20" {//推荐
                    let curCell = tableView.dequeueReusableCell(withIdentifier: kNewsCellID, for:indexPath) as! NewsCell
                    curCell.showCommentCount = true
                    
                    return curCell
                } else {
                    return tableView.dequeueReusableCell(withIdentifier: kActivityCellID, for:indexPath) as! ActivityCell
                }
            default:
                let curCell = tableView.dequeueReusableCell(withIdentifier: kNewsCellID, for:indexPath) as! NewsCell
                //FIXME: use enum, not hard code
                if listItem.type == .linknews || menuItem!.type.rawValue == 7 { //链接新闻
                    curCell.showCommentCount = false
                } else {
                    curCell.showCommentCount = true
                }
                
                return curCell
            }
//            let curTableView = self.distributionListCurrentCellWithItem(listItem: listItem, tableView:tableView, indexPath:indexPath) as! UsualTableViewCell
//            curTableView.setValue(listItem, forKey:"listItem")
//            curTableView.selectedBackgroundView = UIView(frame:curTableView.frame)
//            curTableView.selectedBackgroundView?.backgroundColor = UIColor.selectCellSColor()
//            return curTableView
        }else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var result: Float = 0
        if self.dataSources.count > 0 {
            let listItem = self.dataSources[indexPath.row]
            switch listItem.type {
            case .info:
                result = listItem.rowHeight
            case .blog:
                result = listItem.rowHeight
            case .forum:
                result = listItem.rowHeight
            case .activity:
                result = listItem.rowHeight
            default:
                result = listItem.rowHeight
            }
        } else {
            result = 0
        }
        return CGFloat(result)
    }
}

//MARK: - UITableViewDelegate
extension MenuPageCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listItem = self.dataSources[indexPath.row]
        tableView.deselectRow(at: indexPath, animated:true)
        let curVC = OSCPushTypeControllerHelper.pushControllerGeneral(listItem.type, id:listItem.id)
        if let delegate = self.delegate {
            delegate.cell(self, onclick: tableView.cellForRow(at: indexPath)!, push: curVC!, url: listItem.href)
        }
    }
}


//MARK: - UIScrollViewDelegate
extension MenuPageCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        offestDistance = Float(scrollView.contentOffset.y)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if let delegate = self.delegate {
            let updateResultItem = InfoResultItem(bannerArr: self.bannerDataSources, tableViewArr:self.dataSources, pageToken:pageToken!, offsetDistance:offestDistance!, isFromCache:false)
            let postBackDic = [menuItem!.token : updateResultItem]
            delegate.cell(self, update:postBackDic)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let delegate = self.delegate {
            let updateResultItem = InfoResultItem(bannerArr: self.bannerDataSources, tableViewArr:self.dataSources, pageToken:pageToken!, offsetDistance:offestDistance!, isFromCache:false)
            let postBackDic = [menuItem!.token : updateResultItem]
            delegate.cell(self, update:postBackDic)
        }
    }
}

struct InfoResultItem {
    var bannerArr: [OSCBanner]?
    
    var tableViewArr: [OSCListItem]?
    
    var pageToken: String = ""
    
    var offsetDistance: Float = 0
    
    var isFromCache: Bool = false
}
