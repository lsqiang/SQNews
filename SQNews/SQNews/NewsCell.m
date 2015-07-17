//
//  NewsCell.m
//  SQNews
//
//  Created by Fly on 15/7/16.
//  Copyright © 2015年 sq. All rights reserved.
//

#import "NewsCell.h"
#import "UIImageView+AFNetworking.h"
#import "News.h"

@interface NewsCell()

@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *titleLbl;
@property (strong, nonatomic) IBOutlet UILabel *digestLbl;
@property (strong, nonatomic) IBOutlet UIImageView *bigImgView;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgsView;

@end

@implementation NewsCell

- (void)setNews:(News *)news {
    
    _news = news;
    self.titleLbl.text = news.title;
    self.digestLbl.text = news.digest;
    
    self.imgView.image = nil;
    [self.imgView setImageWithURL:[NSURL URLWithString:news.imgsrc]];
    
    if (news.imgextra.count == 2) {
        int index = 0;
        for (UIImageView *iv in self.imgsView) {
            iv.image = nil;
            NSURL *url = [NSURL URLWithString:news.imgextra[index][@"imgsrc"]];
            [iv setImageWithURL:url];
            index ++;
        }
    }
}

+ (NSString *)cellID:(News *)news {
    
    if (news.imgextra.count == 2) {
        return @"ImgsCell";
    } else if(news.imgType) {
        return @"BigImgCell";
    }
    return @"NormalCell";
}

+ (CGFloat)heightForCell:(News *)news {
    
    if (news.imgextra.count == 2) {
        return 120;
    } else if(news.imgType) {
        return 180;
    }
    return 80;
}

@end
