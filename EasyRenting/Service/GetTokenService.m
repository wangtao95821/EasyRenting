//
//  GetTokenService.m
//  EasyRenting
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "GetTokenService.h"
#import "Define.h"
#import "AFNetworking.h"
#import <CommonCrypto/CommonDigest.h>
@implementation GetTokenService


- (void)userId:(NSString *)userid andSuccessWith:(void (^)(NSDictionary *))success{
    
    NSTimeInterval time = [[NSDate date]timeIntervalSince1970];
    NSString *timetamp = [NSString stringWithFormat:@"%f",time];
    long int i = arc4random()%100000;
    NSString *nonce = [NSString stringWithFormat:@"%ld",i];
    NSString *str = [NSString stringWithFormat:@"%@%@%@",APPSECRET,nonce,timetamp];
    NSString *signature = [self sha1:str];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *url = @"https://api.cn.ronghub.com/user/getToken.json";
    
    [manager.requestSerializer setValue:RONGKEY forHTTPHeaderField:@"App-Key"];
    [manager.requestSerializer setValue:nonce forHTTPHeaderField:@"Nonce"];
    [manager.requestSerializer setValue:timetamp forHTTPHeaderField:@"Timestamp"];
    [manager.requestSerializer setValue:signature forHTTPHeaderField:@"Signature"];
    
    
    NSDictionary *send = @{
                           @"userId":userid,
                           @"name":@"",
                           @"portraitUri":@""
                           };
    
    
    [manager POST:url parameters:send progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
        NSLog(@"+++++++%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
  
    
}
//将字符串进行哈希计算
- (NSString *) sha1:(NSString *)input{
    //const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    //NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}


@end
