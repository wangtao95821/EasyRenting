//
//  GetDistrictHouseInfoService.m
//  EasyRenting
//
//  Created by administrator on 16/4/11.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "GetDistrictHouseInfoService.h"
#import "AFNetworking.h"
@implementation GetDistrictHouseInfoService

- (void)CityName:(NSString *)cityName AndDistrictName:(NSString *)districtName andSuccessWith:(void (^)(NSMutableArray *))success{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *urlStr = @"http://115.159.215.30/EasyRenting/index.php/home/easy/chooseDistrict";
    
    NSString *newStr1 = [cityName stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *newStr2 = [districtName stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *url = [NSString stringWithFormat:@"%@?districtname=%@&cityname=%@",urlStr,newStr2,newStr1];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *sendArr = [NSMutableArray arrayWithCapacity:0];
        NSString *codeStr = [responseObject objectForKey:@"code"];
        
        if ([codeStr isEqual:@0]) {
            [sendArr setArray:[responseObject objectForKey:@"result"]];
            
 
        }
        success(sendArr);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
    
}


@end
