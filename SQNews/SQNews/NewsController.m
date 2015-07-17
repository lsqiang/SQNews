//
//  NewsController.m
//  SQNews
//
//  Created by Fly on 15/7/16.
//  Copyright © 2015年 sq. All rights reserved.
//

#import "NewsController.h"
#import "NetworkTools.h"
#import "News.h"
#import "NewsCell.h"

@interface NewsController ()



@property (strong, nonatomic) NSArray *newsList;

@end

@implementation NewsController

-(void)setUrlStr:(NSString *)urlStr {
    
    [News NewsList:urlStr finished:^(NSArray *dataList) {
        _newsList = dataList;
        [self.tableView reloadData];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];

}

// MARK: 数据源方法

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.newsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    News *news = self.newsList[indexPath.row];
    
    NSString *cellID = [NewsCell cellID:news];
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.news = news;

    [cell setLayoutMargins:UIEdgeInsetsZero];
    
    return cell;
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    News *news = self.newsList[indexPath.row];
    return [NewsCell heightForCell:news];
    
}


/**
 *  懒加载数据
 */
-(NSArray *)newsList {
    
    if (_newsList == nil) {
        _newsList = [NSArray array];
    }
    return _newsList;
}
@end
