//
//  customTabBar.h
//  EasyRenting
//
//  Created by administrator on 16/3/29.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customTabBar : UITabBarController

@property (assign, nonatomic) int count;
@property (strong, nonatomic) NSArray *imageArr;
@property (strong, nonatomic) NSArray *selectImageArr;

- (instancetype)initWithCount:(int)count andWithImageArr:(NSArray *)imageArr andWithSelectImageArr:(NSArray *)selectImageArr;

@end
