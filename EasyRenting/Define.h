//
//  Define.h
//  CELL
//
//  Created by administrator on 16/1/25.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

#import <SMS_SDK/SMSSDK.h>

#ifndef Define_h
#define Define_h
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH5S(x) x/320.0*[UIScreen mainScreen].bounds.size.width
#define HEIGHT5S(y) y/568.0*[UIScreen mainScreen].bounds.size.height
#define WIDTH6(x) x/375.0*[UIScreen mainScreen].bounds.size.width
#define HEIGHT6(y) y/667.0*[UIScreen mainScreen].bounds.size.height

#define COLOR(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define NAVIGATIONCOLOR [UIColor colorWithRed:243/255.0 green:197/255.0 blue:0/255.0 alpha:1];

#define MILKYELLOW  [UIColor colorWithRed:255/255.0 green:253/255.0 blue:193/255.0 alpha:1];

#define LINECOLOR  [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];

#define SMALLWORD  [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];

#define BACKGROUNDCOLOR [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];

#define ARC(a) arc4random()%a

#define KEY @"528d4b536682acfe7390f300370d6d32"

#define BAIDU_MAP_KEY @"0sqULzAzNncqm5nIcjl8i4vhFGU3OG5t"

#define BAIDU_MAP_KEY1 @"HQCdpRPVyMgbeE8ZTf4hkehr"

#define IMAGECOUNT 6

#define FONT(f) [UIFont systemFontOfSize:f]

#define RONGKEY @"6tnym1brnz3l7"

#define APPSECRET @"eBKixMmxfigrCX"

#define TOKEN @"KuJgbQXRm9uMMV/JEbD/kFUbaX0TGHGAhs1tPa1GBDZfW4FAltMMae8S/9fC1LunpLy7uy118nuDbLcO9Qw7hQ=="

//E租
#define APPKEY @"115f7d4f3f704"
#define APPS @"3268bda0caf3a58dc2ae1ce70099f929"

#define CITYDISTRICT_KET @"031c4aa59c9d4cb0afa375b0ade1bfad"
#define CITYDISTRICT_URL @"http://v.juhe.cn/postcode/pcd"

#endif /* Define_h */
