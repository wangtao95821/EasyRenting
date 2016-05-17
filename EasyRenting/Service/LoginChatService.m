//
//  LoginChatService.m
//  EasyRenting
//
//  Created by administrator on 16/4/21.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "LoginChatService.h"
#import <RongIMKit/RongIMKit.h>
@implementation LoginChatService

- (void)userToken:(NSString *)token andSuccess:(void (^)(BOOL))success{
    
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        self.isLogin = YES;
        success(_isLogin);
        //        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
    } error:^(RCConnectErrorCode status) {
        self.isLogin = NO;
        success(_isLogin);
        //        NSLog(@"登陆的错误码为:%ld", status);
    } tokenIncorrect:^{
        self.isLogin = NO;
        success(_isLogin);
        //        NSLog(@"token错误");
    }];
    
}

@end
