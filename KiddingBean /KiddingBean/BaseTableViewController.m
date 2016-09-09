//
//  BaseTableViewController.m
//  KiddingBean
//
//  Created by Qianfeng on 16/2/25.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//
#define kColor arc4random()%256/255.0
#import "BaseTableViewController.h"
#import "TableViewCell.h"
//#import "DetailTableViewCell.h"

#import "WPYFirstModel.h"

#import "VideoTableViewCell.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _count = 10;
    
    [self createTableView];
    [self createPullFooterRefresh];
    [self createPullHeaderRefresh];
    
    [self.myTableView headerStartRefresh];
    
}

- (void)createTableView {
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - 64 -44 -37)];
    [self.view addSubview:_myTableView];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    self.myTableView.estimatedRowHeight = 44;
    [_myTableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [_myTableView registerNib:[UINib nibWithNibName:@"DetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"detailCell"];
    [_myTableView registerClass:[VideoTableViewCell class] forCellReuseIdentifier:@"kidcell"];
    _myTableView.showsVerticalScrollIndicator = NO;
}
/**
 *
 *
 *  添加上拉和下拉控件
 */
- (void)createPullHeaderRefresh {
    __weak BaseTableViewController *weakSelf = self;
    [self.myTableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        //标识正在下拉
        _isPullDown = YES;
        //初始化数据
        [weakSelf refreshPage];
        //请求数据
        [weakSelf loadDataSource];
    }];
}
//结束刷新
- (void)endRefresh {
    //结束下拉刷新
    if (_isPullDown) {
        _isPullDown = NO;
        [self.myTableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
    }
    if (_isLoadMore) {
        _isLoadMore = NO;
        //结束上拉刷新
        [self.myTableView footerEndRefreshing];
    }
}
- (void)createPullFooterRefresh {
    //上拉控件是添加到tableviewFooter上
     __weak BaseTableViewController *weakSelf = self;
    [self.myTableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
       //上拉的时候加载更多 页数加一
        weakSelf.page ++;
        weakSelf.isLoadMore = YES;
        //请求数据
        [weakSelf loadDataSource];
    }];
}
- (NSString *)urlStr {
    return nil;
}
- (void)refreshPage {
    self.page = 1;
}
-(void)loadDataSource {
    if (![[AFNetworkReachabilityManager sharedManager]isReachable]) {
        [self endRefresh];
        //读取本地数据
        NSArray *arr = [CacheManager readDataWithUrl:[self urlStr]];
       //  NSLog(@"-------%@",arr);
       // NSLog(@"缓存中读取数据");
        self.dataSource = [WPYFirstModel arrayOfModelsFromDictionaries:arr];
       
        //刷新界面
        [self.myTableView reloadData];
        return;
    }
    HttpEngine *engine = [HttpEngine shareEngine];
    NSLog(@"%@",[self urlStr]);
    if ([self urlStr]) {
        [engine GET:[self urlStr] success:^(id response) {
           // NSLog(@"请求成功---%@",response);
            NSArray *items = response[@"items"];
            //NSLog(@"********************%@",items);
            [CacheManager saveData:items withUrl:[self urlStr]];
            
            //解析数据
            if (_isPullDown) {
                self.dataSource = [WPYFirstModel arrayOfModelsFromDictionaries:items];
            }
            if (_isLoadMore) {
                [self.dataSource addObjectsFromArray:[WPYFirstModel arrayOfModelsFromDictionaries:items]];
            }
            [self endRefresh];
           // NSLog(@"------%ld",_dataSource.count);
            [self.myTableView reloadData];
        } failure:^(NSError *error) {
            NSLog(@"请求失败--- %@",error);
            NSLog(@"请检查网络");
        }];
    }
}


#pragma mark - 实现代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%ld",self.dataSource.count);
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        WPYFirstModel *mode = self.dataSource[indexPath.row];
        [cell configData:mode];
        return cell;
    
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
