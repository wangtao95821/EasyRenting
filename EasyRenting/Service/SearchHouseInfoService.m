//
//  SearchHouseInfoService.m
//  EasyRenting
//
//  Created by administrator on 16/4/14.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "SearchHouseInfoService.h"
#import "GetCityAllHouseInfoService.h"
@implementation SearchHouseInfoService

- (void)InputSearchStr:(NSString *)searchStr andCityName:(NSString *)cityName andSuccess:(void (^)(NSMutableArray *))success{
    
    NSMutableArray *resultArr = [NSMutableArray arrayWithCapacity:0];
    GetCityAllHouseInfoService *service = [[GetCityAllHouseInfoService alloc]init];
    [service CityName:cityName andSuccessWith:^(NSMutableArray *arr) {
        if (arr.count > 0) {
            for (int i = 0; i < arr.count; i++) {
                NSDictionary *dic = arr[i];
                NSString *str = [dic objectForKey:@"houseinfo_name"];
                
                if ([str rangeOfString:searchStr].location != NSNotFound) {
                    [resultArr addObject:dic];
                }
            }
            
        }
        
        success(resultArr);

    }];

    
    
}



@end
