//
//  RegisterNextPageViewController.m
//  EasyRenting
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "RegisterNextPageViewController.h"
#import "Define.h"
#import "LoginPageViewController.h"
#import "FavoritesService.h"
#import "GetTokenService.h"
@interface RegisterNextPageViewController ()

@end

@implementation RegisterNextPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.k = 60;
    
    self.view.backgroundColor = COLOR(244, 244, 245, 1);
    
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    
    navView.backgroundColor = NAVIGATIONCOLOR;
    
    [self.view addSubview:navView];
    
    UILabel *navTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 20, 120, 44)];
    
    navTitleLabel.text = @"短信验证";
    
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

    
    self.Text = [[UITextField alloc]initWithFrame:CGRectMake(15, HEIGHT5S(124), WIDTH5S(195), HEIGHT5S(40))];
    
    self.Text.placeholder = @"    短信验证码";
    
    self.Text.font = FONT(13);
    
    [self.Text setBackgroundColor:[UIColor whiteColor]];
    
    self.Text.layer.cornerRadius = 5;
    
    [self.view addSubview:self.Text];
    
    self.sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(225, HEIGHT5S(124), WIDTH5S(80), HEIGHT5S(40))];
    
    [self.sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    
    self.sendBtn.titleLabel.font = FONT(15);
    
    self.sendBtn.backgroundColor = COLOR(243, 197, 1, 1);
    
    [self.sendBtn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.sendBtn.layer.cornerRadius = 5;
    
    [self.view addSubview:self.sendBtn];
    
    
    self.secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(225, HEIGHT5S(124), WIDTH5S(80), HEIGHT5S(40))];
    
    NSString *secondStr = [NSString stringWithFormat:@"%d",_k];
    
    self.secondLabel.text = secondStr;
    
    self.secondLabel.backgroundColor = [UIColor lightGrayColor];
    
    self.secondLabel.textColor = [UIColor whiteColor];
    
    self.secondLabel.layer.cornerRadius = 5;
    
    self.secondLabel.layer.masksToBounds = YES;
    
    self.secondLabel.textAlignment = NSTextAlignmentCenter;
    
    self.secondLabel.hidden = YES;
    
    [self.view addSubview:self.secondLabel];
    
    self.finishBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, HEIGHT5S(199), WIDTH5S(290), HEIGHT5S(40))];
    
    [self.finishBtn setTitle:@"完成注册" forState:UIControlStateNormal];
    
    self.finishBtn.titleLabel.font = FONT(15);
    
    self.finishBtn.layer.cornerRadius = 5;
    
    [self.finishBtn addTarget:self action:@selector(finishBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.finishBtn.backgroundColor = COLOR(243, 197, 1, 1);
    
    [self.view addSubview:self.finishBtn];
    
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(15, HEIGHT5S(80), WIDTH5S(200), HEIGHT5S(30))];
    
    self.label.text = @"点击发送获取短信验证码！";
    
    self.label.font = FONT(13);
    
    self.label.textColor = COLOR(200, 200, 200, 1);
    
    [self.view addSubview:self.label];
}


- (void)sendBtnClick{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart) userInfo:nil repeats:YES];
    
    self.sendBtn.hidden = YES;
    self.secondLabel.hidden = NO;
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phonenumStr zone:@"86" customIdentifier:nil result:^(NSError *error) {
        
        if (error) {
            
            NSLog(@"%@",error);
        }
    }];
}

- (void)timerStop{

    [self.timer invalidate];
    
    self.timer = nil;
}

- (void)timerStart{

    self.k --;
    
    NSString *secondStr = [NSString stringWithFormat:@"%d",_k];
    
    self.secondLabel.text = secondStr;
    
    if (self.k == 0) {
        
        self.secondLabel.hidden = YES;
        self.sendBtn.hidden = NO;
        
        self.k = 60;
        
        [self timerStop];
    }
}

- (void)BACK{
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)finishBtnClick{
    
    LoginPageViewController *lovc = [[LoginPageViewController alloc]init];

    [SMSSDK commitVerificationCode:self.Text.text phoneNumber:_phonenumStr zone:@"86" result:^(NSError *error) {
        
        if (!error) {
            
            NSLog(@"验证成功！！");
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                GetTokenService *token = [[GetTokenService alloc]init];
                
                [token userId:_phonenumStr andSuccessWith:^(NSDictionary *dic) {
                    
                    self.strToken = [dic objectForKey:@"token"];
                    
                    [FavoritesService userRegister:self.phonenumStr andWithPassword:self.pwdnumStr andusertoken:self.strToken andSuccess:^(NSDictionary *dic) {
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            NSString *RegStr = [dic objectForKey:@"code"];
                            
                            if ([RegStr isEqual:@200]) {
                                
                                [self.navigationController pushViewController:lovc animated:YES];
                            }
                        });
                    }];

                }];
                
            });
  
        }else{
            
            NSLog(@"验证失败！！");
        }
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
}

@end
