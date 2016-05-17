//
//  RentingPageViewController.h
//  EasyRenting
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RentingPageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) UITableView *rentTable;//出租界面table

@property (strong, nonatomic) UITableView *rentTableF;//未出租界面
@property (strong, nonatomic) UITableView *rentTableY;//已出租界面

@property (strong, nonatomic) UIView *rentTableHeadView;//table的headView

@property (strong, nonatomic) UIView *btnView;//三个按钮View

@property (strong, nonatomic) UIButton *notRentBtn;//未出租

@property (strong, nonatomic) UIButton *orderBtn;//客户预约btn

@property (strong, nonatomic) UIButton *manageBtn;//房屋管理btn

@property (strong, nonatomic) UILabel *line1Label;//线

@property (strong, nonatomic) UILabel *line2Label;//线

@property (strong, nonatomic) NSArray *imageArr;//未出租房屋图片数组
@property (strong, nonatomic) NSArray *imageArrY;//未出租房屋图片数组

@property (strong, nonatomic) UIImageView *ScrollImage;//滚播图片

@property (strong, nonatomic) NSTimer *timer;//定时器

@property (assign, nonatomic) int l;//定时器需要--l

@property (strong, nonatomic) UIPageControl *pageControl;//小圆点

@property (strong, nonatomic) NSTimer *timer1;//定时器
@property (assign, nonatomic) int c;


//@property (strong, nonatomic) UIButton *scanBtn;//扫码btn


@property (assign, nonatomic) long int m;


@property (strong, nonatomic) UILabel *hudLabel1;

@property (strong, nonatomic) UILabel *hudLabel2;

@end
