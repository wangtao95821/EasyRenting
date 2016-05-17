//
//  CityDistrictService.h
//  EasyRenting
//
//  Created by administrator on 16/4/11.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "Define.h"
@interface CityDistrictService : NSObject

- (void)ProvinceName:(NSString *)provinceName CityNameWith:(NSString *)cityname AndCityDistrictWith:(void(^)(NSArray *cityDistrict))success;

@end
