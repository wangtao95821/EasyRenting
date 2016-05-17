//
//  GetTokenService.h
//  EasyRenting
//
//  Created by administrator on 16/4/5.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetTokenService : NSObject


- (void)userId:(NSString *)userid andSuccessWith:(void(^)(NSDictionary *dic)) success;


@end
