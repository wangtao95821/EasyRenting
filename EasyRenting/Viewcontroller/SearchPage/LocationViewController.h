//
//  LocationViewController.h
//  EasyRenting
//
//  Created by administrator on 16/4/19.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UIView *headView; //上方导航栏位置视图
@property (strong, nonatomic) UIButton *backBtn; //导航栏上的返回上一页按钮
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UITableView *myTable;

@property (strong ,nonatomic) UILabel *blankLabel;

@end
