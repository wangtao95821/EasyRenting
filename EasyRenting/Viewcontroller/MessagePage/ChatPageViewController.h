//
//  ChatPageViewController.h
//  EasyRenting
//
//  Created by administrator on 16/3/31.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>

@interface ChatPageViewController : RCConversationViewController

@property (strong, nonatomic) UIView *headView; //上方导航栏位置视图
@property (strong, nonatomic) UIButton *backBtn; //导航栏上的返回上一页按钮
@property (strong, nonatomic) UILabel *contactsName;

@property (assign, nonatomic) BOOL isOnePage;

@end
