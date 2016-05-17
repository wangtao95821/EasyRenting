//
//  MutableAttributedString.m
//  EasyRenting
//
//  Created by administrator on 16/3/31.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MutableAttributedString.h"
#import <UIKit/UIKit.h>
@implementation MutableAttributedString

+ (NSMutableAttributedString *)String:(NSString *)str andDistance:(int)i{
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
    
    //设置字体颜色
    
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, text.length)];
    
    //设置缩进、行距
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    
    style.headIndent = 30;//缩进
    
    style.firstLineHeadIndent = i;//距离
    
    style.lineSpacing = 0;//行距
    
    [text addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
    
   
    
    return text;
}

@end
