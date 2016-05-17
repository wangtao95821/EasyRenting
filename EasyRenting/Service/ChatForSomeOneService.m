//
//  ChatForSomeOneService.m
//  ChatForYou
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "ChatForSomeOneService.h"
#import <RongIMKit/RongIMKit.h>

@implementation ChatForSomeOneService

- (void)userId:(NSString *)userid andsuccessWith:(void (^)(ChatPageViewController *))success{
    
    //新建一个聊天会话View Controller对象
    ChatPageViewController *chat = [[ChatPageViewController alloc]init];
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    chat.conversationType = ConversationType_PRIVATE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    chat.targetId = userid;
    //设置聊天会话界面要显示的标题
    chat.title = userid;
    
    success(chat);
    
}


@end
