//
//  houseService.m
//  EasyRenting
//
//  Created by administrator on 16/4/18.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "houseService.h"
#import "AFNetworking.h"
@implementation houseService

+ (void)houseInfoManager:(NSString *)userid andSuccess:(void (^)(NSMutableArray *))success{
    
    NSMutableArray *arrrr = [NSMutableArray arrayWithCapacity:0];
    
    NSString *url = [NSString stringWithFormat:@"http://115.159.215.30/EasyRenting/index.php/home/easy/housemanage?userid=%@",userid];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"%@",responseObject);
        
        arrrr.array = [responseObject objectForKey:@"data"];
        
        success(arrrr);
        
        NSLog(@"请求个人房屋信息成功！！！");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"////////////////////////%@",error);
        
        NSLog(@"请求个人房屋信息失败！！！");
    }];
}



//二维码扫描
+ (void)houseInfoScan:(NSString *)houseinfoid andSuccess:(void (^)(NSDictionary *))success{

    NSString *url = [NSString stringWithFormat:@"http://115.159.215.30/EasyRenting/index.php/home/easy/houseinfomanage?houseinfoid=%@",houseinfoid];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"%@",responseObject);
        
        NSArray *arrrr = [responseObject objectForKey:@"data"];
        
        NSDictionary *dics = arrrr[0];
        
        success(dics);
        
        NSLog(@"二维码请求个人房屋信息成功！！！");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"////////////////////////%@",error);
        
        NSLog(@"二维码请求个人房屋信息失败！！！");
    }];
}

//请求出租记录表
+ (void)houseRecord:(NSString *)houseRecordUserId andSuccess:(void (^)(NSMutableArray *))success{

     NSMutableArray *arrrr = [NSMutableArray arrayWithCapacity:0];
    
    NSString *url = [NSString stringWithFormat:@"http://115.159.215.30/EasyRenting/index.php/home/easy/houserecordmanage?houserecorduserid=%@",houseRecordUserId];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"%@",responseObject);
        
        arrrr.array = [responseObject objectForKey:@"data"];
        
        success(arrrr);
        
        NSLog(@"请求房屋出租记录信息成功！！！");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"////////////////////////%@",error);
        
        NSLog(@"请求个人房屋出租记录信息失败！！！");
    }];

}

@end
