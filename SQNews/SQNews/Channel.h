//
//  Channel.h
//  SQNews
//
//  Created by Fly on 15/7/17.
//  Copyright © 2015年 sq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Channel : NSObject

//频道名称
@property (nonatomic, copy) NSString *tname;

//频道代号
@property (nonatomic, copy) NSString *tid;

//新闻地址
@property (nonatomic, copy, readonly) NSString *urlString;

/**
 *  返回channel列表
 */
+ (NSArray *)channels;

@end
