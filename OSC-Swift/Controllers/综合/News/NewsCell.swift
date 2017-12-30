//
//  OSCInformationTableViewCell.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/16.
//  Copyright © 2017年 awd. All rights reserved.
//

let kNewsCellID = "kNewsCellID"

class NewsCell: UITableViewCell {
    var listItem: OSCListItem?
    var showCommentCount: Bool = false
    var showViewCount: Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        
        let title = UILabel()
        title.text = "the information table view cell"
        self.contentView.addSubview(title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
