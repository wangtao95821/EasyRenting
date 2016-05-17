//
//  ForgetPWDPageViewController.m
//  EasyRenting
//
//  Created by administrator on 16/4/9.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "ForgetPWDPageViewController.h"
#import "Define.h"
#import "LoginPageViewController.h"
@interface ForgetPWDPageViewController ()

@end

@implementation ForgetPWDPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.k = 60;
    
    self.view.backgroundColor = COLOR(244, 244, 245, 1);

    self.navigationController.navigationBar.hidden = YES;
    
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    
    navView.backgroundColor = NAVIGATIONCOLOR;
    
    [self.view addSubview:navView];
    
    UILabel *navTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 20, 120, 44)];
    
    navTitleLabel.text = @"忘记密码";
    
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

    
    self.Text = [[UITextField alloc]initWithFrame:CGRectMake(15, HEIGHT5S(124+200+20), WIDTH5S(195), HEIGHT5S(40))];
    
    self.Text.placeholder = @"    短信验证码";
    
    self.Text.font = FONT(13);
    
    [self.Text setBackgroundColor:[UIColor whiteColor]];
    
    self.Text.layer.cornerRadius = 5;
    
    [self.view addSubview:self.Text];
    
    self.sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(225, HEIGHT5S(124+200+20), WIDTH5S(80), HEIGHT5S(40))];
    
    [self.sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    
    self.sendBtn.titleLabel.font = FONT(15);
    
    self.sendBtn.backgroundColor = COLOR(243, 197, 1, 1);
    
    [self.sendBtn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.sendBtn.layer.cornerRadius = 5;
    
    [self.view addSubview:self.sendBtn];
    
    
    self.secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(225, HEIGHT5S(124+200+20), WIDTH5S(80), HEIGHT5S(40))];
    
    NSString *secondStr = [NSString stringWithFormat:@"%d",_k];
    
    self.secondLabel.text = secondStr;
    
    self.secondLabel.backgroundColor = [UIColor lightGrayColor];
    
    self.secondLabel.textColor = [UIColor whiteColor];
    
    self.secondLabel.layer.cornerRadius = 5;
    
    self.secondLabel.layer.masksToBounds = YES;
    
    self.secondLabel.textAlignment = NSTextAlignmentCenter;
    
    self.secondLabel.hidden = YES;
    
    [self.view addSubview:self.secondLabel];
    
    self.finishBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, HEIGHT5S(199+200+20), WIDTH5S(290), HEIGHT5S(40))];
    
    [self.finishBtn setTitle:@"取回密码" forState:UIControlStateNormal];
    
    self.finishBtn.titleLabel.font = FONT(15);
    
    self.finishBtn.layer.cornerRadius = 5;
    
    [self.finishBtn addTarget:self action:@selector(finishBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.finishBtn.backgroundColor = COLOR(243, 197, 1, 1);
    
    [self.view addSubview:self.finishBtn];
    
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(15, HEIGHT5S(80+200+20), WIDTH5S(200), HEIGHT5S(30))];
    
    self.label.text = @"点击发送获取短信验证码！";
    
    self.label.font = FONT(13);
    
    self.label.textColor = COLOR(200, 200, 200, 1);
    
    [self.view addSubview:self.label];
    
    
    self.registerNameText = [[UITextField alloc]initWithFrame:CGRectMake(15, HEIGHT5S(176-75+20), WIDTH5S(290), HEIGHT5S(40))];
    
    self.registerNameText.layer.borderWidth = 0;
    
    [self.registerNameText setBackgroundColor:[UIColor whiteColor]];
    
    self.registerNameText.placeholder = @"    请输入手机号";
    
    self.registerNameText.layer.cornerRadius = 5;
    
    self.registerNameText.font = FONT(13);
    
    [self.view addSubview:self.registerNameText];
    
    
    self.registerPwdText = [[UITextField alloc]initWithFrame:CGRectMake(15, HEIGHT5S(230-75+20), WIDTH5S(290), HEIGHT5S(40))];
    
    self.registerPwdText.layer.borderWidth = 0;
    
    [self.registerPwdText setBackgroundColor:[UIColor whiteColor]];
    
    self.registerPwdText.placeholder = @"    请输入新密码";
    
    self.registerPwdText.layer.cornerRadius = 5;
    
    self.registerPwdText.font = FONT(13);
    
    [self.view addSubview:self.registerPwdText];
    
    
    self.registerPwd1Text = [[UITextField alloc]initWithFrame:CGRectMake(15, HEIGHT5S(230-75+14+40+20), WIDTH5S(290), HEIGHT5S(40))];
    
    self.registerPwd1Text.layer.borderWidth = 0;
    
    [self.registerPwd1Text setBackgroundColor:[UIColor whiteColor]];
    
    self.registerPwd1Text.placeholder = @"    请确认新密码";
    
    self.registerPwd1Text.layer.cornerRadius = 5;
    
    self.registerPwd1Text.font = FONT(13);
    
    [self.view addSubview:self.registerPwd1Text];

}


- (void)sendBtnClick{
    
    if (![self.registerNameText.text isEqualToString:@""]&&![self.registerPwdText.text isEqualToString:@""]&&![self.registerPwd1Text.text isEqualToString:@""]) {
        
        
        if ([self.registerPwdText.text isEqualToString:self.registerPwd1Text.text]) {
            
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart) userInfo:nil repeats:YES];
            
            self.sendBtn.hidden = YES;
            self.secondLabel.hidden = NO;
            
            [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.registerNameText.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
                
                if (error) {
                    
                    NSLog(@"%@",error);
                }
            }];
        }else{
        
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"error" message:@"Two different newpasswords" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"confirm" style:UIAlertActionStyleDefault handler:nil];
            
            [alert addAction:action];
            
            [self presentViewController:alert animated:YES completion:nil];

        }
  
    }else{
    
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"error" message:@"please input oldpassword and newpassword" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"confirm" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:nil];

    }
    
   
}

- (void)timerStart{
    
    self.k --;
    
    NSString *secondStr = [NSString stringWithFormat:@"%d",_k];
    
    self.secondLabel.text = secondStr;
    
    if (self.k == 0) {
        
        self.secondLabel.hidden = YES;
        self.sendBtn.hidden = NO;
    }
}

- (void)BACK{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)finishBtnClick{
    
    [SMSSDK commitVerificationCode:self.Text.text phoneNumber:self.registerNameText.text zone:@"86" result:^(NSError *error) {
        
        if (!error) {
            
            NSLog(@"验证成功！！");
            
            LoginPageViewController *lovc = [[LoginPageViewController alloc]init];
            
            [self.navigationController pushViewController:lovc animated:YES];
            
        }else{
            
            NSLog(@"验证失败！！");
        }
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

@end
