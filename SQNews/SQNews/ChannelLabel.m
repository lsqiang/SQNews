//
//  ChannelLabel.m
//  SQNews
//
//  Created by Fly on 15/7/17.
//  Copyright © 2015年 sq. All rights reserved.
//

#import "ChannelLabel.h"

@implementation ChannelLabel

#define NormalFontSize 14.0
#define SelectedFontSize 18.0

+ (instancetype)channelLabel:(NSString *)title {
    
    ChannelLabel *lbl = [[ChannelLabel alloc] init];
    lbl.text = title;
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.font = [UIFont systemFontOfSize:SelectedFontSize];
    [lbl sizeToFit];
    
    lbl.font = [UIFont systemFontOfSize:NormalFontSize];
    lbl.userInteractionEnabled = YES;
    
    return lbl;
}

//在set方法中 完成字体颜色和大小的缩放
- (void)setScale:(CGFloat)scale {
    
    CGFloat max = SelectedFontSize/NormalFontSize - 1;
    CGFloat percent = max*scale + 1;
    
    self.transform = CGAffineTransformMakeScale(percent, percent);
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1];
}

//为label添加 ‘点击事件’
- (void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    if ([self.channelDelegate respondsToSelector:@selector(channelLabelDidSelected:)]) {
        [self.channelDelegate channelLabelDidSelected:self];
    }

}


@end
