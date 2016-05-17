//
//  SelectCityService.h
//  车辆违规查询
//
//  Created by administrator on 16/3/21.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectCityService : NSObject

+ (void)selectCity:(void(^)(NSArray *arr))success;


@end
