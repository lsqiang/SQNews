//
//  NewsCell.h
//  SQNews
//
//  Created by Fly on 15/7/16.
//  Copyright © 2015年 sq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class News;

@interface NewsCell : UITableViewCell

@property (strong, nonatomic) News *news;

/**
 * 返回cell类型
 */
+ (NSString *)cellID:(News *)news;

/**
 * 返回行高
 */
+ (CGFloat)heightForCell:(News *)news;

@end
