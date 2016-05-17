//
//  SearchPageViewController.h
//  EasyRenting
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RongIMKit/RongIMKit.h>
@interface SearchPageViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) UIView *headView; //上方导航栏位置视图
@property (strong, nonatomic) UIButton *cityNameBtn; //导航栏上的选择城市按钮
@property (strong, nonatomic) UITextField *searchText; //搜索框
@property (strong, nonatomic) UITableView *myTable; //展示信息的tableView
@property (strong, nonatomic) UIButton *searchBtn; //搜索按钮
@property (strong, nonatomic) UIView *blankView;  //遮挡view
@property (strong, nonatomic) UIButton *locationBtn;

@property (strong, nonatomic) UILabel *blankLabel;

@property (strong, nonatomic) NSString *provinceStr;

- (instancetype)initWithPath:(NSString *)KeyPath;

@end
