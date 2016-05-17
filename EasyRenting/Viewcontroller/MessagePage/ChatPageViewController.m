//
//  ChatPageViewController.m
//  EasyRenting
//
//  Created by administrator on 16/3/31.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "ChatPageViewController.h"
#import "Define.h"
@interface ChatPageViewController ()

@end

@implementation ChatPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //把原先的顶部导航隐藏，使用自定义的view代替
    self.navigationController.navigationBar.hidden = YES;
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    self.headView.backgroundColor = COLOR(243, 198, 1, 1);
    [self.view addSubview:self.headView];
    
    self.backBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH5S(3), 32, WIDTH5S(25), WIDTH5S(25))];
    [self.backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:self.backBtn];
    
    self.contactsName = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(101), 32, WIDTH5S(118), 20)];
    self.contactsName.font = [UIFont systemFontOfSize:15.0];
    self.contactsName.textColor = COLOR(254, 252, 192, 1);
    self.contactsName.textAlignment = NSTextAlignmentCenter;
    self.contactsName.text = self.targetId;
    [self.headView addSubview:self.contactsName];
    
    
    [self.pluginBoardView removeItemAtIndex:2];
    self.conversationMessageCollectionView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-50);
    
    
    
}


/*!
 即将显示消息Cell的回调
 
 @param cell        消息Cell
 @param indexPath   该Cell对应的消息Cell数据模型在数据源中的索引值
 
 @discussion 您可以在此回调中修改Cell的显示和某些属性。
 */
- (void)willDisplayMessageCell:(RCMessageBaseCell *)cell
                   atIndexPath:(NSIndexPath *)indexPath
{
    
    RCMessageCell *testcell = (RCMessageCell *)cell;
    testcell.nicknameLabel.hidden = YES;
    
    
    
    CGRect rect = testcell.messageContentView.frame;
    rect.origin.y = 15;
    testcell.messageContentView.frame = rect;
    

}

/*!
 即将显示消息Cell的回调
 
 @param cell        消息Cell
 @param indexPath   该Cell对应的消息Cell数据模型在数据源中的索引值
 
 @discussion 您可以在此回调中修改Cell的显示和某些属性。
 */




- (void)back{
    
    if (self.isOnePage == YES) {
        [self.navigationController popViewControllerAnimated:YES];
        self.tabBarController.hidesBottomBarWhenPushed = NO;
    }else{
        [self.navigationController popViewControllerAnimated:YES];
        self.tabBarController.hidesBottomBarWhenPushed = YES;
    }
    
    
    
}

@end
