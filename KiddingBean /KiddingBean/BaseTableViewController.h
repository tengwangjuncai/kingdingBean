//
//  BaseTableViewController.h
//  KiddingBean
//
//  Created by Qianfeng on 16/2/25.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "BaseViewController.h"
#import "WPYFirstModel.h"
#import "HttpEngine.h"
#import "AFNetworking.h"
#import "JHRefresh.h"
#import "CacheManager.h"

@interface BaseTableViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

- (NSString *)urlStr;
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic) int count;
@property (nonatomic) int page;
@property (nonatomic) BOOL isDetailView;
@property (nonatomic, strong)UITableView *myTableView;
@property (nonatomic)BOOL isPullDown;
@property (nonatomic)BOOL isLoadMore;
- (void)endRefresh;
- (void)refreshPage;
-(void)loadDataSource;
@end
