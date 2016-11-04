//
//  UnrecogizeMethodManager.m
//  Runtime
//
//  Created by Carouesl on 2016/11/4.
//  Copyright © 2016年 Carouesl. All rights reserved.
//

#import "UnrecogizeMethodManager.h"

@implementation UnrecogizeMethodManager

static UnrecogizeMethodManager* m = nil;
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+(instancetype) manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m = [[self alloc] init];
    });
    return m;
}

-(void)unexistMethod
{
    NSLog(@"%@ 处理了%@消息",[self class],NSStringFromSelector(_cmd));
}


@end
