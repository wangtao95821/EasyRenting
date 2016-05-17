//
//  GetCityHouseInfoService.h
//  EasyRenting
//
//  Created by administrator on 16/4/11.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetCityHouseInfoService : NSObject

- (void)CityName:(NSString *)cityName WithPageIndex:(int)pageindex andSuccessWith:(void(^)(NSMutableArray *arr)) success;


@end
