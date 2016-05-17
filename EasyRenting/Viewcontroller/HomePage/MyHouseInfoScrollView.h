//
//  MyHouseInfoScrollView.h
//  EasyRenting
//
//  Created by administrator on 16/3/31.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyHouseInfoScrollView : UIView<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *MyScroll;
@property (strong, nonatomic) NSTimer *MyTimer;
@property (strong, nonatomic) UIPageControl *MyPage;
@property (assign, nonatomic, getter=isScrollDirectionPortrait) BOOL scrollDirectionPortrait;
@property (strong, nonatomic) NSArray *imageArr;

@property (assign, nonatomic) int i;


@end
