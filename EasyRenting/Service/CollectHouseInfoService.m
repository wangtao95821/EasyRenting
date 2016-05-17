//
//  CollectHouseInfoService.m
//  EasyRenting
//
//  Created by administrator on 16/4/14.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "CollectHouseInfoService.h"
#import "AFNetworking.h"

@implementation CollectHouseInfoService

- (void)userId:(NSString *)userid andHouseInfoId:(NSString *)houseinfoid andSuccessWith:(void (^)(NSDictionary *))success{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary *sendDic = @{
                              @"userid":[NSNumber numberWithInt:[userid intValue]],
                              @"houseinfoid":[NSNumber numberWithInt:[houseinfoid intValue]]
                              };
    NSString *url = @"http://115.159.215.30/EasyRenting/index.php/home/easy/collect";
    [manager POST:url parameters:sendDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"***----++++%@",responseObject);
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}

@end
