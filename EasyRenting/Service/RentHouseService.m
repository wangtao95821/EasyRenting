//
//  RentHouseService.m
//  EasyRenting
//
//  Created by administrator on 16/4/18.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "RentHouseService.h"
#import "AFNetworking.h"
@implementation RentHouseService

+ (void)rentHouse:(NSDictionary *)rentHouseDic andSuccess:(void (^)(NSDictionary *))success{

    NSString *url = @"http://115.159.215.30/EEEERRRR/index.php/home/index/renting";
  
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSLog(@"hhhhhhhh--------------%@",rentHouseDic);
    
    [manager POST:url parameters:rentHouseDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
        NSLog(@"---------------------%@",responseObject);
        
        NSLog(@"出租房屋成功！！！");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"////////%@",error);
        
        NSLog(@"出租房屋失败！！！");
    }];

}

//完成出租
+ (void)finishRent:(NSString *)houseInfoId andSuccess:(void (^)(NSDictionary *))success{

    NSString *url = [NSString stringWithFormat:@"http://115.159.215.30/EasyRenting/index.php/home/easy/completerent?houseinfoid=%@",houseInfoId];
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager setSecurityPolicy:securityPolicy];

    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"完成出租！！！");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"-------**********-----------%@",error);
        
        NSLog(@"未完成出租！！！");
    }];
}

//完成出租记录
+ (void)finishRentRecord:(NSString *)houseRecordId andSuccess:(void (^)(NSDictionary *))success{

    NSString *url = [NSString stringWithFormat:@"http://115.159.215.30/EasyRenting/index.php/home/easy/completerentrecord?houserecordid=%@",houseRecordId];
    
    //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager setSecurityPolicy:securityPolicy];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"完成出租！！！");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"-------**********-----------%@",error);
        
        NSLog(@"未完成出租！！！");
    }];
}

//写入出租记录表
+ (void)recordHouse:(NSDictionary *)dic andSuccess:(void (^)(NSDictionary *))success{
    
    NSString *url = @"http://115.159.215.30/EasyRenting/index.php/home/easy/record";
    
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager setSecurityPolicy:securityPolicy];
    
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
        NSLog(@"写入出租房屋记录成功！！！");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"////////%@",error);
        
        NSLog(@"写入出租房屋记录失败！！！");
    }];

}

@end
