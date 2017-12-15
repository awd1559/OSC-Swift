//
//  OSCAPI.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/15.
//  Copyright © 2017年 awd. All rights reserved.
//

/** webView hock images */
let OSC_Instation_Static_Image_Path          = "https://static.oschina.net/uploads/space"
let OSC_Instation_Static_Image_Path_http     = "http://static.oschina.net/uploads/space"

let downloaded_noti_name                     = "webViewHockImageDownloaded"
let WebViewImage_Notication_IsDownloaded_Key = "isDownloaded"
let WebViewImage_Notication_UseImagePath_Key = "useImagePath"
/** webView hock images */

let OSCAPI_PREFIX                 = "https://www.oschina.net/action/api/"
let OSCAPI_V2_PREFIX              = "https://www.oschina.net/action/apiv2/"

//#define OSCAPI_PREFIX                 @"http://www.oschina.cc/action/api/"
//#define OSCAPI_V2_PREFIX              @"http://www.oschina.cc/action/apiv2/"

//#define OSCAPI_PREFIX                 @"http://192.168.1.25:9090/action/api/"

//#define OSCAPI_V2_PREFIX              @"http://192.168.1.25:9090/action/apiv2/"

let AppToken                        = Utils.getAppToken()

let OSCAPI_GIT_PREFIX               = "https://gitee.com/api/v3/"

let OSCAPI_SUFFIX                   = "pageSize=20"

let OSCAPI_NEWS_LIST                = "news_list"
let OSCAPI_NEWS_DETAIL              = "news"
let OSCAPI_BLOGS_LIST               = "blog"

let OSCAPI_DETAIL                   = "detail"

let OSCAPI_POSTS_LIST               = "post_list"
let OSCAPI_POST_DETAIL              = "post_detail"
let OSCAPI_POST_PUB                 = "post_pub"

let OSCAPI_TWEETS_LIST              = "tweet_list"
let OSCAPI_TWEETS                   = "tweets"
let OSCAPI_TWEETS_TOPIC             = "tweet_topic"
let OSCAPI_TWEET_DETAIL             = "tweet_detail"
let OSCAPI_TWEET_DELETE             = "tweet_delete"
let OSCAPI_TWEET_PUB                = "tweet_pub"
let OSCAPI_TWEET_LIKE               = "tweet_like"
let OSCAPI_TWEET_UNLIKE             = "tweet_unlike"
let OSCAPI_TWEET_LIKE_REVERSE       = "tweet_like_reverse"
let OSCAPI_PUT_TWEET                = "tweet"
let OSCAPI_RESOURCE_IMAGE           = "resource_image" //动弹上传图片

let OSCAPI_TWEET_LIKE_LIST          = "tweet_like_list"
let OSCAPI_MY_TWEET_LIKE_LIST       = "my_tweet_like_list"
let OSCAPI_SOFTWARE_TWEET_PUB       = "software_tweet_pub"
let OSCAPI_TWEET_TOPIC_LIST         = "tweet_topic_list"
let OSCAPI_TWEET_BLOG_LIST          = "263ee86f538884e70ee1ee50aed759b6" //每日乱弹


//新动弹接口
let OSCAPI_TWEET_LIKES              = "tweet_likes"      //点赞列表
let OSCAPI_TWEET_COMMENTS           = "tweet_comments"   //评论列表
let OSCAPI_TWEET_TOPICS             = "tweet_topics"     //话题动弹

let OSCAPI_INFORMATION_SUB_ENUM     = "sub_menu"
let OSCAPI_INFORMATION_LIST         = "sub_list"
let OSCAPI_BANNER                   = "banner"

let OSCAPI_ACTIVE_LIST              = "active_list"

let OSCAPI_GET_USER_INFO            = "user_info"//获取自己/某人的信息
let OSCAPI_MESSAGES_LIST            = "user_msg_letters"//消息中心_私信我的列表
let OSCAPI_MESSAGES_ATME_LIST       = "user_msg_mentions"//消息中心_@我的列表
let OSCAPI_MESSAGES_COMMENTS_LIST   = "user_msg_comments"//消息中心_评论列表
let OSCAPI_MESSAGE_CHAT_LIST        = "messages"//获取与某人的私信列表
let OSCAPI_MESSAGE_DELETE           = "message_delete"
let OSCAPI_MESSAGES_PUB             = "messages_pub" //发送私信给某人
let OSCAPI_MESSAGE_PUB              = "message_pub"//给某人发送私信
let OSCAPI_MESSAGE_CLEAR            = "notice_clear"

let OSCAPI_COMMENTS_LIST            = "comment_list"
let OSCAPI_COMMENTS_LIST_TWEET      = "tweet_comment"
let OSCAPI_COMMENT_PUB              = "comment_pub"
let OSCAPI_COMMENT_REPLY            = "comment_reply"
let OSCAPI_COMMENT_DELETE           = "comment_delete"
let OSCAPI_COMMENT_PUSH             = "comment_push"
let OSCAPI_COMMENT_DETAIL           = "comment_detail"
let OSCAPI_COMMENT_VOTE_REVERSE     = "comment_vote_reverse"

let OSCAPI_LOGIN_VALIDATE           = "login_validate"
let OSCAPI_MY_INFORMATION           = "my_information"
let OSCAPI_USER_INFORMATION         = "user_information"
let OSCAPI_USER_UPDATERELATION      = "user_updaterelation"
let OSCAPI_USER_RELATION_REVERSE    = "user_relation_reverse"//关注
let OSCAPI_USERINFO_UPDATE          = "portrait_update"
let OSCAPI_NOTICE_CLEAR             = "notice_clear"

let OSCAPI_SOFTWARE                 = "software"
let OSCAPI_SOFTWARE_DETAIL          = "software_detail"
let OSCAPI_BLOG_DETAIL              = "blog_detail"
let OSCAPI_BLOG_CATEGORY            = "get_blog_category"
let OSCAPI_PUB_BLOG                 = "pub_blog"

let OSCAPI_FAVORITE_LIST            = "favorite_list"
let OSCAPI_FAVORITE_ADD             = "favorite_add"
let OSCAPI_FAVORITE_DELETE          = "favorite_delete"
let OSCAPI_FAVORITES                = "favorites"

let OSCAPI_SEARCH                   = "search"
let OSCAPI_SEARCH_LIST              = "search_list"
let OSCAPI_FRIENDS_LIST             = "friends_list"
let OSCAPI_SOFTWARECATALOG_LIST     = "softwarecatalog_list"
let OSCAPI_SOFTWARE_LIST            = "software_list"
let OSCAPI_SOFTWARETAG_LIST         = "softwaretag_list"
let OSCAPI_SOFTWARE_TWEET_LIST      = "software_tweet_list"

let OSCAPI_BLOGCOMMENTS_LIST        = "blogcomment_list"
let OSCAPI_BLOGCOMMENT_PUB          = "blogcomment_pub"
let OSCAPI_BLOGCOMMENT_DELETE       = "blogcomment_delete"

let OSCAPI_USERBLOG_DELETE          = "userblog_delete"
let OSCAPI_USERBLOGS_LIST           = "userblog_list"

let OSCAPI_DELETE_BLOG              = "delete_blog"

let OSCAPI_REPORT                   = "communityManage/report"

let OSCAPI_SEARCH_USERS             = "find_user"
let OSCAPI_RANDOM_MESSAGE           = "rock_rock"
let OSCAPI_RANDOM_SHAKING_NEW       = "shake_news"
let OSCAPI_RANDOM_SHAKING_GIFT      = "shake_present"
let OSCAPI_EVENT_LIST               = "event_list"
let OSCAPI_EVENT_APPLY              = "event_apply"
let OSCAPI_EVENT_ATTEND_USER        = "event_attend_user"
let OSCAPI_EVENT_APPLY_INFO         = "event_apply_info"
let OSCAPI_EVENT                    = "event"

let OSCAPI_USER_REPORT_TO_ADMIN     = "user_report_to_admin"
let OSCAPI_OPENID_LOGIN             = "openid_login"
let OSCAPI_OPENID_BINDING           = "openid_bind"
let OSCAPI_OPENID_REGISTER          = "openid_reg"

let OSCAPI_QUESTION                 = "question"         //问答列表
let OSCAPI_QUESTION_VOTE            = "question_vote"

let OSCAPI_ACTIVITY                 = "user_activity"    //动态（讨论）列表

let OSCAPI_USER_FOLLOWS             = "user_follows"
let OSCAPI_USER_FANS                = "user_fans"

let OSCAPI_ACCOUNT_LOGIN            = "account_login" //登录
let OSCAPI_ACCOUNT_OPEN_LOGIN       = "account_open_login" //第三方登录
let OSCAPI_ACCOUNT_REGISTER         = "account_register" //注册
let OSCAPI_PHONE_SEND_CODE          = "phone_send_code" // 手机、验证码、换取Token信息 第一步
let OSCAPI_PHONE_VALIDATE           = "phone_validate" // 手机、验证码、换取Token信息 第二步
let OSCAPI_ACCOUNT_PASSWORD_FORGET  = "account_password_forgot" //找回密码

let OSCAPI_EVENT_SIGNIN             = "event_signin" //报名签到
let OSCAPI_EVENT_APPLY_PRELOAD      = "event_apply_preload"  //报名预拉取
let OSCAPI_EVENT_ATTENDEE_LIST      = "event_attendee_list"
let OSCAPI_EVENT_APPLY_CANCEL       = "event_apply_cancel" //取消报名

let OSCAPI_FAVORITE_REVERSE         = "favorite_reverse" //收藏
let OSCAPI_USER_EDIT_PORTRAIT       = "user_edit_portrait" //上传头像
let OSCAPI_NOTICE                   = "notice" //消息监听


let OSCAPI_GISTS                    = "gists/"
let OSCAPI_GISTS_PUBLIC             = "gists/public" //代码片段广场
let OSCAPI_GISTS_COMMENTS_COUNT     = "gist_comments_count" //评论数

/************* 用户信息收集 ************/
let OSCAPI_USER_BEHAVIORS_COLLECT_ADD  = "user_behaviors_collect/add"//用户阅读信息搜集
//http://61.145.122.155:8080/apiv2/user_behaviors_collect/add

/************* 用户个人信息修改 ************/

let OSCAPI_USER_EDIT_INFOS          = "user_edit_infos"//用户信息修改



/** 处理本地存储 */
let EMPTY_STRING        = ""

func STR(key:String) -> String {
    return NSLocalizedString(key, comment: "")
}

let PATH_OF_APP_HOME    = NSHomeDirectory()
let PATH_OF_TEMP        = NSTemporaryDirectory()
let PATH_OF_DOCUMENT    = NSSearchPathForDirectoriesInDomains(.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
