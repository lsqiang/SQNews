//
//  ChannelCell.m
//  SQNews
//
//  Created by Fly on 15/7/17.
//  Copyright © 2015年 sq. All rights reserved.
//

#import "ChannelCell.h"
#import "NewsController.h"

@implementation ChannelCell

/**
 *  显示新闻列表
 */
- (void)awakeFromNib {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"News" bundle:nil]
    ;
    self.vc = sb.instantiateInitialViewController;
    
    [self addSubview:self.vc.view];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.vc.view.frame = self.bounds;
}

-(void)setUrlStr:(NSString *)urlStr {
    _urlStr = urlStr.copy;
    
    self.vc.urlStr = urlStr;
}

@end
