//
//  LoginChatService.h
//  EasyRenting
//
//  Created by administrator on 16/4/21.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginChatService : NSObject

@property (assign, nonatomic) BOOL isLogin;

- (void)userToken:(NSString *)token andSuccess:(void(^)(BOOL isLogin)) success;


@end
