//
//  News.m
//  SQNews
//
//  Created by Fly on 15/7/16.
//  Copyright © 2015年 sq. All rights reserved.
//

#import "News.h"
#import "NetworkTools.h"
#import <objc/runtime.h>
#import "NSObject+Extension.h"

@implementation News

+ (void)NewsList:(NSString *)urlStr finished:(void (^)(NSArray *))finished {
    
    [[NetworkTools shareManager] GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        
        NSArray *array = responseObject[responseObject.keyEnumerator.nextObject];
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            [arrayM addObject:[self objWithDict:obj]];
        }];
        
        finished(arrayM.copy);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}



@end
