//
//  LoginPageViewController.m
//  EasyRenting
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "LoginPageViewController.h"
#import "Define.h"
#import "MutableAttributedString.h"
#import "RegisterPageViewController.h"
#import "ForgetPWDPageViewController.h"
#import "FavoritesService.h"
#import "MinePageViewController.h"
@interface LoginPageViewController ()

@end

@implementation LoginPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR(241, 194, 14, 1);
    
    self.loginImageView = [[UIImageView alloc]initWithFrame:CGRectMake(135, HEIGHT5S(120), WIDTH5S(50), WIDTH5S(50))];
    
    self.loginImageView.image = [UIImage imageNamed:@"hh.png"];
    
    [self.view addSubview:self.loginImageView];
    
    
    self.loginView = [[UIView alloc]initWithFrame:CGRectMake(15, HEIGHT5S(235), WIDTH5S(290), HEIGHT5S(90))];
    
    self.loginView.backgroundColor = [UIColor whiteColor];
    
    self.loginView.layer.cornerRadius = 5;
    
    [self.view addSubview:self.loginView];
    
    
    self.loginNameText = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, WIDTH5S(290), HEIGHT5S(45))];
    
    self.loginNameText.layer.borderWidth = 0;
 
    self.loginNameText.placeholder = @"用户名";
    
    self.loginNameText.font = FONT(15);
    
    //textfiled左边lable
    UILabel * leftViewName = [[UILabel alloc] initWithFrame:CGRectMake(0,0,10,45)];
    leftViewName.backgroundColor = [UIColor clearColor];
    
    self.loginNameText.leftView = leftViewName;
    
    self.loginNameText.leftViewMode = UITextFieldViewModeAlways;
    
    [self.loginView addSubview:self.loginNameText];
    
    
    
    self.lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT5S(45), WIDTH5S(290), 1)];
    
    self.lineLabel.backgroundColor = COLOR(223, 223, 223, 1);
    
    [self.loginView addSubview:self.lineLabel];
    
    self.loginPwdText = [[UITextField alloc]initWithFrame:CGRectMake(0, 45, WIDTH5S(290), HEIGHT5S(45))];
    
    self.loginPwdText.layer.borderWidth = 0;
    
    self.loginPwdText.placeholder = @"密码";
    
    self.loginPwdText.font = FONT(15);
    
    UILabel * leftViewPwd = [[UILabel alloc] initWithFrame:CGRectMake(0,0,10,45)];
    leftViewPwd.backgroundColor = [UIColor clearColor];
    
    self.loginPwdText.leftView = leftViewPwd;
    
    self.loginPwdText.leftViewMode = UITextFieldViewModeAlways;
    
    [self.loginView addSubview:self.loginPwdText];
    
    
    self.loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, HEIGHT5S(340), WIDTH5S(290), HEIGHT5S(50))];
    
    self.loginBtn.backgroundColor = COLOR(245, 213, 100, 1);
    
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    
    self.loginBtn.titleLabel.font = FONT(15);
    
    [self.loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.loginBtn.layer.cornerRadius = 5;
    
    [self.view addSubview:self.loginBtn];
    
    
    self.forgetBtn = [[UIButton alloc]initWithFrame:CGRectMake(239, HEIGHT5S(409), WIDTH5S(66), HEIGHT5S(18))];
    
    [self.forgetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    
    self.forgetBtn.titleLabel.font = FONT(12);
    
    [self.forgetBtn addTarget:self action:@selector(forgetBtnCilck) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.forgetBtn];
    
    
    self.createAccountBtn = [[UIButton alloc]initWithFrame:CGRectMake(117, HEIGHT5S(480), WIDTH5S(86), HEIGHT5S(21))];
    
    [self.createAccountBtn setTitle:@"注册E租账户" forState:UIControlStateNormal];
    
    [self.createAccountBtn addTarget:self action:@selector(createAccountBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.createAccountBtn.titleLabel.font = FONT(15);
    
    [self.view addSubview:self.createAccountBtn];
    
    
    self.backBtn = [[UIButton alloc]initWithFrame:CGRectMake(144, HEIGHT5S(520), WIDTH5S(31), HEIGHT5S(21))];
    
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    self.backBtn.titleLabel.font = FONT(15);
    
    [self.backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.backBtn];

}

- (void)backBtnClick{

    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)createAccountBtnClick{

    RegisterPageViewController *rvc = [[RegisterPageViewController alloc]init];
   
    
    [self.navigationController pushViewController:rvc animated:YES];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
}

- (void)forgetBtnCilck{

    ForgetPWDPageViewController *fovc = [[ForgetPWDPageViewController alloc]init];
    
    [self.navigationController pushViewController:fovc animated:YES];
}


//登录
- (void)loginBtnClick{
    
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    
    if (self.loginNameText.text.length == 0||self.loginPwdText.text.length == 0) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"message" message:@"phoneNum or password is not correct" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"confirm" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:nil];

    }else{
    
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [FavoritesService userLogin:self.loginNameText.text andWithPassword:self.loginPwdText.text andSuccess:^(NSDictionary *dic) {
                
//                NSArray *arr1 = [dic objectForKey:@"result"];
//                
//                NSDictionary *dic1 = arr1[0];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    NSString *strrr = [dic objectForKey:@"code"];
                    
                    if ([strrr isEqual:@200]) {
                        
                        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                        
                        [userDefaults setObject:dic forKey:@"personInfo"];
                   
                        MinePageViewController *minvc = [[MinePageViewController alloc]init];
                        
                        minvc.islogin = YES;
                        
                        [self.navigationController pushViewController:minvc animated:YES];
   
                    }else if ([strrr isEqual:@500]){
                        
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"message" message:@"phoneNum or password is not correct" preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction *action = [UIAlertAction actionWithTitle:@"comfigm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            
                        }];
                        
                        [alert addAction:action];
                        
                        [self presentViewController:alert animated:YES completion:nil];
                    }
                });
                
            }];
            
        });
        
        
    }
}


@end
