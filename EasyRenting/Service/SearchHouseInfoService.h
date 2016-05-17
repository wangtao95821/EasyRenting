//
//  SearchHouseInfoService.h
//  EasyRenting
//
//  Created by administrator on 16/4/14.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchHouseInfoService : NSObject


- (void)InputSearchStr:(NSString *)searchStr andCityName:(NSString *)cityName andSuccess:(void(^)(NSMutableArray *arr)) success;


@end
