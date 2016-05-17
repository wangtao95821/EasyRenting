//
//  ChatForSomeOneService.h
//  ChatForYou
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RongIMKit/RongIMKit.h>
#import "ChatPageViewController.h"
@interface ChatForSomeOneService : NSObject

- (void)userId:(NSString *)userid andsuccessWith:(void(^)(ChatPageViewController *rvc)) success;


@end
