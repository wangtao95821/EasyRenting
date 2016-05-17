//
//  RentSequenceService.h
//  EasyRenting
//
//  Created by administrator on 16/4/6.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RentSequenceService : NSObject

- (void)houseInfo:(NSMutableArray *)infoArr andWithMethod:(NSString *)method andSuccessWith:(void(^)(NSMutableArray *arr)) success;



@end
