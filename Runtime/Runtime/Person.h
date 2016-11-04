//
//  Person.h
//  Runtime
//
//  Created by Carouesl on 2016/11/4.
//  Copyright © 2016年 Carouesl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Child.h"

@interface Person : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) NSMutableArray* children;


-(instancetype)initWithName:(NSString* )name  age:(NSInteger) age;




@end
