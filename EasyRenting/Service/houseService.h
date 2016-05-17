//
//  houseService.h
//  EasyRenting
//
//  Created by administrator on 16/4/18.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface houseService : NSObject

//房东
+ (void)houseInfoManager:(NSString *)userid andSuccess:(void(^)(NSMutableArray *arr))success;


//二维码扫描房屋信息
+ (void)houseInfoScan:(NSString *)houseinfoid andSuccess:(void(^)(NSDictionary *dic))success;

//请求出租记录表
+ (void)houseRecord:(NSString *)houseRecordUserId andSuccess:(void(^)(NSMutableArray *arr))success;

@end
