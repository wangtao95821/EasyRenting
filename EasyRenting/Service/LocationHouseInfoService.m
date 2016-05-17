//
//  LocationHouseInfoService.m
//  EasyRenting
//
//  Created by administrator on 16/4/19.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "LocationHouseInfoService.h"
#import "GetCityAllHouseInfoService.h"
@implementation LocationHouseInfoService



- (void)location:(void (^)(NSMutableArray *))success{
    self.resultArr = [NSMutableArray arrayWithCapacity:0];
    //开启定位获取当前的城市名和街道名
    self.locationManager = [[CLLocationManager alloc]init];
    
//    self.streetStr = @"林泉街";
//    self.cityStr = @"苏州市";
    
    _locationManager.delegate = self;
    //开启定位
    [_locationManager requestAlwaysAuthorization];
    
    //运行定位方法
    [self locate];

    GetCityAllHouseInfoService *service = [[GetCityAllHouseInfoService alloc]init];
    if (self.cityStr.length > 0) {
        [service CityName:_cityStr andSuccessWith:^(NSMutableArray *arr) {
           
            if (arr.count > 0) {
                for (int i = 0; i < arr.count; i++) {
                    NSDictionary *dic = arr[i];
                    NSString *str = [dic objectForKey:@"houseinfo_address"];
                    
                    if ([str rangeOfString:_streetStr].location != NSNotFound) {
                        [self.resultArr addObject:dic];
                        
                    }
                }
                
            }
            success(self.resultArr);
            
        }];
    }

    
}

//自动定位
- (void)locate{
    
    if ([CLLocationManager locationServicesEnabled]) {
        
        
        //开始定位
        [_locationManager startUpdatingLocation];
    }else{
        
        NSLog(@"未开启定位");
        
    }
    
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    //开启线程
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        CLLocation *currentLocation = [locations lastObject];
        
        CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
        
        [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            
            
            if (placemarks.count > 0) {
                CLPlacemark *placemark = placemarks[0];
                self.streetStr = placemark.thoroughfare;
                self.cityStr = placemark.locality;
              
            }else if (error==nil&&placemarks.count==0){
                NSLog(@"NO location and error returned");
            }else if(error){
                NSLog(@"error:%@",error);
            }
            
        }];
        //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
        [manager stopUpdatingHeading];
    });
}


@end
