//
//  Quantity.m
//  iOS_0224_1
//
//  Created by administrator on 16/2/24.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "Quantity.h"

static Quantity *addObj = nil;

@implementation Quantity


+ (Quantity *) addInstance{
    
    @synchronized(self) {
        if (addObj == nil) {
            
            addObj = [[self alloc]init];
        }
    }
    return addObj;
}

+ (id) allocWithZone:(struct _NSZone *)zone{
    
    @synchronized(self) {
        if (addObj == nil) {
            addObj = [super allocWithZone:zone];
            return addObj;
        }
    }
    return nil;
}

- (id)init{
    @synchronized(self) {
        self = [super init];
        return self;
    }
  
}



//+ (Quantity *)addInstance{
//
//    static Quantity *addObjSecond;
//        
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            
//            addObjSecond = [[self alloc]init];
//        });
//    
//    
//    return addObjSecond;
//}

@end
