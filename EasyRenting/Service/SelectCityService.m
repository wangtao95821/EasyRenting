//
//  SelectCityService.m
//  车辆违规查询
//
//  Created by administrator on 16/3/21.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "SelectCityService.h"
#import "AFNetworking.h"
#import "Define.h"
@implementation SelectCityService


+ (void)selectCity:(void (^)(NSArray *))success{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@?key=%@",CITYDISTRICT_URL,CITYDISTRICT_KET];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 = responseObject;
        NSArray *arr = [dic1 objectForKey:@"result"];
//        NSLog(@"%@",arr);
        success(arr);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


@end
