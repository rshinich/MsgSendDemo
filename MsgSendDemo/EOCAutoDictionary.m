//
//  EOCAutoDictionary.m
//  MsgSendDemo
//
//  Created by 张忠瑞 on 2018/2/9.
//  Copyright © 2018年 张忠瑞. All rights reserved.
//

#import "EOCAutoDictionary.h"
#import <objc/runtime.h>

@interface EOCAutoDictionary ()

@property (nonatomic ,strong) NSMutableDictionary           *backingStore;

@end


@implementation EOCAutoDictionary

@dynamic string, number, date, opaqueObject;

- (id)init
{
    self = [super init];
    
    if(self)
    {
        _backingStore = [[NSMutableDictionary alloc] init];
    }
    return self;
}


//这里注意实例方法和类方法
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    NSString *selectorStirng = NSStringFromSelector(sel);
    
    if([selectorStirng hasPrefix:@"set"])
    {
        class_addMethod(self, sel, (IMP)autoDictionarySetter, "v@:@");
    }
    else
    {
        class_addMethod(self, sel, (IMP)autoDictionaryGetter, "@@:");
    }
    
    return YES;
}


id autoDictionaryGetter(id self, SEL _cmd)
{
    EOCAutoDictionary *typeSelf = (EOCAutoDictionary *)self;
    NSMutableDictionary *backingStore = typeSelf.backingStore;
    
    NSString *key = NSStringFromSelector(_cmd);
    
    return [backingStore objectForKey:key];
}

void autoDictionarySetter(id self ,SEL _cmd, id vaule)
{
    EOCAutoDictionary *typeSelf = (EOCAutoDictionary *)self;
    
    NSMutableDictionary *backingStore = typeSelf.backingStore;
    
    //获取方法名
    NSString *selectorString = NSStringFromSelector(_cmd);
    NSMutableString *key = [selectorString mutableCopy];
    
    //去除尾部“:”符号
    [key deleteCharactersInRange:NSMakeRange(key.length-1, 1)];
    
    //去除头部“set”
    [key deleteCharactersInRange:NSMakeRange(0, 3)];
    
    NSString *lowercaseFirstChar = [[key substringFromIndex:1] lowercaseString];
    
    [key replaceCharactersInRange:NSMakeRange(0, 1) withString:lowercaseFirstChar];
    
    if(vaule)
    {
        [backingStore setObject:vaule forKey:key];
    }
    else
    {
        [backingStore removeObjectForKey:key];
    }
}



@end
