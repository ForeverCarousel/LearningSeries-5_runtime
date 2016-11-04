//
//  ViewController.m
//  Runtime
//
//  Created by Carouesl on 2016/11/1.
//  Copyright © 2016年 Carouesl. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>
#import <objc/message.h>



typedef struct objc_myClass{

    char* name;
    float version;
} *myClass;

typedef struct objc_myObeject{
    
    myClass  isa;
    
} *myObject;


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //myClass  a;
    //a -> name = "carousel";
    //myObject b;
    //b -> isa -> name = "something";
    
    Person* p = [[Person alloc] initWithName:@"Carousel" age:28];
    
    [p performSelector:@selector(unexistMethod)];
    
    
    
}















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
