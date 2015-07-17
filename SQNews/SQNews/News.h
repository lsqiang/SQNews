//
//  News.h
//  SQNews
//
//  Created by Fly on 15/7/16.
//  Copyright © 2015年 sq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

//标题
@property (nonatomic, copy) NSString *title;
// 摘要
@property (nonatomic, copy) NSString *digest;
// 跟贴数量
@property (nonatomic, assign) NSInteger replyCount;
// 配图地址
@property (nonatomic, copy) NSString *imgsrc;
// 多图数组，key imgsrc
@property (nonatomic, strong) NSArray *imgextra;
// 大图标记
@property (nonatomic, assign) BOOL imgType;

/**
 *  返回新闻列表
 */
+ (void)NewsList:(NSString *)urlStr finished:(void (^)(NSArray *dataList))finished;

@end
