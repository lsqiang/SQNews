//
//  ChannelLabel.h
//  SQNews
//
//  Created by Fly on 15/7/17.
//  Copyright © 2015年 sq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChannelLabel;

@protocol ChannelLabelDelegate <NSObject>

- (void)channelLabelDidSelected:(ChannelLabel *)label;

@end

@interface ChannelLabel : UILabel

@property (assign, nonatomic) CGFloat scale;

@property (assign, nonatomic) id<ChannelLabelDelegate> channelDelegate;

/**
 * 返回自定义label
 */
+ (instancetype)channelLabel:(NSString *)title;

@end
