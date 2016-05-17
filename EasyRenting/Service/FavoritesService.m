//
//  FavoritesService.m
//  EasyRenting
//
//  Created by administrator on 16/4/12.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "FavoritesService.h"
#import "AFNetworking.h"
#import "Define.h"
@implementation FavoritesService

//收藏夹
+ (void)FavoritesUserid:(int)userid andSuccess:(void (^)(NSMutableArray *))success{

    NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:0];
    
     NSString *url = [NSString stringWithFormat:@"http://115.159.215.30/EasyRenting/index.php/home/easy/favorites?userid=%d",userid];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [arr1 setArray:[responseObject objectForKey:@"data"]];
        
        NSLog(@"arrrrrrr==%ld",arr1.count);
        
        success(arr1);
        
//        NSLog(@"----------%@",mutArr);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
//        NSLog(@"%@",error);
        
        NSLog(@"-----收藏夹失败!!");
        
    }];
}

//取消收藏
+ (void)FavoritesDelete:(NSString *)userid andHouseInfoId:(NSString *)houseInfoId andSuccess:(void (^)(NSDictionary *))success{

    NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    [mutDic setObject:userid forKey:@"userid"];
    [mutDic setObject:houseInfoId forKey:@"houseinfoid"];
    
    NSString *url = @"http://115.159.215.30/EasyRenting/index.php/home/easy/cancel";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:url parameters:mutDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"取消收藏成功！！！");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"取消收藏失败！！！");
    }];
}

//上传头像
+ (void)setHeadImg:(UIImage *)imgs andUserId:(int)userid andSuccess:(void (^)(NSString *))success andFail:(void (^)(NSString *))fail{

    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manage setSecurityPolicy:securityPolicy];
    
    NSNumber *user_id = [NSNumber numberWithInt:userid];
    
    NSDictionary *dic = @{
                          @"userid":user_id
                          };
    
    
    NSString *url = @"http://115.159.215.30/Tupian/index.php/home/index/uploadima";
    
    [manage POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
     
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy年MM月dd日"];
        NSString *dateStr = [formatter stringFromDate:date];
            
        NSString *fileName = [NSString stringWithFormat:@"%@.png",dateStr];
            
        NSData *imageData;
            
        imageData = UIImageJPEGRepresentation(imgs, 0.1f);
            
        [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"%d",userid] fileName:fileName mimeType:@"image/jpg/png/jpeg"];
   
      
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *diccc = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
 
        NSDictionary *dic2 = [diccc objectForKey:@"result"];
        
        NSString *userID = [NSString stringWithFormat:@"%d",userid];
        
        NSDictionary *dic3 = [dic2 objectForKey:userID];
        
        NSString *str2 = [dic3 objectForKey:@"savename"];
        
        NSString *str3 = [dic3 objectForKey:@"savepath"];
        
        NSString *str4 = [NSString stringWithFormat:@"%@%@",str3,str2];
        
        NSString *str9 = [NSString stringWithFormat:@"http://115.159.215.30/Tupian/image%@",str4];
        
//        NSLog(@"%@",str9);

        success(str9);
        
        NSString *url1 = @"http://115.159.215.30/EasyRenting/index.php/home/easy/uploadimaname";
        
        NSDictionary *strDic = @{
                                 @"userid":user_id,
                                 @"userimage":str4
                                 };
        
        [manage POST:url1 parameters:strDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
 
        NSLog(@"上传成功！！");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        NSLog(@"++++++++++++-------------%@",error);
        
        NSLog(@"上传失败！！");
    }];

}

//上传多张图片
+ (void)setImg:(NSArray *)imgs andHouseInfoId:(int)houseInfoId andSuccess:(void (^)(NSString *))success andFail:(void (^)(NSString *))fail{

    
    
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
 
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    
//    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
   
    [manage setSecurityPolicy:securityPolicy];
    
    
    
    NSNumber *houseinfoId = [NSNumber numberWithInt:houseInfoId];
    
    NSDictionary *dic = @{
                          @"houseinfoid":houseinfoId
                          };
    
    NSString *url = @"http://115.159.215.30/Tupian/index.php/home/index/uploadima";
    
    int i = 0;
    
    for (UIImage *img in imgs) {
    
    [manage POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy年MM月dd日"];
        NSString *dateStr = [formatter stringFromDate:date];
        
        
            NSString *fileName = [NSString stringWithFormat:@"%@%d.png",dateStr,i];
            
            NSData *imageData;
            
            imageData = UIImageJPEGRepresentation(img, 1.0f);
            
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"%d",houseInfoId] fileName:fileName mimeType:@"image/jpg/png/jpeg"];
            
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
   
        
        NSDictionary *diccc = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSLog(@"============%@",diccc);
        
        NSDictionary *dic2 = [diccc objectForKey:@"result"];
        
        NSString *houseId = [NSString stringWithFormat:@"%d",houseInfoId];
        
        NSDictionary *dic3 = [dic2 objectForKey:houseId];
        
        NSString *str2 = [dic3 objectForKey:@"savename"];
        
        NSString *str3 = [dic3 objectForKey:@"savepath"];
        
        NSString *str4 = [NSString stringWithFormat:@"%@%@",str3,str2];

        NSString *url1 = @"http://115.159.215.30/EasyRenting/index.php/home/easy/uploadimaarrname";
        
        NSDictionary *strDic = @{
                                 @"houseinfoid":houseinfoId,
                                 @"houseimagename":str4
                                 };
        
        [manage POST:url1 parameters:strDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];

        
        
        
        NSLog(@"上传成功！！");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"+++++++++++++++++++++++++++++++++////%@",error);
        NSLog(@"上传失败！！");
    }];
        
        i ++;
        
        }
}


//登录
+ (void)userLogin:(NSString *)telephone andWithPassword:(NSString *)password andSuccess:(void (^)(NSDictionary *))success{
    
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSString *url = @"http://115.159.215.30/EasyRenting/index.php/home/easy/login";
    
    [mutDic setObject:telephone forKey:@"telephone"];
    
    [mutDic setObject:password forKey:@"password"];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:url parameters:mutDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
   
//        NSLog(@"%@",responseObject);
        NSLog(@"登录成功");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"登录失败！！！");
    }];
}

//注册
+ (void)userRegister:(NSString *)telephone andWithPassword:(NSString *)password andusertoken:(NSString *)tokenStr andSuccess:(void (^)(NSDictionary *))success{

    NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSString *url = @"http://115.159.215.30/EasyRenting/index.php/home/easy/register";
    
    [mutDic setObject:telephone forKey:@"telephone"];
    [mutDic setObject:password forKey:@"password"];
    [mutDic setObject:tokenStr forKey:@"token"];
    
    NSLog(@"****%@",telephone);
    NSLog(@"****---*%@",password);
    NSLog(@"*++++**%@",tokenStr);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:url parameters:mutDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
        NSLog(@"注册成功！！！");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"注册失败！！！");
    }];
}

//判断手机号是否存在
+ (void)userphoneJudge:(NSString *)telephone andSuccess:(void (^)(NSDictionary *))success{

    NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSString *url = @"http://115.159.215.30/EasyRenting/index.php/home/easy/userphoneYN";
    
    [mutDic setObject:telephone forKey:@"telephone"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:url parameters:mutDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
        NSLog(@"手机号不存在");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"手机号存在");
    }];
    
}

//修改个人信息
+ (void)userUpdataInfo:(NSString *)userid andName:(NSString *)userName andSex:(NSString *)userSex andSuccess:(void (^)(NSDictionary *))success{

    NSString *nameStr = [userName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *url = [NSString stringWithFormat:@"http://115.159.215.30/EasyRenting/index.php/home/easy/updataUserInfo?userid=%@&username=%@&usersex=%@",userid,nameStr,userSex];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
//        NSLog(@"responseObject------%@",responseObject);
        
        NSLog(@"更新信息成功");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"更新信息失败");
    }];
}


//个人信息
+ (void)userInfo:(NSString *)userid andSuccess:(void (^)(NSDictionary *))success{

    NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSString *url = @"http://115.159.215.30/EasyRenting/index.php/home/easy/userinfo";
    
    [mutDic setObject:userid forKey:@"userid"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:url parameters:mutDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
   
        NSLog(@"请求个人信息成功！！！");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求个人信息失败！！！");
    }];
}


//修改密码
+ (void)userUpdataPassword:(NSString *)userid andOldPassword:(NSString *)OPassword andNewPassword:(NSString *)NPassword andSuccess:(void (^)(NSDictionary *))success{

    NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSString *url = @"http://115.159.215.30/EasyRenting/index.php/home/easy/updatapassword";
    
    [mutDic setObject:userid forKey:@"userid"];
    [mutDic setObject:OPassword forKey:@"password"];
    [mutDic setObject:NPassword forKey:@"newpassword"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:url parameters:mutDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
        NSLog(@"密码更改成功！！！");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"密码更改失败！！！");
    }];
    
}
@end
