//
//  RentRecordViewController.h
//  EasyRenting
//
//  Created by administrator on 16/4/11.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RentRecordViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *manageTable;

@property (strong, nonatomic) NSMutableArray *recordArr;

@property (strong, nonatomic) NSArray *gggggg;

@property (strong, nonatomic) UILabel *label;

@end
