//
//  DistrictPageViewController.h
//  EasyRenting
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DistrictPageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (copy, nonatomic) NSString *districtStr;
@property (copy, nonatomic) NSString *cityStr;
@property (strong, nonatomic) UIView *headView; //上方导航栏位置视图
@property (strong, nonatomic) UIButton *backBtn; //导航栏上的返回上一页按钮
@property (strong, nonatomic) UILabel *districtName; //地区名
@property (strong, nonatomic) UITableView *myTable;

@property (strong, nonatomic) UITableView *rentTable; //租金table
@property (strong, nonatomic) UITableView *apartmentTable; //户型table
@property (strong, nonatomic) UITableView *sequenceTable; //排序table

@property (strong, nonatomic) NSMutableArray *houseInfoArr; //房屋信息数组
@property (strong, nonatomic) NSMutableArray *resultArr; //处理后的房屋信息

@property (strong, nonatomic) UILabel *blankLabel;

@end
