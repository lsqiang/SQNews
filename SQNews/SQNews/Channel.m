//
//  Channel.m
//  SQNews
//
//  Created by Fly on 15/7/17.
//  Copyright © 2015年 sq. All rights reserved.
//

#import "Channel.h"
#import "NSObject+Extension.h"

@implementation Channel

+ (NSArray *)channels {
    
    //1.获取目录，加载dict,取出array
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"topic_news.json" withExtension:nil];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    NSArray *tList = dict[dict.keyEnumerator.nextObject];
    
    //2.遍历添加到arrayM
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:tList.count];
    [tList enumerateObjectsUsingBlock:^(id  __nonnull obj, NSUInteger idx, BOOL * __nonnull stop) {
        [arrayM addObject:[self objWithDict:obj]];
    }];
    
    return [arrayM sortedArrayUsingComparator:^NSComparisonResult(Channel  __nonnull *obj1, Channel  __nonnull *obj2) {
        return [obj1.tid compare:obj2.tid];
    }];
}

- (void)setTid:(NSString *)tid {
    _tid = tid.copy;
    _urlString = [NSString stringWithFormat:@"%@/0-20.html", tid];
}

@end
