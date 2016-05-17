//
//  FetchPicService.m
//  EasyRenting
//
//  Created by administrator on 16/4/18.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "FetchPicService.h"
#import "AFNetworking.h"
@implementation FetchPicService

- (void)houseInfoId:(int)n successWith:(void (^)(NSDictionary *))success{
  
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    
    manage.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *url = @"http://115.159.215.30/EasyRenting/index.php/home/easy/fetchhouseimagename";
    NSString *newurl = [NSString stringWithFormat:@"%@?houseinfoid=%d",url,n];
    
    [manage GET:newurl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

@end
