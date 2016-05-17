//
//  FetchPicService.h
//  EasyRenting
//
//  Created by administrator on 16/4/18.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FetchPicService : NSObject

- (void)houseInfoId:(int)n successWith:(void(^)(NSDictionary *dic))success;

@end
