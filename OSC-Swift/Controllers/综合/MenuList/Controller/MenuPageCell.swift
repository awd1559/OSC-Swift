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
    var listItems = [OSCListItem]()
    var bannerDataSources: [OSCBanner]?
    
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
        
        if self.listItems.count > 0 {
            offestDistance = 0
            self.listItems.removeAll()
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
            listItems = resultItemModel.tableViewArr!
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
        
        guard let menuItem = menuItem else {
            return
        }
        var param = ["token" : menuItem.token] as [String : Any]
        if pageToken != "" && !isRefresh  {
            param["pageToken"] = pageToken
        } else {
            self.tableView.mj_footer.state = .idle
        }
        
        //FIXME: pageToken
        Client.sublist(param: param) { listitems in
            if listitems.count > 0 {
                self.listItems.removeAll()
                self.listItems.append(contentsOf: listitems)
                self.hideAllGeneralPage()
            } else {
                self.showCustomPage(R.image.ic_tip_smile()!, tip: "这里没找到数据呢")
            }
        }
    }
}


//MARK: - UITableViewDataSource
extension MenuPageCell: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.listItems.count > 0 {
            return self.listItems.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.listItems.count > 0 {
            let listitem = self.listItems[indexPath.row]
            switch listitem.type {
            case .info:
                let cell = tableView.dequeueReusableCell(withIdentifier: kNewsCellID, for:indexPath) as! NewsCell
                cell.listItem = listitem
                return cell
            case .blog:
                return tableView.dequeueReusableCell(withIdentifier: kBlogCellID, for:indexPath)
            case .forum:
                if menuItem?.token == buildinMenus[0].token {
                    let cell = tableView.dequeueReusableCell(withIdentifier: kNewsCellID, for:indexPath) as! NewsCell
                    
                    return cell
                } else {
                    return tableView.dequeueReusableCell(withIdentifier: kQuesAnsCellID, for:indexPath)
                }
            case .activity:
                if menuItem?.token == buildinMenus[0].token {
                    let cell = tableView.dequeueReusableCell(withIdentifier: kNewsCellID, for:indexPath) as! NewsCell
                    
                    return cell
                } else {
                    return tableView.dequeueReusableCell(withIdentifier: kActivityCellID, for:indexPath) as! ActivityCell
                }
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: kNewsCellID, for:indexPath) as! NewsCell
                if listitem.type == .linknews || menuItem!.type == .linknewstwo { //链接新闻
//                    cell.showCommentCount = false
                } else {
//                    cell.showCommentCount = true
                }
                
                return cell
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
        var result: CGFloat = 0
        if self.listItems.count > 0 {
            let listItem = self.listItems[indexPath.row]
            switch listItem.type {
            case .info:
                result = NewsCell.rowHeight
            case .blog:
                result = BlogCell.rowHeight
            case .forum:
                result = QuesAnsCell.rowHeight
            case .activity:
                result = ActivityCell.rowHeight
            default:
                result = NewsCell.rowHeight
            }
        } else {
            result = 0
        }
        return result
    }
}

//MARK: - UITableViewDelegate
extension MenuPageCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listItem = self.listItems[indexPath.row]
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
            let updateResultItem = InfoResultItem(bannerArr: self.bannerDataSources, tableViewArr:self.listItems, pageToken:pageToken!, offsetDistance:offestDistance!, isFromCache:false)
            let postBackDic = [menuItem!.token : updateResultItem]
            delegate.cell(self, update:postBackDic)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let delegate = self.delegate {
            let updateResultItem = InfoResultItem(bannerArr: self.bannerDataSources, tableViewArr:self.listItems, pageToken:pageToken!, offsetDistance:offestDistance!, isFromCache:false)
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
