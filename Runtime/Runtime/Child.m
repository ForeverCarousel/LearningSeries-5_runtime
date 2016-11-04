//
//  Child.m
//  Runtime
//
//  Created by Carouesl on 2016/11/4.
//  Copyright © 2016年 Carouesl. All rights reserved.
//

#import "Child.h"

@implementation Child


-(instancetype)initWithName:(NSString* )name  age:(NSInteger) age
{
    if (self = [super init])
    {
        self.name = name;
        self.age = age;
    }
    return self;
}

@end
