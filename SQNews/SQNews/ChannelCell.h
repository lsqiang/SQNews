//
//  ChannelCell.h
//  SQNews
//
//  Created by Fly on 15/7/17.
//  Copyright © 2015年 sq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsController;

@interface ChannelCell : UICollectionViewCell

@property (strong, nonatomic) NewsController *vc;

@property(nonatomic, copy) NSString *urlStr;

@end
