//
//  RegisterPageViewController.m
//  EasyRenting
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "RegisterPageViewController.h"
#import "Define.h"
#import "LoginPageViewController.h"
#import "RegisterNextPageViewController.h"
#import "FavoritesService.h"
@interface RegisterPageViewController ()

@end

@implementation RegisterPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR(244, 244, 245, 1);
    
    self.registerLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, HEIGHT5S(125), WIDTH5S(81), HEIGHT5S(28))];
    
    self.registerLabel.text = @"注册账户";
    
    self.registerLabel.font = FONT(20);
    
    self.registerLabel.textColor = COLOR(243, 197, 1, 1);
    
    [self.view addSubview:self.registerLabel];
    
    
    self.registerNameText = [[UITextField alloc]initWithFrame:CGRectMake(15, HEIGHT5S(176), WIDTH5S(290), HEIGHT5S(40))];
    
    self.registerNameText.layer.borderWidth = 0;
    
    [self.registerNameText setBackgroundColor:[UIColor whiteColor]];
    
    self.registerNameText.placeholder = @"    请输入账号";
    
    self.registerNameText.layer.cornerRadius = 5;
    
    self.registerNameText.font = FONT(13);
    
    [self.view addSubview:self.registerNameText];
    
    
    self.registerPwdText = [[UITextField alloc]initWithFrame:CGRectMake(15, HEIGHT5S(230), WIDTH5S(290), HEIGHT5S(40))];
    
    self.registerPwdText.layer.borderWidth = 0;
    
    [self.registerPwdText setBackgroundColor:[UIColor whiteColor]];
    
    self.registerPwdText.placeholder = @"    请输入密码";
    
    self.registerPwdText.layer.cornerRadius = 5;
    
    self.registerPwdText.font = FONT(13);
    
    [self.view addSubview:self.registerPwdText];
    
    self.registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, HEIGHT5S(310), WIDTH5S(290), HEIGHT5S(40))];
    
    [self.registerBtn setTitle:@"下一步" forState:UIControlStateNormal];
    
    self.registerBtn.backgroundColor = COLOR(243, 197, 1, 1);
    
    [self.registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.registerBtn.layer.cornerRadius = 5;
    
    [self.registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.registerBtn.titleLabel.font = FONT(15);
    
    [self.view addSubview:self.registerBtn];
    
    self.alreadyRegister = [[UIButton alloc]initWithFrame:CGRectMake(0, HEIGHT5S(525), SCREEN_WIDTH, HEIGHT5S(43))];
    
    self.alreadyRegister.backgroundColor = [UIColor clearColor];
    
    [self.alreadyRegister setTitle:@"已有账户了吗？" forState:UIControlStateNormal];
    
    self.alreadyRegister.titleLabel.font = FONT(12);
    
    [self.alreadyRegister setTitleColor:COLOR(243, 197, 1, 1) forState:UIControlStateNormal];
    
    [self.alreadyRegister addTarget:self action:@selector(alreadyRegisterClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.alreadyRegister];
    
    
    self.lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT5S(524), SCREEN_WIDTH, 1)];
    
    self.lineLabel.backgroundColor = COLOR(223, 223, 223, 1);
    
    [self.view addSubview:self.lineLabel];
}

- (void)alreadyRegisterClick{

    LoginPageViewController *lvc = [[LoginPageViewController alloc]init];
    
    [self.navigationController pushViewController:lvc animated:YES];
    
//    [self presentViewController:lvc animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
}

//下一步按钮
- (void)registerBtnClick{

    RegisterNextPageViewController *rnnvc = [[RegisterNextPageViewController alloc]init];
    
    NSString *strname = self.registerNameText.text;
    
    NSString *strpwd = self.registerPwdText.text;
    
    if ([strname isEqualToString:@""] || [self.registerPwdText.text isEqualToString:@""]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"error" message:@"please input phoneNum or password" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"confirm" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
        
    }else{
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
           
            [FavoritesService userphoneJudge:self.registerNameText.text andSuccess:^(NSDictionary *dic) {
                
               dispatch_async(dispatch_get_main_queue(), ^{
                   
                   NSString *judgeStr = [dic objectForKey:@"code"];
                   
                   if ([judgeStr isEqual:@300]) {
                       
                       UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"prompt" message:@"Phone number already exists" preferredStyle:UIAlertControllerStyleAlert];
                       
                       UIAlertAction *action = [UIAlertAction actionWithTitle:@"confirm" style:UIAlertActionStyleDefault handler:nil];
                       
                       [alert addAction:action];
                       
                       [self presentViewController:alert animated:YES completion:nil];
                       
                   }else{
                   
                       rnnvc.phonenumStr = strname;
                       
                       rnnvc.pwdnumStr = strpwd;
                       
                       [self.navigationController pushViewController:rnnvc animated:YES];
                   }
                   
               });
            }];
            
        });
   
    }
}

@end
