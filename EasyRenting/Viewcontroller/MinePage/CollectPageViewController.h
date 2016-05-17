//
//  CollectPageViewController.h
//  EasyRenting
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectPageViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *collectTable;

@property (strong, nonatomic) NSMutableArray *FMutArr;

@property (strong, nonatomic) UILabel *collectLabel;

@end
