//
//  HomeController.m
//  SQNews
//
//  Created by Fly on 15/7/17.
//  Copyright © 2015年 sq. All rights reserved.
//

#import "HomeController.h"
#import "Channel.h"
#import "ChannelCell.h"
#import "ChannelLabel.h"

@interface HomeController () <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, ChannelLabelDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *sv;
@property (strong, nonatomic) IBOutlet UICollectionView *cv;
@property (strong, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;

@property (strong, nonatomic) NSArray *channelList;

@property (assign, nonatomic) NSInteger currentIndex;//当前选中的下标
@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setChannels];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self setCollectionView];


}

/**
 *  设置collectionView
 */
- (void)setCollectionView {
    
    self.layout.minimumLineSpacing = 0;
    self.layout.minimumInteritemSpacing = 0;
    self.layout.itemSize = self.cv.bounds.size;
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.cv.pagingEnabled = YES;
    self.cv.showsHorizontalScrollIndicator = NO;
}


/**
 *  设置频道列表
 */
- (void)setChannels {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGFloat margin = 8.0;
    CGFloat h = self.sv.bounds.size.height;
    CGFloat x = margin;
    for (int i=0; i<self.channelList.count; i++) {
        
        Channel *channel = self.channelList[i];
        
        ChannelLabel *lbl = [ChannelLabel channelLabel:channel.tname];
        lbl.tag = i;
        lbl.frame = CGRectMake(x, 0, lbl.bounds.size.width, h);
        lbl.channelDelegate = self;
        x += lbl.bounds.size.width;
        
        [self.sv addSubview:lbl];
    }
    
    self.sv.contentSize = CGSizeMake(x + margin, h);
    self.sv.showsHorizontalScrollIndicator = false;
    
    self.currentIndex = 0;
    ChannelLabel *label = self.sv.subviews[0];
    label.scale = 1.0;
}

// MARK:scrollView的代理方法  完成缩放比例的计算
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //1.获取前后两个label
    ChannelLabel *currentLabel = self.sv.subviews[self.currentIndex];
    ChannelLabel *nextLabel = nil;

    for (NSIndexPath *indexPath in self.cv.indexPathsForVisibleItems) {
        if (indexPath.item != self.currentIndex) {
            nextLabel = self.sv.subviews[indexPath.item];
            break;
        }
    }
    
    if (nextLabel == nil) {
        return;
    }
    
    //2.计算缩放比例
    CGFloat nextScale = ABS(self.cv.contentOffset.x / self.cv.bounds.size.width - self.currentIndex);
    CGFloat currentScale = 1 - nextScale;
    
    //3.set方法设置lable的缩放比例，完成颜色和大小的变化
    currentLabel.scale = currentScale;
    nextLabel.scale = nextScale;
    self.currentIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    self.currentIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    [self channelSVDidScroll];
    

}

//频道列表滚动
- (void)channelSVDidScroll {
    ChannelLabel *currentLabel = self.sv.subviews[self.currentIndex];
    CGFloat offset = currentLabel.center.x - self.sv.bounds.size.width*0.5;
    CGFloat maxOffset = self.sv.contentSize.width - self.sv.bounds.size.width;
    
    if (offset < 0) {
        offset = 0;
    } else if (offset > maxOffset) {
        offset = maxOffset;
    }
    

    [self.sv setContentOffset:CGPointMake(offset, 0) animated:YES];

}


// MARK:collectionView的数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.channelList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //1.获取urlStr
    Channel *channel = self.channelList[indexPath.item];
    
    //2.获取cell
    ChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ChannelCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256)/255) green:((float)arc4random_uniform(256)/255) blue:((float)arc4random_uniform(256)/255) alpha:1.0];
    
    //3.设置cell的urlStr
    cell.urlStr = channel.urlString;
    
    //4.添加vc到controller
    if (![self.childViewControllers containsObject:(UIViewController *)cell.vc]) {
        [self addChildViewController:(UIViewController *)cell.vc];
    }
    
    return cell;
}

- (void)channelLabelDidSelected:(ChannelLabel *)label {
    
    self.currentIndex = label.tag;
    
    NSIndexPath *idxPath = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];
    [self.cv scrollToItemAtIndexPath:idxPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    
    [self channelSVDidScroll];
}

/**
 *  懒加载频道列表
 */
- (NSArray *)channelList {
    if (_channelList == nil) {
        _channelList = [Channel channels];
    }
    return _channelList;
}

@end
