//
//  MyScrollView.h
//  ScrollView自动翻转
//
//  Created by administrator on 16/3/15.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageViewController.h"
@interface MyScrollView : UIView<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *MyScroll;
@property (strong, nonatomic) NSTimer *MyTimer;
@property (strong, nonatomic) UIPageControl *MyPage;
@property (assign, nonatomic, getter=isScrollDirectionPortrait) BOOL scrollDirectionPortrait;
@property (strong, nonatomic) NSArray *imageArr;

@property (assign, nonatomic) int i;

@end
