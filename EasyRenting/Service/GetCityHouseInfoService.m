//
//  GetCityHouseInfoService.m
//  EasyRenting
//
//  Created by administrator on 16/4/11.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "GetCityHouseInfoService.h"
#import "AFNetworking.h"
@implementation GetCityHouseInfoService


- (void)CityName:(NSString *)cityName WithPageIndex:(int)pageindex andSuccessWith:(void (^)(NSMutableArray *))success{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *urlStr = @"http://115.159.215.30/EasyRenting/index.php/home/easy/chooseCity?cityname=";
    NSString *newStr = [cityName stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *url = [NSString stringWithFormat:@"%@%@&pageindex=%d",urlStr,newStr,pageindex];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *sendArr = [NSMutableArray arrayWithCapacity:0];
        NSString *codeStr = [responseObject objectForKey:@"code"];
        NSLog(@"%@",codeStr);
        if ([codeStr isEqual:@0]) {
            [sendArr setArray:[responseObject objectForKey:@"result"]];
            NSLog(@"********%@",sendArr);
            
        }else{
            NSLog(@"*******%@",sendArr);
        }
        success(sendArr);
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSMutableArray *sendArr = [NSMutableArray arrayWithCapacity:0];
        success(sendArr);
        
    }];
    
}

@end
