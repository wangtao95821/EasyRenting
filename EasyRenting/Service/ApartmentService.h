//
//  ApartmentService.h
//  EasyRenting
//
//  Created by administrator on 16/4/6.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApartmentService : NSObject


- (void)houseInfo:(NSMutableArray *)infoArr andWithApartment:(NSString *)apartment andSuccessWith:(void(^)(NSMutableArray *arr)) success;


@end
