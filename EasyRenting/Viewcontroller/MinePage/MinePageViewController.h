//
//  MinePageViewController.h
//  EasyRenting
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MinePageViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) UITableView *mineTableView;

@property (strong, nonatomic) UIImageView *mineHeadBCEFFECTImageView;//毛玻璃背景

@property (strong, nonatomic) UIImageView *mineHeadImageView;//头像


@property (strong, nonatomic) UIButton *mineLoginBtn;//登录

@property (strong, nonatomic) UIButton *mineRegisterBtn;//注册

@property (strong, nonatomic) UILabel *mineLineLabel;//线


@property (strong, nonatomic) UIBlurEffect *blurEffect;

@property (strong, nonatomic) UIVisualEffectView *effectView;



@property (strong, nonatomic) UIView *myview;
@property (strong, nonatomic) UIView *bkView;
@property (assign, nonatomic) BOOL isxiaoshi;

@property (strong, nonatomic) UIButton *housePicBtn;
@property (strong, nonatomic) UIImageView *ima;


@property (strong, nonatomic) UIButton *exitBtn;


//@property (copy, nonatomic) NSString *minStr;



@property (copy, nonatomic) NSString *imaStr;

@property (copy, nonatomic) NSString *str5;
@property (strong, nonatomic) UIImage *imageMyNes;

@property (strong, nonatomic) NSMutableArray *labelArr1;

@property (strong, nonatomic) NSDictionary *diccc;


@property (assign, nonatomic) BOOL islogin;


@property (strong, nonatomic) UILabel *loginNameLabel;//登录之后名字

@end
