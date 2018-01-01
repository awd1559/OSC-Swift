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

func attributedTitle(menuItem: OSCMenuItem, listItem: OSCListItem) -> NSAttributedString {
    var attr = NSMutableAttributedString()
    switch(menuItem.type) {
    case .info:
        if menuItem.subtype == 1 {
            attr.append(iconAttribute(R.image.ic_label_today()))
        }
    case .software:
        attr.append(iconAttribute(R.image.ic_label_today()))
    case .blog:
        attr.append(iconAttribute(R.image.ic_label_today()))
        if listItem.isRecommend {
            attr.append(iconAttribute(R.image.ic_label_recommend()))
        }
        if listItem.isOriginal {
            attr.append(iconAttribute(R.image.ic_label_originate()))
        } else {
            attr.append(iconAttribute(R.image.ic_label_reprint()))
        }
    case .translation:
        attr.append(iconAttribute(R.image.ic_label_today()))
    default:
        break
    }
    
    let titleAttr = NSAttributedString(string: listItem.title, attributes:[NSAttributedStringKey.font : UIFont.systemFont(ofSize: blogCell_titleLB_Font_Size)])
    attr.append(titleAttr)
    
    return attr
}

func attributeTime(menuItem: OSCMenuItem, listItem: OSCListItem) -> NSAttributedString {
    var attr = NSMutableAttributedString()
    if menuItem.token == "b4ca1962b3a80823c6138441015d9836" {
        attr.append(NSAttributedString(string: listItem.pubDate + " "))
    } else {
        attr.append(NSAttributedString(string: (listItem.author?.name ?? "") + listItem.pubDate + " "))
    }
    attr.addAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 10)], range: NSMakeRange(0, attr.length))
    attr.color = UIColor.newAssistTextColor()
    
    return attr
}

func iconAttribute(_ image: UIImage?) -> NSAttributedString {
    var attr = NSMutableAttributedString()
    
    guard let image = image else {
        return attr
    }
    var textAttachment = NSTextAttachment()
    textAttachment.image = image
    textAttachment.adjustY(-3)
    attr.append(NSAttributedString(attachment: textAttachment))
    attr.append(NSAttributedString(string: " "))

    return attr
}

class NewsCell: UITableViewCell {
    var menuItem = OSCMenuItem()
    var listItem: OSCListItem? {
        willSet {
            if listItem?.id == newValue?.id {
                return
            }
        }
        didSet {
            self.titleLabel.attributedText = attributedTitle(menuItem: menuItem, listItem: listItem!)
            self.bodyLabel.text = listItem?.body
            self.timeLabel.attributedText = attributeTime(menuItem: menuItem, listItem: listItem!)
            
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
}
