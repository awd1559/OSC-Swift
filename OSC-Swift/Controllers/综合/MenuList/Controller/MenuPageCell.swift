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

let kInformationListCollectionViewCellIdentifier = "OSCInformationListCollectionViewCell"


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
        
        tableView.register(OSCInformationTableViewCell.self, forCellReuseIdentifier:InformationTableViewCell_IdentifierString)
//        tableView.registerClass(OSCBlogCell.self, forCellReuseIdentifier:kNewHotBlogTableViewCellReuseIdentifier)
//        tableView.registerClass(OSCQuesAnsTableViewCell.self] forCellReuseIdentifier:kQuesAnsTableViewCellReuseIdentifier)
//        tableView.registerNib:[UINib nibWithNibName:"OSCActivityTableViewCell" bundle:nil] forCellReuseIdentifier:OSCActivityTableViewCell_IdentifierString)
    
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
//        self.hideCustomPageView()
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
            
            if let bannerDataSources = self.bannerDataSources {
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
            self.bannerScrollView?.banners = self.convertModels(banners: self.bannerDataSources!)
        case .customactivity:
            self.activityBannerView?.banners = self.bannerDataSources
        default:
            break
        }
    }
    
    func convertModels(banners: [OSCBanner]) -> [OSCBannerModel] {
        var arr = [OSCBannerModel]()
        arr.reserveCapacity(banners.count)
        for banner in banners {
            let model = OSCBannerModel(title: banner.name, netImagePath: banner.img, localImageData: nil)
            arr.append(model)
        }
        return arr
    }
    
    func commonRefresh() {
        offestDistance = 0
        if let _ = menuItem?.banner.href {
            self.sendRequestGetBannerData()
        }
        self.sendRequestGetListData(true)
    }
    
    func sendRequestGetBannerData() {
        let url = OSCAPI_V2_PREFIX + OSCAPI_BANNER
        let param = ["catalog" : menuItem?.banner.catalog.rawValue]
        
        Alamofire.request(url, method: .get, parameters: param)
            .responseXMLDocument{ response in
                switch response.result {
                case .success(let doc):
                    break
//                    let rootElement: ONOXMLElement = doc.rootElement
//                    let resultDic = rootElement.firstChild(withTag: "result").children(withTag: "items")
                    
                case .failure(let error):
                    self.HUD = Utils.createHUD()
                    self.HUD?.mode = .customView
                    self.HUD?.detailsLabel.text = error.localizedDescription
                    self.HUD?.hide(animated: true, afterDelay: 1)
                }
        }
    }
    
    func sendRequestGetListData(_ isRefresh: Bool) {
        if menuItem!.needLogin && Config.getOwnID() == 0 {
            
            //TODO: try to use base protocal, DO NOT USE AssociatedObject
//            self.showCustomPageViewWithImage(R.image.ic_tip_fail(), tipString:"很遗憾,您必须登录才能查看此处内容")
            return
        } else {
//            self.hideCustomPageView()
        }
        
        let url = OSCAPI_V2_PREFIX + OSCAPI_INFORMATION_LIST
        var param = ["token" : menuItem!, "pageToken" : menuItem!.token] as [String : Any]
        if pageToken != "" && !isRefresh  {
            param["pageToken"] = pageToken
        } else {
            self.tableView.mj_footer.state = .idle
        }
        
        Alamofire.request(url, method: .get, parameters: param)
            .responseXMLDocument{ response in
                switch response.result {
                case .success(let doc):
                    break
//                    let rootElement: ONOXMLElement = doc.rootElement
//                    self.allCount = rootElement.firstChild(withTag: "allCount").numberValue().intValue
//                    let objectsXML = self.parseXML(xml: doc)
                case .failure(let error) :
                    self.HUD = Utils.createHUD()
                    self.HUD?.mode = .customView
                }
        }
    }
    
    func distributionListCurrentCellWithItem(listItem: OSCListItem, tableView:UITableView, indexPath: IndexPath) -> UITableViewCell {
        switch listItem.type {
        case .info:
            let curCell = tableView.dequeueReusableCell(withIdentifier: InformationTableViewCell_IdentifierString, for:indexPath) as! OSCInformationTableViewCell
            curCell.showCommentCount = true
            return curCell
        case .blog:
            return tableView.dequeueReusableCell(withIdentifier: kNewHotBlogTableViewCellReuseIdentifier, for:indexPath)
        case .forum:
            if menuItem?.token == "d6112fa662bc4bf21084670a857fbd20" {//推荐
                let curCell = tableView.dequeueReusableCell(withIdentifier: InformationTableViewCell_IdentifierString, for:indexPath) as! OSCInformationTableViewCell
                curCell.showCommentCount = true
                
                return curCell
            } else {
                return tableView.dequeueReusableCell(withIdentifier: kQuesAnsTableViewCellReuseIdentifier, for:indexPath)
            }
        case .activity:
            if menuItem?.token == "d6112fa662bc4bf21084670a857fbd20" {//推荐
                let curCell = tableView.dequeueReusableCell(withIdentifier: InformationTableViewCell_IdentifierString, for:indexPath) as! OSCInformationTableViewCell
                curCell.showCommentCount = true
                
                return curCell
            } else {
                return tableView.dequeueReusableCell(withIdentifier: OSCActivityTableViewCell_IdentifierString, for:indexPath)
            }
        default:
            let curCell = tableView.dequeueReusableCell(withIdentifier: InformationTableViewCell_IdentifierString, for:indexPath) as! OSCInformationTableViewCell
            if listItem.type == .linknews || menuItem!.type.rawValue == 7 { //链接新闻
                curCell.showCommentCount = false
            } else {
                curCell.showCommentCount = true
            }
            
            return curCell
        }
    }
    
    func distributionListCurrentCellHeightWithTableView(_ tableView: UITableView, listItem: OSCListItem) -> Float {
        switch listItem.type {
        case .info:
            return listItem.rowHeight
        case .blog:
            return listItem.rowHeight
        case .forum:
            return listItem.rowHeight
        case .activity:
            return listItem.rowHeight
        default:
            return listItem.rowHeight
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
            let curTableView = self.distributionListCurrentCellWithItem(listItem: listItem, tableView:tableView, indexPath:indexPath) as! UsualTableViewCell
            curTableView.setValue(listItem, forKey:"listItem")
            
            curTableView.selectedBackgroundView = UIView(frame:curTableView.frame)
            curTableView.selectedBackgroundView?.backgroundColor = UIColor.selectCellSColor()
            
            return curTableView
        }else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.dataSources.count > 0 {
            let listItem = self.dataSources[indexPath.row]
            let result = self.distributionListCurrentCellHeightWithTableView(tableView, listItem:listItem)
            return CGFloat(result)
        } else {
            return 0
        }
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
