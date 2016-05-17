//
//  HouseStyleViewController.h
//  EasyRenting
//
//  Created by administrator on 16/3/29.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HouseStyleViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (copy, nonatomic) NSString *titleStr;
@property (copy, nonatomic) NSString *cityName;
@property (copy, nonatomic) NSString *provinceName;
@property (copy, nonatomic) NSString *houseStyle;

@property (strong, nonatomic) UIView *headView; //上方导航栏位置视图
@property (strong, nonatomic) UIButton *backBtn; //导航栏上的返回上一页按钮
@property (strong, nonatomic) UILabel *titleName; //地区名
@property (strong, nonatomic) UITableView *myTable;

@property (strong, nonatomic) UITableView *rentTable; //租金table
@property (strong, nonatomic) UITableView *apartmentTable; //户型table
@property (strong, nonatomic) UITableView *sequenceTable; //排序table
@end
