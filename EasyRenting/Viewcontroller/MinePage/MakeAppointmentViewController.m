//
//  MakeAppointmentViewController.m
//  EasyRenting
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MakeAppointmentViewController.h"
#import "Define.h"
@interface MakeAppointmentViewController ()

@end

@implementation MakeAppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    
    navView.backgroundColor = NAVIGATIONCOLOR;
    
    [self.view addSubview:navView];
    
    UILabel *navTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH5S(100), 20, WIDTH5S(120), 44)];
    
    navTitleLabel.text = @"功能介绍";
    
    navTitleLabel.font = FONT(15);
    
    navTitleLabel.textColor = COLOR(255, 253, 193, 1);
    
    navTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    [navView addSubview:navTitleLabel];
    
    //导航栏上的返回键
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 60, 44)];
    
    [backBtn addTarget:self action:@selector(BACK) forControlEvents:UIControlEventTouchUpInside];
    
    [navView addSubview:backBtn];
    
    UIImageView *backIma = [[UIImageView alloc]initWithFrame:CGRectMake(2, 10, 25, 25)];
    backIma.image = [UIImage imageNamed:@"back_select@2x"];
    [backBtn addSubview:backIma];
    
   
    
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(15, HEIGHT5S(0), WIDTH5S(290), HEIGHT5S(300))];
    
    self.label.numberOfLines = 0;
    
    self.label.textColor = SMALLWORD;
    
    self.label.text = @"本产品是一款生活类租房软件，适用于广大人群，可以出租房屋和租房。本产品推出二维码扫描的功能，当确定租房时，向房东扫描房屋的二维码可以有些优惠并且选择要租的房屋，完成出租。房东的话，当房客扫完二维码时，并不需要房东自己点击完成出租，方便又省事。";
    
    self.label.font = FONT(15);
    
    [self.view addSubview:self.label];
    
}

- (void)BACK{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}

@end
