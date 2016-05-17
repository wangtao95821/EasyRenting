//
//  RentSequenceService.m
//  EasyRenting
//
//  Created by administrator on 16/4/6.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "RentSequenceService.h"

@implementation RentSequenceService

//租金排序
- (void)houseInfo:(NSMutableArray *)infoArr andWithMethod:(NSString *)method andSuccessWith:(void (^)(NSMutableArray *))success{
    //传进来的如果是higher，就是从小到大排列，如果是Lower，就是从大到小排列
    if ([method isEqualToString:@"higher"]) {
        if (infoArr.count > 1) {
            for (int i = 0; i < infoArr.count; i++) {
                for (int j = 0; j < infoArr.count - i - 1; j++) {
                    NSDictionary *dic1 = infoArr[j];
                    NSString *rentStr1 = (NSString *)[dic1 objectForKey:@"houseinfo_rent"];
                    float rent1 = [rentStr1 floatValue];
                    
                    NSDictionary *dic2 = infoArr[j+1];
                    NSString *rentStr2 = (NSString *)[dic2 objectForKey:@"houseinfo_rent"];
                    float rent2 = [rentStr2 floatValue];
                   
                    if (rent2 < rent1) {
                        [infoArr replaceObjectAtIndex:j withObject:dic2];
                        [infoArr replaceObjectAtIndex:j + 1 withObject:dic1];
                        
                    }
                }
            }
        }

        
        
    }else{
        
        if (infoArr.count > 1) {
            for (int i = 0; i < infoArr.count; i++) {
                for (int j = 0; j < infoArr.count - i - 1; j++) {
                    NSDictionary *dic1 = infoArr[j];
                    NSString *rentStr1 = (NSString *)[dic1 objectForKey:@"houseinfo_rent"];
                    float rent1 = [rentStr1 floatValue];
                    
                    NSDictionary *dic2 = infoArr[j+1];
                    NSString *rentStr2 = (NSString *)[dic2 objectForKey:@"houseinfo_rent"];
                    float rent2 = [rentStr2 floatValue];
                    
                    if (rent2 > rent1) {
                        [infoArr replaceObjectAtIndex:j withObject:dic2];
                        [infoArr replaceObjectAtIndex:j + 1 withObject:dic1];
                        
                    }
                }
            }
        }
        
    }
    
    
    success(infoArr);
}

@end
