//
//  MessagePageViewController.m
//  EasyRenting
//
//  Created by administrator on 16/3/31.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MessagePageViewController.h"
#import "Define.h"
#import "ChatPageViewController.h"
@interface MessagePageViewController ()

@end

@implementation MessagePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.isShowNetworkIndicatorView = NO;
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    //把原先的顶部导航隐藏，使用自定义的view代替
    self.navigationController.navigationBar.hidden = YES;
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    self.headView.backgroundColor = COLOR(243, 198, 1, 1);
    [self.view addSubview:self.headView];
    
        self.contactsList = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(101), 32, WIDTH5S(118), 20)];
    self.contactsList.font = [UIFont systemFontOfSize:15.0];
    self.contactsList.textColor = COLOR(254, 252, 192, 1);
    self.contactsList.textAlignment = NSTextAlignmentCenter;
    self.contactsList.text = @"消息人列表";
    [self.headView addSubview:self.contactsList];
    
    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE)]];
    //设置需要将哪些类型的会话在会话列表中聚合显示
    [self setCollectionConversationType:@[@(ConversationType_DISCUSSION),
                                          @(ConversationType_GROUP)]];
    
    self.conversationListTableView.tableFooterView = [[UIView alloc]init];
    self.conversationListTableView.frame = CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT-44-48);
//    self.conversationListTableView.backgroundColor = [UIColor yellowColor];

    //去掉列表为空显示的view上的字
    CGRect rect = self.emptyConversationView.frame;
    rect.origin.x = 0;
    rect.origin.y = rect.size.height - 20;
    rect.size.height = 20;
    UIView *myView = [[UIView alloc]initWithFrame:rect];
    myView.backgroundColor = [UIColor whiteColor];
    [self.emptyConversationView addSubview:myView];
}

//重写RCConversationListViewController的onSelectedTableRow事件
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    //    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    ChatPageViewController *conversationVC = [[ChatPageViewController alloc]init];
    conversationVC.conversationType = model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.title = @"想显示的会话标题";
    conversationVC.isOnePage = YES;
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:conversationVC animated:YES];
    
}

- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion{
    
    if ([@"789654" isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"789654";
        user.name = @"随便";
        user.portraitUri = @"http://img4.duitang.com/uploads/item/201405/10/20140510180701_HaMGF.jpeg";
        return completion(user);
    }else if ([@"250" isEqual:userId]){
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"250";
        user.name = @"我的";
        user.portraitUri = @"http://img4.duitang.com/uploads/item/201602/23/20160223104150_x2jAC.jpeg";
        return completion(user);
        
    }
    return completion(nil);
}


@end
