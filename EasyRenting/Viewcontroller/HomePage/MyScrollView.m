//
//  MyScrollView.m
//  ScrollView自动翻转
//
//  Created by administrator on 16/3/15.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyScrollView.h"
#import "Define.h"


@implementation MyScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化scrollview
        self.MyScroll = [[UIScrollView alloc]init];
        self.MyScroll.showsHorizontalScrollIndicator = NO;
        self.MyScroll.showsVerticalScrollIndicator = NO;
        self.MyScroll.pagingEnabled = YES;
        self.MyScroll.bounces = NO;
        self.MyScroll.delegate = self;
        [self addSubview:self.MyScroll];
        //在scrollview上添加imageview
        for (int i = 0; i < IMAGECOUNT; i ++) {
            UIImageView *imageView = [[UIImageView alloc]init];
            [self.MyScroll addSubview:imageView];
            
        }
        //图片下方的小点
        self.MyPage = [[UIPageControl alloc]init];
        [self addSubview:self.MyPage];
        
        self.i = 0;
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    self.MyScroll.frame = self.bounds;
    if (self.isScrollDirectionPortrait) {
        self.MyScroll.contentSize = CGSizeMake(0, IMAGECOUNT*self.bounds.size.height);
    }else{
        self.MyScroll.contentSize = CGSizeMake(IMAGECOUNT*self.bounds.size.width, 0);
    }
    for (int i = 0; i < IMAGECOUNT; i ++) {
        UIImageView *imageView = self.MyScroll.subviews[i];
        
        if (self.isScrollDirectionPortrait) {
            imageView.frame = CGRectMake(0, i*self.MyScroll.frame.size.height, self.MyScroll.frame.size.width, self.MyScroll.frame.size.height);
            
        }else{
            
            imageView.frame = CGRectMake(i*self.MyScroll.frame.size.width, 0, self.MyScroll.frame.size.width, self.MyScroll.frame.size.height);
            
        }
        
        self.MyPage.frame = CGRectMake(0,self.MyScroll.frame.size.height -30, self.MyScroll.frame.size.width, 30);
        
        [self updateContent];
    }
    
    
    
}


- (void)updateContent{
    for (int i = 0; i < self.MyScroll.subviews.count; i++) {
        UIImageView *imageView = self.MyScroll.subviews[i];
        NSInteger index = self.MyPage.currentPage;
        if (i == 0) {
            index--;
        }else if (i == 2){
            index++;
        }
        
        if (index < 0) {
            index = self.MyPage.numberOfPages-1 ;
        }else if (index >= self.MyPage.numberOfPages){
            index = 0;
        }
        imageView.tag = index;
        imageView.image = _imageArr[index];
        
        imageView.userInteractionEnabled = YES;
        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTest)];
//        
//        [imageView addGestureRecognizer:tap];
    }
    if (self.isScrollDirectionPortrait) {
        self.MyScroll.contentOffset = CGPointMake(0, self.MyScroll.frame.size.height);
    }else{
        self.MyScroll.contentOffset = CGPointMake(self.MyScroll.frame.size.width, 0);
    }
    
    
}

//- (void)tapTest{
//    
//    NSInteger index = self.MyPage.currentPage;
//    
//    HomePageViewController *hvc = [[HomePageViewController alloc]init];
//    
//    NSArray *arr = hvc.arr;
//    
//    NSLog(@"%@",arr[index]);
//    
//}

- (void)setImageArr:(NSArray *)imageArr{
    _imageArr = imageArr;
    
    self.MyPage.numberOfPages = imageArr.count;
    self.MyPage.currentPage = 1;
    
    [self updateContent];
    
    [self startTimer];
}
//打开定时器
- (void)startTimer{
    self.MyTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(next) userInfo:nil repeats:YES];
    
}
//关闭定时器
- (void)stopTimer{
    [self.MyTimer invalidate];
    self.MyTimer = nil;
}
//定时器执行方法
- (void)next{
    if (self.isScrollDirectionPortrait) {
        [self.MyScroll setContentOffset:CGPointMake(0, 2*self.MyScroll.frame.size.height) animated:YES];
    }else{
        [self.MyScroll setContentOffset:CGPointMake(2*self.MyScroll.frame.size.width, 0) animated:YES];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page = 0;
    CGFloat minDistance = MAXFLOAT;
    for (int i = 0; i < self.MyScroll.subviews.count; i++) {
        UIImageView *imageView = self.MyScroll.subviews[i];
        CGFloat distance = 0;
        if (self.isScrollDirectionPortrait) {
            distance = ABS(imageView.frame.origin.y - scrollView.contentOffset.y);
        }else{
            distance = ABS(imageView.frame.origin.x - scrollView.contentOffset.x);
        }
        
        if (distance < minDistance) {
            minDistance = distance;
            page = imageView.tag;
        }
        
    }
    self.MyPage.currentPage = page;
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [self startTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self updateContent];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self updateContent];
}
@end
