//
//  RentRangeService.h
//  EasyRenting
//
//  Created by administrator on 16/4/6.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RentRangeService : NSObject

- (void)houseInfo:(NSArray *)houseInfoArr andWithLowestPrice:(NSString *)lowest andWithHighestPrice:(NSString *)highest andsuccessWith:(void(^)(NSArray *arr)) success;

@end
