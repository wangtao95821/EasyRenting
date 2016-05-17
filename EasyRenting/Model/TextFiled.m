//
//  TextFiled.m
//  EasyRenting
//
//  Created by administrator on 16/3/29.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "TextFiled.h"
#import "Define.h"
@implementation TextFiled

+ (UIView *)createTextFiled{

    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(22, HEIGHT5S(1160+72+5+100), WIDTH5S(276), HEIGHT5S(182))];
    
    view2.backgroundColor = [UIColor whiteColor];
    
    NSArray *imageArrY = @[@"20",@"81",@"142"];
    
    NSArray *placehold = @[@"   请输入你的电话号码",@"   请输入你的微信号",@"   请输入你的姓名"];
    
    NSArray *imageA = @[@"phone.png",@"weixin.png",@"默认头像.png"];
    
    for (int k = 0; k < 3; k ++) {
        
        NSString *strImageY = imageArrY[k];
        
        UIImageView *contactWay = [[UIImageView alloc]initWithFrame:CGRectMake(20, strImageY.intValue, WIDTH5S(20), HEIGHT5S(20))];
        
        contactWay.image = [UIImage imageNamed:imageA[k]];
        
        [view2 addSubview:contactWay];
        
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(62, strImageY.intValue-10, 1, 40)];
        
        lineLabel.backgroundColor = COLOR(223, 223, 223, 1);
        
        [view2 addSubview:lineLabel];
        
        UITextField *textFile = [[UITextField alloc]initWithFrame:CGRectMake(64, strImageY.intValue-20, 212, 60)];
        
        textFile.layer.borderWidth = 0;
        
        textFile.placeholder = placehold[k];
        
        //placeholder颜色
//        [textFile setValue:COLOR(243, 197, 1, 1) forKeyPath:@"_placeholderLabel.textColor"];
        
        textFile.font = [UIFont systemFontOfSize:13];
        
        [view2 addSubview:textFile];
        
        
    }
    
    return view2;
}

@end
