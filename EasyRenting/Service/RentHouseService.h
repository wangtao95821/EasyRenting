//
//  RentHouseService.h
//  EasyRenting
//
//  Created by administrator on 16/4/18.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RentHouseService : NSObject

+ (void)rentHouse:(NSDictionary *)rentHouseDic andSuccess:(void(^)(NSDictionary *dic))success;


//完成出租
+ (void)finishRent:(NSString *)houseInfoId andSuccess:(void(^)(NSDictionary *dic))success;

//完成出租记录
+ (void)finishRentRecord:(NSString *)houseRecordId andSuccess:(void(^)(NSDictionary *dic))success;

//写入出租记录表
+ (void)recordHouse:(NSDictionary *)dic andSuccess:(void(^)(NSDictionary *dic))success;

@end
