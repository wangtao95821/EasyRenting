//
//  GetCityAllHouseInfoService.m
//  EasyRenting
//
//  Created by administrator on 16/4/19.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "GetCityAllHouseInfoService.h"
#import "AFNetworking.h"
@implementation GetCityAllHouseInfoService


- (void)CityName:(NSString *)cityName andSuccessWith:(void (^)(NSMutableArray *))success{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *urlStr = @"http://115.159.215.30/EasyRenting/index.php/home/easy/cityhouseinfo?cityname=";
    NSString *newStr = [cityName stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *url = [NSString stringWithFormat:@"%@%@",urlStr,newStr];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *sendArr = [NSMutableArray arrayWithCapacity:0];
        NSString *codeStr = [responseObject objectForKey:@"code"];
        
        if ([codeStr isEqual:@0]) {
            [sendArr setArray:[responseObject objectForKey:@"result"]];
            
            
        }
        success(sendArr);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];

    
}

@end
