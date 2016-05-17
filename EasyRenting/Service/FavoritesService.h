//
//  FavoritesService.h
//  EasyRenting
//
//  Created by administrator on 16/4/12.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface FavoritesService : NSObject

//收藏夹
+ (void)FavoritesUserid:(int)userid andSuccess:(void(^)(NSMutableArray *collectMutArr))success;

//上传头像
+ (void)setHeadImg:(UIImage *)imgs andUserId:(int)userid andSuccess:(void (^)(NSString *str1))success andFail:(void (^)(NSString *str2))fail;

//上传房屋图片
+ (void)setImg:(NSArray *)imgs andHouseInfoId:(int)houseInfoId andSuccess:(void (^)(NSString *str1))success andFail:(void (^)(NSString *str2))fail;

//删除收藏
+ (void)FavoritesDelete:(NSString *)userid andHouseInfoId:(NSString *)houseInfoId andSuccess:(void(^)(NSDictionary *dic))success;

//登录
+ (void)userLogin:(NSString *)telephone andWithPassword:(NSString *)password andSuccess:(void(^)(NSDictionary *dic))success;


//注册
+ (void)userRegister:(NSString *)telephone andWithPassword:(NSString *)password andusertoken:(NSString *)tokenStr andSuccess:(void(^)(NSDictionary *dic))success;

//判断手机号是否存在
+ (void)userphoneJudge:(NSString *)telephone andSuccess:(void(^)(NSDictionary *dic))success;

//修改个人信息
+ (void)userUpdataInfo:(NSString *)userid andName:(NSString *)userName andSex:(NSString *)userSex andSuccess:(void(^)(NSDictionary *dicUser))success;

//个人信息
+ (void)userInfo:(NSString *)userid andSuccess:(void(^)(NSDictionary *dic))success;

//修改密码
+ (void)userUpdataPassword:(NSString *)userid andOldPassword:(NSString *)OPassword andNewPassword:(NSString *)NPassword andSuccess:(void(^)(NSDictionary *dic))success;

@end
