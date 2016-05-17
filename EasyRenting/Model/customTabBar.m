//
//  customTabBar.m
//  EasyRenting
//
//  Created by administrator on 16/3/29.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "customTabBar.h"
#import "Define.h"
@interface customTabBar ()

@property (strong, nonatomic) UIView *tabView;

@property (strong, nonatomic) UIImageView *imageview;
@property (strong, nonatomic) UILabel *label;

@property (strong, nonatomic) NSArray *labelArr;

@end

@implementation customTabBar

- (instancetype)initWithCount:(int)count andWithImageArr:(NSArray *)imageArr andWithSelectImageArr:(NSArray *)selectImageArr{
    
    self = [super init];
    
    count = _count;
    imageArr = _imageArr;
    selectImageArr = _selectImageArr;
    
    if (self) {
        
        self.tabView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49)];
        
        self.tabView.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:self.tabView];
        
        UILabel *lineTabBarLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        
        lineTabBarLabel.backgroundColor = COLOR(223, 223, 223, 1);
        
        [self.tabView addSubview:lineTabBarLabel];
        
        if (count > 0) {
            
            for (int k = 0; k < count; k ++) {
                
                if (k == 0) {
                    
                    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake( 0,0 , SCREEN_WIDTH/count, 49)];
                    
                    btn.tag = 1000 + k;
                    
                    btn.backgroundColor = [UIColor clearColor];
                    
                    [btn addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [self.tabView addSubview:btn];
                    
                    self.imageview = [[UIImageView alloc]initWithFrame:CGRectMake(22, 10, 20, 20)];
                    
                    self.imageview.tag = k +10000;
                    
                    self.imageview.image = [UIImage imageNamed:selectImageArr[0]];
                    
                    
                    [btn addSubview:_imageview];
                    
                    self.label = [[UILabel alloc]initWithFrame:CGRectMake(22, 30, 30, 20)];
                    
                    self.label.tag = k + 100;
                    self.label.textColor = COLOR(243, 197, 0, 1);
                    self.label.text = self.labelArr[0];
                    self.label.font = [UIFont systemFontOfSize:11];
                    [btn addSubview:self.label];
                    
                    
                }else{
                    
                    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(k * SCREEN_WIDTH/count, 0, SCREEN_WIDTH/count, 49)];
                    
                    btn.backgroundColor = [UIColor clearColor];
                    
                    [btn addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
                    
                    btn.tag = 1000 + k;
                    
                    [self.tabView addSubview:btn];
                    
                    self.imageview = [[UIImageView alloc]initWithFrame:CGRectMake(22, 10, 20, 20)];
                    
                    self.imageview.tag = k +10000;
                    
                    self.imageview.image = [UIImage imageNamed:imageArr[k]];
                    
                    [btn addSubview:_imageview];
                    
                    self.label = [[UILabel alloc]initWithFrame:CGRectMake(22, 30, 30, 20)];
                    
                    self.label.tag = k + 100;
                    self.label.textColor = COLOR(0, 0, 0, 1);
                    self.label.text = self.labelArr[k];
                    self.label.font = [UIFont systemFontOfSize:11];
                    [btn addSubview:self.label];
                }
            }
        }
        
    }
    
    return self;
}

- (void)test:(UIButton *)sender{
    
    long int i = [sender tag];
    
    for (int t = 0; t < self.imageArr.count; t ++) {
        
        if (i == t + 1000) {
            
            UILabel *l1 = (UILabel *)[self.view viewWithTag:t + 100];
            
            l1.textColor = COLOR(243, 197, 0, 1);
            
            UIImageView *vi = (UIImageView *)[self.view viewWithTag:t+10000];
            vi.image = [UIImage imageNamed:_selectImageArr[t]];
            
        }else{
            
            UILabel *l1 = (UILabel *)[self.view viewWithTag:t + 100];
            
            l1.textColor = [UIColor blackColor];
            
            UIImageView *vi = (UIImageView *)[self.view viewWithTag:t+10000];
            
            vi.image = [UIImage imageNamed:_imageArr[t]];
        }
    }
    
    self.selectedIndex = i - 1000;
}

- (void)hidden{
    
    for (UIView *seedView in self.view.subviews) {
        
        if ([seedView isKindOfClass:[self.tabBar class]]) {
            
            [seedView removeFromSuperview];
            break;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.count = 5;
    self.imageArr = @[@"首页1.png",@"tabbar_mainframe@3x.png",@"tabbar_discover@3x.png",@"chuzu.png",@"tabbar_me@3x.png"];
    self.selectImageArr = @[@"首页.png",@"消息@3x.png",@"搜索.png",@"chuzu1-1.png",@"我的.png"];
    
    self.labelArr = @[@"首页",@"消息",@"搜索",@"出租",@"我的"];
    
    [self hidden];
}

- (void)setHidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed{
    
    self.tabView.hidden = hidesBottomBarWhenPushed;
}


@end
