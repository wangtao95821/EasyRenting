//
//  MessagePageViewController.h
//  EasyRenting
//
//  Created by administrator on 16/3/31.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>

@interface MessagePageViewController : RCConversationListViewController<RCIMUserInfoDataSource>


@property (strong, nonatomic) UIView *headView; //上方导航栏位置视图

@property (strong, nonatomic) UILabel *contactsList;


@end
