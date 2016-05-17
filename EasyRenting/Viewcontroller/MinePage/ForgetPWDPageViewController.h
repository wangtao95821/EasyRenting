//
//  ForgetPWDPageViewController.h
//  EasyRenting
//
//  Created by administrator on 16/4/9.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPWDPageViewController : UIViewController


@property (strong, nonatomic) UITextField *Text;

@property (strong, nonatomic) UIButton *sendBtn;

@property (strong, nonatomic) UIButton *finishBtn;

@property (strong, nonatomic) UILabel *label;

@property (strong, nonatomic) UILabel *secondLabel;

@property (assign, nonatomic) int k;



@property (strong, nonatomic) NSTimer *timer;


@property (strong, nonatomic) UILabel *registerLabel;

@property (strong, nonatomic) UITextField *registerNameText;

@property (strong, nonatomic) UITextField *registerPwdText;
@property (strong, nonatomic) UITextField *registerPwd1Text;

@property (strong, nonatomic) UIButton *registerBtn;//注册

@end
