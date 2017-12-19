//
//  InformationCell.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/14.
//  Copyright © 2017年 awd. All rights reserved.
//

import MBProgressHUD

let kInformationListCollectionViewCellIdentifier = "OSCInformationListCollectionViewCell"

//FIXME: OSCInformationListCollectionViewCellDelegate
protocol MenuCollectionCellDelegate {
    func cell(_ cell: MenuCollectionCell, update dataSourceDic:[String: InfoResultItem])
    
    func cell(_ cell: MenuCollectionCell, onclick tableViewCell: UITableViewCell,  push controller: UIViewController, url: String)
}

extension MenuCollectionCellDelegate {
    //optional
    func cell(_ cell: MenuCollectionCell, onclick banner: UIView, push controller: UIViewController, url:String) {
    }
}


//FIXME: OSCInformationListCollectionViewCell
class MenuCollectionCell: UICollectionViewCell {
    var delegate: MenuCollectionCellDelegate?
    var menuItem: OSCMenuItem?
    var pageToken: String?
    var offestDistance: Float?
    
    var HUD: MBProgressHUD?
//    optional_banner
//    var bannerScrollView: BannerScrollView?
//    var activityBannerView: ActivityHeadView?
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
    
        return tableView
    }()
    
    static func returnReuseInformationListCollectionViewCell(_ collectionView: UICollectionView,
                identifier: String, indexPath: IndexPath,  model:OSCMenuItem) -> MenuCollectionCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:identifier, for:indexPath) as! MenuCollectionCell
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
        
    }
    
    func configurationPostBackDictionary(_ resultItem: [String: InfoResultItem]) {
        
    }
}

//MARK: - UITableViewDelegate
extension MenuCollectionCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

//MARK: - UITableViewDataSource
extension MenuCollectionCell: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        if self.dataSources.count > 0 {
            return self.dataSources.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "infocell at \(indexPath.row) "
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.dataSources.count > 0 {
            let listItem = self.dataSources[indexPath.row]
            return 16
//            return self.distributionListCurrentCellHeightWithTableView(tableView, listItem:listItem)
        } else {
            return 0
        }
    }
}


class InfoResultItem {
    var bannerArr: [OSCBanner]?
    
    var tableViewArr: [OSCListItem]?
    
    var pageToken: String?
    
    var offestDistance: Float?
    
    var isFromCache: Bool?
}
