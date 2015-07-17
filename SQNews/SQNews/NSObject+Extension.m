//
//  NSObject+Extension.m
//  SQNews
//
//  Created by Fly on 15/7/17.
//  Copyright © 2015年 sq. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/runtime.h>

@implementation NSObject (Extension)


+ (instancetype)objWithDict:(NSDictionary *)dict {
    
    id obj = [self new];
    
    for (NSString *propName in [self properties]) {
        if (dict[propName] != nil) {
            [obj setValue:dict[propName] forKey:propName];
        }
    }
    
    return obj;
}

const char* propertiesKey = "propertiesKey";
+ (NSArray *)properties {
    
    //1.判断是否有关联对象
    NSArray *pList = objc_getAssociatedObject(self, propertiesKey);
    if (pList != nil) {
        return pList;
    }
    
    //2.获取类属性
    unsigned int count;
    objc_property_t *list = class_copyPropertyList([self class], &count);
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:count];
    for (int i=0; i < count; i++) {
        objc_property_t pty = list[i];
        const char* name = property_getName(pty);
        [arrayM addObject:[NSString stringWithUTF8String:name]];
    }
    //2.1释放list
    free(list);
    
    //3.设置关联对象
    objc_setAssociatedObject(self, propertiesKey, arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return arrayM.copy;
}

@end
