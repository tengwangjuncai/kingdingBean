//
//  LoLVideoViewController.m
//  KiddingBean
//
//  Created by Qianfeng on 16/2/26.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "LoLVideoViewController.h"
#import "VideoModel.h"
#import "LoLVideoTableViewCell.h"
#import "LoLVideoDetailViewController.h"
@interface LoLVideoViewController ()


@end

@implementation LoLVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.navigationController.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        self.navigationController.navigationBar.translucent = YES;
    }
    [super.navigationController pushViewController:viewController animated:animated];
}
- (void)createTableView {
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - 64 -44 -37)];
    [self.view addSubview:self.myTableView];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    self.myTableView.estimatedRowHeight = 44;
    [self.myTableView registerNib:[UINib nibWithNibName:@"LoLVideoTableViewCell" bundle:nil] forCellReuseIdentifier:@"lolVideoCell"];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.myTableView.separatorColor = [UIColor lightGrayColor];
    self.myTableView.showsVerticalScrollIndicator = NO;
    
}
-(void)loadDataSource {
    if (![[AFNetworkReachabilityManager sharedManager]isReachable]) {
        [self endRefresh];
        //读取本地数据
        NSArray *arr = [CacheManager readDataWithUrl:[self urlStr]];
        // NSLog(@"缓存中读取数据");
        self.dataSource = [VideoModel arrayOfModelsFromDictionaries:arr];
        //刷新界面
        [self.myTableView reloadData];
        return;
    }
    HttpEngine *engine = [HttpEngine shareEngine];
    if ([self urlStr]) {
        [engine GET:[self urlStr] success:^(id response) {
            // NSLog(@"请求成功---%@",response);
            NSArray *videos = response[@"videos"];
            [CacheManager saveData:videos withUrl:[self urlStr]];
            
            //解析数据
            if (self.isPullDown) {
                self.dataSource = [VideoModel arrayOfModelsFromDictionaries:videos];
            }
            if (self.isLoadMore) {
                [self.dataSource addObjectsFromArray:[VideoModel arrayOfModelsFromDictionaries:videos]];
            }
            [self endRefresh];
          //  NSLog(@"------%ld",self.dataSource.count);
            [self.myTableView reloadData];
        } failure:^(NSError *error) {
            
           // NSLog(@"请求失败--- %@",error);
        }];
    }
}

- (NSString *)urlStr {
    NSDate *date = [NSDate date];
    NSTimeInterval ts = [date timeIntervalSince1970];
    int tsp = ts * 1000;
    
    return [NSString stringWithFormat:kLoLVideo,tsp];
    
}

#pragma mark - 实现代理

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LoLVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lolVideoCell"];
    VideoModel *model = self.dataSource[indexPath.row];
    [cell configData:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LoLVideoDetailViewController * lolvdVC = [[LoLVideoDetailViewController alloc] init];
    lolvdVC.title = @"英雄时刻";
    lolvdVC.mode = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:lolvdVC animated:YES];
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





