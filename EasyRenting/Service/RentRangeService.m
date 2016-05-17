//
//  RentRangeService.m
//  EasyRenting
//
//  Created by administrator on 16/4/6.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "RentRangeService.h"

@implementation RentRangeService

- (void)houseInfo:(NSArray *)houseInfoArr andWithLowestPrice:(NSString *)lowest andWithHighestPrice:(NSString *)highest andsuccessWith:(void (^)(NSArray *))success{
    
    NSMutableArray *resultArr = [NSMutableArray arrayWithCapacity:0];
    
    //将最低价格和最高价格转换成int整型
    int a = [lowest intValue];
    int b = [highest intValue];
    
    //最高价减去最低价钱，得到一个数值，如果数值为0，说明排序为不限制租金范围，如果数值小于0，则说明需要得到比最低价高的所有房屋信息，如果大于0，则说明需要的房屋信息在最低价和最高价之间
    int c = b - a;
    
    if (c == 0) {
        
        [resultArr setArray:houseInfoArr];
        
    }else if (c <0 ){
        for (int i = 0; i < houseInfoArr.count; i++) {
            NSDictionary *dic = houseInfoArr[i];
            NSString *rentStr = [dic objectForKey:@"houseinfo_rent"];
            int rent = [rentStr intValue];
            if (rent >= a) {
                [resultArr addObject:dic];
            }
        }
        
    }else{
        for (int i = 0; i < houseInfoArr.count; i++) {
            NSDictionary *dic = houseInfoArr[i];
            NSString *rentStr = [dic objectForKey:@"houseinfo_rent"];
            int rent = [rentStr intValue];
            if (rent >= a && rent <= b) {
                [resultArr addObject:dic];
            }
        }
        
    }
    
    
    success(resultArr);
    
}



@end
