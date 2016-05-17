//
//  HomePageViewController.h
//  EasyRenting
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectCityDelegate <NSObject>

- (void)showCityName:(NSDictionary *)dic;

@end

@interface HomePageViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,SelectCityDelegate>

@property (strong, nonatomic)UITableView *HomePageTableView;

@property (strong, nonatomic)UIScrollView *HomePageScrollView;

@property (strong, nonatomic)UIView *NavigationView;

@property (strong, nonatomic)NSArray *arr;

@property (strong, nonatomic)NSArray *arr1;

@end
