//
//  AppDelegate.m
//  EasyRenting
//
//  Created by administrator on 16/3/28.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "MessagePageViewController.h"
#import "SearchPageViewController.h"
#import "RentingPageViewController.h"
#import "MinePageViewController.h"
#import "customTabBar.h"
#import "Define.h"
@interface AppDelegate ()

@property (strong, nonatomic)BMKMapManager *mapManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.mapManager = [[BMKMapManager alloc]init];
    
    BOOL ret = [_mapManager start:BAIDU_MAP_KEY  generalDelegate:nil];
    
    if (!ret) {
        
        NSLog(@"manager start failed!");
        
    }
    
    HomePageViewController *hvc = [[HomePageViewController alloc]init];
    MessagePageViewController *mvc = [[MessagePageViewController alloc]init];
    SearchPageViewController *svc = [[SearchPageViewController alloc]initWithPath:@"cityDic"];
    RentingPageViewController *rvc = [[RentingPageViewController alloc]init];
    MinePageViewController *mpvc = [[MinePageViewController alloc]init];
    
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:hvc];
    
    nvc.navigationBarHidden = YES;
    
    UINavigationController *nvc1 = [[UINavigationController alloc]initWithRootViewController:mvc];
    UINavigationController *nvc2 = [[UINavigationController alloc]initWithRootViewController:svc];
    UINavigationController *nvc3 = [[UINavigationController alloc]initWithRootViewController:rvc];
    UINavigationController *nvc4 = [[UINavigationController alloc]initWithRootViewController:mpvc];
    
    customTabBar *tabbar = [[customTabBar alloc]initWithCount:5 andWithImageArr:nil andWithSelectImageArr:nil];
    
    tabbar.viewControllers = @[nvc, nvc1, nvc2, nvc3, nvc4];
    
    self.window.rootViewController = tabbar;
    
    
    [SMSSDK registerApp:APPKEY withSecret:APPS];
    
    
    [self.window makeKeyAndVisible];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [[RCIM sharedRCIM]initWithAppKey:RONGKEY];
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"personInfo"];
  
    NSString *token = [[dic objectForKey:@"result"][0] objectForKey:@"user_token"];
    
    if (token != nil) {
        [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
            //        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
        } error:^(RCConnectErrorCode status) {
            //        NSLog(@"登陆的错误码为:%ld", status);
        } tokenIncorrect:^{
            
            //        NSLog(@"token错误");
        }];
        
        [[RCIM sharedRCIM] setUserInfoDataSource:self];
        
    }
    return YES;
}

- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion{
    if ([@"789654" isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"789654";
        user.name = @"随便";
        user.portraitUri = @"http://img4.duitang.com/uploads/item/201405/10/20140510180701_HaMGF.jpeg";
        return completion(user);
    }else if ([@"250" isEqual:userId]){
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"250";
        user.name = @"我的";
        user.portraitUri = @"http://img4.duitang.com/uploads/item/201602/23/20160223104150_x2jAC.jpeg";
        return completion(user);
        
    }
    return completion(nil);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
