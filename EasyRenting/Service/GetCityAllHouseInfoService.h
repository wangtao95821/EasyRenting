//
//  GetCityAllHouseInfoService.h
//  EasyRenting
//
//  Created by administrator on 16/4/19.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetCityAllHouseInfoService : NSObject

- (void)CityName:(NSString *)cityName andSuccessWith:(void(^)(NSMutableArray *arr)) success;

@end
