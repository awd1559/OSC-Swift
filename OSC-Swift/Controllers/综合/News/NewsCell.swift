//
//  OSCInformationTableViewCell.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/16.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit
import YYKit
import SnapKit

let kNewsCellID = "kNewsCellID"

class NewsCell: UITableViewCell {
    var listItem: OSCListItem?
    var showCommentCount: Bool = false
    var showViewCount: Bool = false
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.newTitleColor()
        label.font = UIFont.systemFont(ofSize: CGFloat(informationCell_titleLB_Font_Size))
        label.numberOfLines = 2
        return label
    }()
    
    var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.newSecondTextColor()
        label.font = UIFont.systemFont(ofSize: CGFloat(informationCell_descLB_Font_Size))
        label.numberOfLines = 2
        return label
    }()
    
    var timeLabel: YYLabel = {
        let label = YYLabel()
        label.textColor = UIColor.newAssistTextColor()
        label.font = UIFont.systemFont(ofSize: CGFloat(informationCell_infoBar_Font_Size))
        return label
    }()
    
    var commentIcon: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        icon.image = R.image.ic_comment()
        return icon
    }()
    
    var commentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.newAssistTextColor()
        label.font = UIFont.systemFont(ofSize: CGFloat(informationCell_infoBar_Font_Size))
        return label
    }()
    
    var viewIcon: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        icon.image = R.image.ic_view()
        icon.isHidden = true
        return icon
    }()
    
    var viewLabel: YYLabel = {
       let label = YYLabel()
        label.textColor = UIColor.newAssistTextColor()
        label.font = UIFont.systemFont(ofSize:CGFloat(informationCell_infoBar_Font_Size))
        label.isHidden = true
        return label
    }()
    
    lazy var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xC8C7CC).withAlphaComponent(0.7)
        return view
    }()
    
    static var rowHeight: CGFloat {
        get {
            return 20
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(contentLabel)
        self.contentView.addSubview(timeLabel)
        self.contentView.addSubview(commentIcon)
        self.contentView.addSubview(commentLabel)
        self.contentView.addSubview(viewIcon)
        self.contentView.addSubview(viewLabel)
        self.contentView.addSubview(bottomLine)
        bottomLine.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(cell_padding_left)
            make.bottom.equalToSuperview().offset(1)
            make.width.equalToSuperview()
            make.height.equalTo(1)
        }
        //layout in OSCListItem.m infomationLayoutHeight
        //FIXME:
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
