//
//  SearchInfoViewController.h
//  EasyRenting
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchInfoViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UIView *headView; //上方导航栏位置视图
@property (strong, nonatomic) UIButton *backBtn; //导航栏上的返回上一页按钮
@property (strong, nonatomic) UITextField *searchText; //搜索框
@property (strong, nonatomic) UITableView *myTable;
@property (strong, nonatomic) UIButton *searchBtn; //搜索按钮
@property (strong, nonatomic) UIView *blankView;  //遮挡view

@property (copy, nonatomic) NSString *searchStr;
@property (copy, nonatomic) NSString *cityStr;

@property (strong, nonatomic) UILabel *blankLabel;

@end
