//
//  ApartmentService.m
//  EasyRenting
//
//  Created by administrator on 16/4/6.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "ApartmentService.h"

@implementation ApartmentService


- (void)houseInfo:(NSMutableArray *)infoArr andWithApartment:(NSString *)apartment andSuccessWith:(void (^)(NSMutableArray *))success{
    NSLog(@"=======%@",apartment);
    NSMutableArray *resultArr = [NSMutableArray arrayWithCapacity:0];
    int x = [apartment intValue];
    if (x > 4) {
        for (int i = 0; i < infoArr.count; i ++) {
            
            NSMutableDictionary *dic = infoArr[i];
            NSString *str = [dic objectForKey:@"housetype_style"];

            int y = [str intValue];
            if (y > 4) {
                [resultArr addObject:dic];
            }
        }
        
    }else{
        for (int i = 0; i < infoArr.count; i ++) {
            
            NSMutableDictionary *dic = infoArr[i];
            NSString *str = [dic objectForKey:@"housetype_style"];
            if ([str isEqualToString:apartment]) {
                [resultArr addObject:dic];
            }
        }
    }
    
    
    NSLog(@"***********%@",resultArr);
    success(resultArr);
    
}


@end
