//
//  houseStyleService.h
//  EasyRenting
//
//  Created by administrator on 16/4/13.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface houseStyleService : NSObject

+ (void)cityName:(NSString *)cityname houseStyleWith:(NSString *)housestyle successWith:(void(^)(NSArray *arr))success;

@end
