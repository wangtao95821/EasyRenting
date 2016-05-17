//
//  houseStyleService.m
//  EasyRenting
//
//  Created by administrator on 16/4/13.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "houseStyleService.h"
#import "AFNetworking.h"

@implementation houseStyleService

+ (void)cityName:(NSString *)cityname houseStyleWith:(NSString *)housestyle successWith:(void (^)(NSArray *))success{
 
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *urlStr = @"http://115.159.215.30/EasyRenting/index.php/home/easy/apartmentHouseInfo";
    NSString *newStr = [cityname stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSString *newUrl = [NSString stringWithFormat:@"%@?cityname=%@&housetype=%@",urlStr,newStr,housestyle];
    NSLog(@"%@----%@",cityname,housestyle);
    
    [manager GET:newUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"%@",responseObject);
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
        
        if ([responseObject[@"code"]isEqual:@0]) {
            [arr setArray:responseObject[@"result"]];
        }
        
        success(arr);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

@end
