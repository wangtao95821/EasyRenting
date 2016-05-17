//
//  RegisterNextPageViewController.h
//  EasyRenting
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterNextPageViewController : UIViewController

@property (strong, nonatomic) UITextField *Text;

@property (strong, nonatomic) UIButton *sendBtn;

@property (strong, nonatomic) UIButton *finishBtn;

@property (strong, nonatomic) UILabel *label;

@property (copy, nonatomic) NSString *phonenumStr;

@property (copy, nonatomic) NSString *pwdnumStr;

@property (strong, nonatomic) UILabel *secondLabel;

@property (assign, nonatomic) int k;

@property (strong, nonatomic) NSTimer *timer;

@property (copy, nonatomic) NSString *strToken;

@end
