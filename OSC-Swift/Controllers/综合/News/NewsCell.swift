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
    var listItem: OSCListItem? {
        willSet {
            if listItem?.id == newValue?.id {
                return
            }
        }
        didSet {
            self.titleLabel.text = listItem?.title
            self.bodyLabel.text = listItem?.body
            self.timeLabel.text = listItem?.author?.name
            
            if let comment = listItem?.statistics.comment {
                self.commentLabel.text = "\(comment)"
            } else {
                self.commentLabel.text = "0"
            }
//            self.viewLabel.text = "\(listItem?.statistics.view)"
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
//    var titleLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = UIColor.newTitleColor()
//        label.font = UIFont.systemFont(ofSize: informationCell_titleLB_Font_Size)
//        label.numberOfLines = 0
//        return label
//    }()
//
//    var bodyLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = UIColor.newSecondTextColor()
//        label.font = UIFont.systemFont(ofSize: informationCell_descLB_Font_Size)
//        label.numberOfLines = 0
//        return label
//    }()
//
//    var timeLabel: YYLabel = {
//        let label = YYLabel()
//        label.textColor = UIColor.newAssistTextColor()
//        label.font = UIFont.systemFont(ofSize: informationCell_infoBar_Font_Size)
//        return label
//    }()
//
//    var commentIcon: UIImageView = {
//        let icon = UIImageView()
//        icon.contentMode = .scaleAspectFit
//        icon.image = R.image.ic_comment()
//        return icon
//    }()
//
//    var commentLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = UIColor.newAssistTextColor()
//        label.font = UIFont.systemFont(ofSize: informationCell_infoBar_Font_Size)
//        return label
//    }()
//
//    var viewIcon: UIImageView = {
//        let icon = UIImageView()
//        icon.contentMode = .scaleAspectFit
//        icon.image = R.image.ic_view()
//        icon.isHidden = true
//        return icon
//    }()
//
//    var viewLabel: YYLabel = {
//       let label = YYLabel()
//        label.textColor = UIColor.newAssistTextColor()
//        label.font = UIFont.systemFont(ofSize:CGFloat(informationCell_infoBar_Font_Size))
//        label.isHidden = true
//        return label
//    }()
//
//    lazy var bottomLine: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor(hex: 0xC8C7CC).withAlphaComponent(0.7)
//        return view
//    }()
//
    static var rowHeight: CGFloat {
        get {
            return 20
        }
    }
    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.backgroundColor = .white
//        
//        self.contentView.addSubview(titleLabel)
//        self.contentView.addSubview(bodyLabel)
//        self.contentView.addSubview(timeLabel)
//        self.contentView.addSubview(commentIcon)
//        self.contentView.addSubview(commentLabel)
//        self.contentView.addSubview(viewIcon)
//        self.contentView.addSubview(viewLabel)
//        self.contentView.addSubview(bottomLine)
//        bottomLine.snp.makeConstraints{ make in
//            make.leading.equalToSuperview().offset(cell_padding_left)
//            make.bottom.equalToSuperview().offset(1)
//            make.width.equalToSuperview()
//            make.height.equalTo(1)
//        }
//        //layout in OSCListItem.m infomationLayoutHeight
//        
//        titleLabel.snp.makeConstraints{ make in
//            make.top.equalToSuperview().offset(cell_padding_top)
//            make.leading.equalToSuperview().offset(cell_padding_left)
//            make.width.equalTo(kScreen_bound_width - cell_padding_left - cell_padding_right)
//        }
//        bodyLabel.snp.makeConstraints{ make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(informationCell_titleLB_SPACE_descLB)
//            make.leading.equalToSuperview().offset(cell_padding_left)
//            make.width.equalTo(kScreen_bound_width - cell_padding_left - cell_padding_right)
//        }
//        timeLabel.snp.makeConstraints{ make in
//            make.leading.equalToSuperview().offset(cell_padding_left)
//            make.top.equalTo(bodyLabel.snp.bottom).offset(informationCell_descLB_SPACE_infoBar)
//            make.width.equalTo(informationCell_infoBar_Height)
//            make.height.equalTo(informationCell_infoBar_Height)
//        }
//        commentLabel.snp.makeConstraints{ make in
//            make.trailing.equalToSuperview().offset(cell_padding_right)
//            make.top.equalTo(bodyLabel.snp.bottom).offset(informationCell_descLB_SPACE_infoBar)
//            make.height.equalTo(informationCell_infoBar_Height)
//        }
//        commentIcon.snp.makeConstraints{ make in
//            make.trailing.equalTo(commentLabel.snp.leading).offset(informationCell_count_icon_count_space)
//            make.top.equalTo(bodyLabel.snp.bottom).offset(informationCell_descLB_SPACE_infoBar)
//            make.width.equalTo(informationCell_icon_width)
//            make.height.equalTo(informationCell_icon_height)
//        }
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
