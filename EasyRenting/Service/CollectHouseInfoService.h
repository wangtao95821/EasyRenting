//
//  CollectHouseInfoService.h
//  EasyRenting
//
//  Created by administrator on 16/4/14.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectHouseInfoService : NSObject

- (void)userId:(NSString *)userid andHouseInfoId:(NSString *)houseinfoid andSuccessWith:(void(^)(NSDictionary *dic)) success;

@end
