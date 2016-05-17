//
//  RegisterPageViewController.h
//  EasyRenting
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterPageViewController : UIViewController

@property (strong, nonatomic) UILabel *registerLabel;

@property (strong, nonatomic) UITextField *registerNameText;

@property (strong, nonatomic) UITextField *registerPwdText;

@property (strong, nonatomic) UIButton *registerBtn;//注册

@property (strong, nonatomic) UILabel *lineLabel;

@property (strong, nonatomic) UIButton *alreadyRegister;//已有账户

@end
