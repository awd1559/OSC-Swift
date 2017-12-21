//
//  OSCPushTypeControllerHelper.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/21.
//  Copyright © 2017年 awd. All rights reserved.
//

import UIKit

class OSCPushTypeControllerHelper {
    static func pushControllerGeneral(_ type: InformationType, id: Int) -> UIViewController? {
        assert(false, "没有实现 OSCPushTypeControllerHelper")
        return nil
//        switch type {
//        case .linknews:
//            return nil
//        case .software:{
//            let detailsViewController = SoftWareViewController(SoftWareID:id)
//            [detailsViewController setHidesBottomBarWhenPushed:YES];
//            return detailsViewController;
//            break;
//            }
//
//        case .forum:{
//            QuesAnsDetailViewController *detailVC = [[QuesAnsDetailViewController alloc] initWithDetailID:id];
//            detailVC.hidesBottomBarWhenPushed = YES;
//            return detailVC;
//            break;
//            }
//
//        case .blog:{
//            NewBlogDetailController* blogDetailVC = [[NewBlogDetailController alloc] initWithDetailId:id];
//            blogDetailVC.hidesBottomBarWhenPushed = YES;
//            return blogDetailVC;
//            break;
//            }
//
//        case .translation:{
//            TranslationViewController *translationVc = [[TranslationViewController alloc] initWithTranslationID:id];
//            translationVc.hidesBottomBarWhenPushed = YES;
//
//            return translationVc;
//            break;
//            }
//
//        case .activity:{
//            ActivityDetailViewController *activityDetailCtl = [[ActivityDetailViewController alloc] initWithActivityID:id];
//            activityDetailCtl.hidesBottomBarWhenPushed = YES;
//            return activityDetailCtl;
//            break;
//            }
//
//        case .info:{
//            OSCInformationDetailController* informationDetailController = [[OSCInformationDetailController alloc]initWithInformationID:id];
//            informationDetailController.hidesBottomBarWhenPushed = YES;
//            return informationDetailController;
//            break;
//            }
//
//        case .tweet:{
//            TweetDetailsWithBottomBarViewController *tweetDetailsBVC = [[TweetDetailsWithBottomBarViewController alloc] initWithTweetID:id];
//            return tweetDetailsBVC;
//            break;
//            }
//
//        default:{
//            return nil;
//            break;
//            }
//        }
    }
}
