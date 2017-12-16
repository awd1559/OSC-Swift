//
//  OSCListItem.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/14.
//  Copyright © 2017年 awd. All rights reserved.

//
//#import "OSCExtra.h"
//#import "OSCAbout.h"
//#import "OSCStatistics.h"
//#import "OSCNetImage.h"

/** nomal setting*/
let kScreen_bound_width  = UIScreen.main.bounds.size.width
let cell_padding_left = 16
let cell_padding_right = cell_padding_left
let cell_padding_top = 16
let cell_padding_bottom = cell_padding_top
let fontLineSpace = 10

/** SPACE:垂直方向的间距 space:水平方向的间距*/
/** blog cell setting*/
let blogCell_titleLB_Font_Size = 15
let blogCell_descLB_Font_Size = 13
let blogCell_titleLB_SPACE_descLB = 4
let blogCell_descLB_SPACE_infoBar = 6
let blogCell_infoBar_Height = 13

/** activity cell setting (固定高度)*/
let activityCell_rowHeigt = 122

/** questions cell setting*/
let questionsCell_titleLB_Font_Size = 15
let questionsCell_descLB_Font_Size = 14
let questionsCell_infoLB_Font_Size = 10

let questionsCell_titleLB_Padding_Left = 70
let questionsCell_descLB_Padding_Left = 70
let questionsCell_titleLB_SPACE_descLB = 5
let questionsCell_descLB_SPACE_infoBar = 6

let questionsCell_count_icon_count_space = 2
let questionsCell_icon_count_icon_space = 12
let questionsCell_icon_width = 13
let questionsCell_icon_height = 10
let questionsCell_infoBar_Height = 14

/** information cell setting*/
let informationCell_titleLB_Font_Size = 15
let informationCell_descLB_Font_Size = 13
let informationCell_infoBar_Font_Size = 10
let informationCell_titleLB_SPACE_descLB = 5
let informationCell_descLB_SPACE_infoBar = 8
let informationCell_infoBar_Height = 14

let informationCell_count_icon_count_space = 2
let informationCell_icon_count_icon_space = 12
let informationCell_icon_width = 13
let informationCell_icon_height = 10

/*  QuestionCell_LayoutInfo cell setting  */
let blogsCell_titleLB_Font_Size = 15
let blogsCell_descLB_Font_Size = 14
let blogsCell_infoLB_Font_Size = 10

//#define blogsCell_titleLB_Padding_Left 16
//#define blogsCell_descLB_Padding_Left 16
let blogsCell_titleLB_SPACE_descLB = 5
let blogsCell_descLB_SPACE_infoBar = 6

let blogsCell_count_icon_count_space = 2
let blogsCell_icon_count_icon_space = 12
let blogsCell_icon_width = 13
let blogsCell_icon_height = 10
let blogsCell_infoBar_Height = 14

enum OSCListCellType: Int {
    case nomal = 0
    case singlespecial,
    divide, larger, unkonw
}

//@class OSCAuthor, OSCRecommendSoftware, InformationCell_layoutInfo, QuestionCell_LayoutInfo, BlogCell_LayoutInfo,OSCMenuItem;

/** OSCListItem 被分栏列表和对应详情共用 */

struct OSCListItem {

    var  menuItem: OSCMenuItem

    var id: Int

    var title: String

    var attributedTitle: NSAttributedString

    var body: String

    var pubDate: String

    var href: String

    var favorite: Bool

    var summary: String

    var type: InformationType

    var author: OSCAuthor

    var images: [OSCNetImage]

    var tags: [String]
    var isRecommend, isOriginal, isAd, isStick , isToday: Bool

    var statistics: OSCStatistics

    var extra: OSCExtra

    var abouts: [OSCAbout]

    var software: OSCRecommendSoftware

    var cellType: OSCListCellType

    //layout info
    func getLayoutInfo() {}
    var rowHeight: Float///全部cell使用到info
    var informationLayoutInfo: InformationCell_layoutInfo///咨询列表cell使用到的info
    var questionLayoutInfo:QuestionCell_LayoutInfo //问答列表cell
    var blogLayoutInfo: BlogCell_LayoutInfo //博客列表cell
}



struct OSCAuthor {

    var id: Int

    var name: String

    var portrait: String

    var relation: UserRelationStatus

    var identity: OSCUserIdentity
}



struct OSCRecommendSoftware {

    var id: Int

    var name: String

    var href: String
}


//#pragma mark - Asynchronous display layout info
/** layout info Class */
struct InformationCell_layoutInfo {
    var titleLbFrame: CGRect
    var contentLbFrame: CGRect
    var timeLbFrame: CGRect
    var viewCountImgFrame: CGRect
    var viewCountLbFrame: CGRect
    var commentImgFrame: CGRect
    var commentCountLbFrame: CGRect
}

/*  question layout info   */
struct QuestionCell_LayoutInfo {
    var  protraitImgFrame: CGRect
    var  titleLbFrame: CGRect
    var descLbFrame: CGRect
    var userNameLbFrame: CGRect
    var timeLbFrame: CGRect
    var viewCountImgFrame: CGRect
    var viewCountLbFrame: CGRect
    var commentCountImgFrame: CGRect
    var commentCountLbFrame: CGRect
}

struct BlogCell_LayoutInfo {
    var titleLbFrame: CGRect
    var descLbFrame: CGRect
    var userNameLbFrame: CGRect
    var timeLbFrame: CGRect
    var viewCountImgFrame: CGRect
    var viewCountLbFrame: CGRect
    var commentCountImgFrame: CGRect
    var commentCountLbFrame: CGRect

}
