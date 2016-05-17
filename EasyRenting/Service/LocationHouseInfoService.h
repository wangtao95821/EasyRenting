//
//  LocationHouseInfoService.h
//  EasyRenting
//
//  Created by administrator on 16/4/19.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface LocationHouseInfoService : NSObject<CLLocationManagerDelegate>

- (void)location:(void(^)(NSMutableArray *arr)) success;

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (copy, nonatomic) NSString *cityStr;

@property (copy, nonatomic) NSString *streetStr;

@property (strong, nonatomic) NSMutableArray *resultArr;

@end
