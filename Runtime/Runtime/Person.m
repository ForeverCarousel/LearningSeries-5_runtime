//
//  Person.m
//  Runtime
//
//  Created by Carouesl on 2016/11/4.
//  Copyright © 2016年 Carouesl. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
#import "UnrecogizeMethodManager.h"



@implementation Person

-(instancetype)initWithName:(NSString* )name  age:(NSInteger) age
{
    self = [super init];
    if (self)
    {
        self.name = name;
        self.age = age;
        self.children = [NSMutableArray arrayWithCapacity:3];
        NSArray* names = @[@"Tom",@"Jerry",@"Lucy"];
        for (int i = 0; i < 3; ++i)
        {
            Child* child = [[Child alloc] initWithName:names[i] age:i+5];
            [_children addObject:child];
        }
        
    }
    return self;
}



//消息转发的处理过程见工程中 名字为  messageForwarding的图片

//基类的实例方法 当该类实例调用方法时 如果在method_list和superclass的method_list的列表中都找不到调用的方法时 会调用如下方法  可以进一步处理没有响应的方法
+(BOOL)resolveInstanceMethod:(SEL)sel
{
    
    if (sel == @selector(unexistMethod))
    {
        NSLog(@"不存在该方法");
        //为传递过来的消息添加实现体
        BOOL result = class_addMethod([self class], sel, (IMP)dynamicImplementation, "V@:");
        if (result) {
            NSLog(@"添加新的方法实现成功");
        }
    }
    return [super resolveInstanceMethod:sel];
}

void dynamicImplementation (id self ,SEL _cmd){
    NSLog(@"动态添加方法的实现 %p:",_cmd);
}

+(BOOL)resolveClassMethod:(SEL)sel
{
    return [super resolveClassMethod:sel];
}






/*
 消息转发
 Returns the object to which unrecognized messages should first be directed.
 If an object implements (or inherits) this method, and returns a non-nil (and non-self) result, that returned object is used as the new receiver object and the message dispatch resumes to that new object. (Obviously if you return self from this method, the code would just fall into an infinite loop.)
 If you implement this method in a non-root class, if your class has nothing to return for the given selector then you should return the result of invoking super’s implementation.
 This method gives an object a chance to redirect an unknown message sent to it before the much more expensive forwardInvocation: machinery takes over. This is useful when you simply want to redirect messages to another object and can be an order of magnitude faster than regular forwarding. It is not useful where the goal of the forwarding is to capture the NSInvocation, or manipulate the arguments or return value during the forwarding.
 
 该方法是基类的一个实例方法 返回值为你希望接受这个无法识别消息的对象 即将self无法处理的消息转发到返回值所指定的对象去处理 如果有各一个对象实现或者继承了这个方法 则这个对象就会作为这个消息新的接受者 和明显 如果返回self就会死循环
 如果一个非基类实现了这个方法并且没有针对selector做处理 那应该让super去掉用该方法
 
 */

-(id)forwardingTargetForSelector:(SEL)aSelector
{
    if (aSelector == @selector(unexistMethod))
    {
        return [UnrecogizeMethodManager manager];
    }
    return [super forwardingTargetForSelector:aSelector];
}



//如果上述方法返回nil 或者未实现 则进入下一步转发 完整的消息转发
/*
    当一个对象由于没有相应的方法实现而无法相应某消息时，运行时系统将通过 forwardInvocation: 消息通知该对象。每个对象都继承了 forwardInvocation: 方法。但是， NSObject 中的方法实现只是简单的调用了 doesNotRecognizeSelector:。通过实现自己的 forwardInvocation: 方法，我们可以将消息转发给其他对象。
    forwardInvocation: 方法就是一个不能识别消息的分发中心，将这些不能识别的消息转发给不同的接收对象，或者转发给同一个对象，再或者将消息翻译成另外的消息，亦或者简单的“吃掉”某些消息，因此没有响应也不会报错。这一切都取决于方法的具体实现。
 
 
  */

-(void)forwardInvocation:(NSInvocation *)anInvocation
{
    
}

/*
 注意：参数 anInvocation 是从哪来的？
 在 forwardInvocation: 消息发送前，Runtime 系统会向对象发送methodSignatureForSelector: 消息，并取到返回的方法签名用于生成 NSInvocation 对象。所以重写 forwardInvocation: 的同时也要重写 methodSignatureForSelector: 方法，否则会抛异常。
 */


-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    return  nil;
}


@end
