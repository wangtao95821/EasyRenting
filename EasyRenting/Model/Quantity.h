//
//  Quantity.h
//  iOS_0224_1
//
//  Created by administrator on 16/2/24.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Quantity : NSObject


@property (strong, nonatomic) NSMutableString *cityName;

@property (strong, nonatomic) NSMutableDictionary *cityDic;

+ (Quantity *) addInstance;

@end
