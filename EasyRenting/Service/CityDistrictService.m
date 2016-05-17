//
//  CityDistrictService.m
//  EasyRenting
//
//  Created by administrator on 16/4/11.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "CityDistrictService.h"
#import "AFNetworking.h"

@implementation CityDistrictService

- (void)ProvinceName:(NSString *)provinceName CityNameWith:(NSString *)cityname AndCityDistrictWith:(void (^)(NSArray *))success{
    
    NSLog(@"+-+-+-+-+-%@------%@",provinceName,cityname);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@?key=%@",CITYDISTRICT_URL,CITYDISTRICT_KET];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
  
        NSDictionary *dic = responseObject;
        NSArray *arr = [dic objectForKey:@"result"];
        NSMutableArray *mutArr = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < arr.count; i++) {
            
            if ([provinceName isEqualToString:(arr[i][@"province"])]) {
                NSArray *cityArr = arr[i][@"city"];
                for (int j = 0; j < cityArr.count; j++) {
                    if ([cityname isEqualToString:(cityArr[j][@"city"])]) {

                        [mutArr setArray:cityArr[j][@"district"]];
                        
                    }

                }
            
            }
            
        }
        NSLog(@"*/*/*/*/*/%@",mutArr);
        success(mutArr);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

@end
