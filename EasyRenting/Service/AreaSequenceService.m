//
//  AreaSequenceService.m
//  EasyRenting
//
//  Created by administrator on 16/4/6.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "AreaSequenceService.h"

@implementation AreaSequenceService

//面积排序
- (void)houseInfo:(NSMutableArray *)infoArr andWithMethod:(NSString *)method andSuccessWith:(void (^)(NSMutableArray *))success{
    
    //传进来的如果是bigger，就是从小到大排列，如果是smaller，就是从大到小排列
    if ([method isEqualToString:@"bigger"]) {
        if (infoArr.count > 1) {
            for (int i = 0; i < infoArr.count; i++) {
                for (int j = 0; j < infoArr.count - i - 1; j++) {
                    NSDictionary *dic1 = infoArr[j];
                    NSString *areaStr1 = (NSString *)[dic1 objectForKey:@"houseinfo_area"];
                    int area1 = [areaStr1 intValue];
                    
                    NSDictionary *dic2 = infoArr[j+1];
                    NSString *areaStr2 = (NSString *)[dic2 objectForKey:@"houseinfo_area"];
                    int area2 = [areaStr2 intValue];
                    
                    
                    if (area2 < area1) {
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
                    NSString *areaStr1 = (NSString *)[dic1 objectForKey:@"houseinfo_area"];
                    int area1 = [areaStr1 intValue];
                    
                    NSDictionary *dic2 = infoArr[j+1];
                    NSString *areaStr2 = (NSString *)[dic2 objectForKey:@"houseinfo_area"];
                    int area2 = [areaStr2 intValue];
                    
                    if (area2 > area1) {
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
