//
//  LoginPageViewController.h
//  EasyRenting
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginPageViewController : UIViewController

@property (strong, nonatomic) UIImageView *loginImageView;//logo

@property (strong, nonatomic) UIView *loginView;

@property (strong, nonatomic) UITextField *loginNameText;

@property (strong, nonatomic) UITextField *loginPwdText;

@property (strong, nonatomic) UIButton *loginBtn;//登录

@property (strong, nonatomic) UIButton *forgetBtn;//忘记密码

@property (strong, nonatomic) UIButton *backBtn;//返回

@property (strong, nonatomic) UIButton *createAccountBtn;//注册账户

@property (strong, nonatomic) UILabel *lineLabel;

@property (strong, nonatomic) NSArray *arr;

@end
