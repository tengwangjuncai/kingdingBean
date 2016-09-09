//
//  LoLNewsViewController.m
//  KiddingBean
//
//  Created by Qianfeng on 16/2/26.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "LoLNewsViewController.h"
#import "WPYNavBar.h"
#import "LPModelJokeList.h"
#import "LoLTextTableViewCell.h"
#import "StartGuide.h"
#import "LoLDetailViewController.h"
#import "LoLSubjectViewController.h"
#import "LoLTextVideoTableViewCell.h"
@interface LoLNewsViewController ()
@property (nonatomic,strong)NSMutableArray * scDataSource;
@property (nonatomic)BOOL isFirstPage;
@end

@implementation LoLNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isDetailView = NO;
    self.isFirstPage = YES;
    
   // [self loadDataSource];
    
}
- (void)createTableView {
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 -44-37)];
    [self.view addSubview:self.myTableView];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    self.myTableView.estimatedRowHeight = 44;
    [self.myTableView registerNib:[UINib nibWithNibName:@"LoLTextTableViewCell" bundle:nil] forCellReuseIdentifier:@"lolTextCell"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"LoLTextVideoTableViewCell" bundle:nil] forCellReuseIdentifier:@"videocell"];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.myTableView.showsVerticalScrollIndicator = NO;
    self.myTableView.separatorColor = [UIColor lightGrayColor];
    
   }
- (NSString *)urlStr {
    NSString *str = [NSString stringWithFormat:kLoLtext,self.page];
    return str;
}
- (NSString *)scUrl {
    return [NSString stringWithFormat:kLoLsc,self.page];
}

-(void)loadScDataSource {
    if (![[AFNetworkReachabilityManager sharedManager]isReachable]) {
       // [self endRefresh];
        //读取本地数据
        NSArray *arr = [CacheManager readDataWithUrl:[self scUrl]];
        
         NSLog(@"缓存中读取数据%ld",arr.count);
        self.scDataSource = [LPModelJokeList arrayOfModelsFromDictionaries:arr];
        
        StartGuide *headerView = [[StartGuide alloc] initWithModeArray:self.scDataSource frame:CGRectMake(0, 0, self.view.frame.size.width, 200) isLabel:YES goView:^(NSInteger currentPage) {
            LoLDetailViewController *lolVC = [[LoLDetailViewController alloc] init];
            LPModelJokeList *mode = self.scDataSource[currentPage];
            lolVC.mode = mode;
            if (!mode.intent) {
                [self.navigationController pushViewController:lolVC animated:YES];
            }else {
                
                LoLSubjectViewController * lolsubVC = [[LoLSubjectViewController alloc] init];
                [self.navigationController pushViewController:lolsubVC animated:YES];
            }
        }];
        self.myTableView.tableHeaderView = headerView;
        //刷新界面
       [self.myTableView reloadData];
        return;
    }

    if ([self scUrl]) {
        
    HttpEngine *engine = [HttpEngine shareEngine];
    [engine GET:[self scUrl] success:^(id response) {
        NSArray *list = response[@"list"];
        [CacheManager saveData:list withUrl:[self scUrl]];
       
        NSError *error = nil;
            self.scDataSource = [LPModelJokeList arrayOfModelsFromDictionaries:list error:&error];
       // NSLog(@"------%ld",self.scDataSource.count);
        StartGuide *headerView = [[StartGuide alloc] initWithModeArray:self.scDataSource frame:CGRectMake(0, 0, self.view.frame.size.width, 200) isLabel:YES goView:^(NSInteger currentPage) {
            LoLDetailViewController *lolVC = [[LoLDetailViewController alloc] init];
            LPModelJokeList *mode = self.scDataSource[currentPage];
            lolVC.mode = mode;
            if (!mode.intent) {
                [self.navigationController pushViewController:lolVC animated:YES];
            }else {
                
                LoLSubjectViewController * lolsubVC = [[LoLSubjectViewController alloc] init];
                [self.navigationController pushViewController:lolsubVC animated:YES];
            }
        }];
        self.myTableView.tableHeaderView = headerView;
        // NSLog(@"------%ld",_dataSource.count);
        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    }
    
}
-(void)loadDataSource {
    if (![[AFNetworkReachabilityManager sharedManager]isReachable]) {
        [self endRefresh];
        //读取本地数据
        NSArray *arr = [CacheManager readDataWithUrl:[self urlStr]];
        // NSLog(@"缓存中读取数据");
        self.dataSource = [LPModelJokeList arrayOfModelsFromDictionaries:arr];
        //刷新界面
        [self.myTableView reloadData];
        return;
    }
    HttpEngine *engine = [HttpEngine shareEngine];
    if ([self urlStr]) {
      //  NSLog(@"---------------%@")
        [engine GET:[self urlStr] success:^(id response) {
            // NSLog(@"请求成功---%@",response);
            NSMutableArray *list =[NSMutableArray arrayWithArray: response[@"list"]];
            [CacheManager saveData:list withUrl:[self urlStr]];
            for (int i = 0; i < list.count; i++) {
                if (list[i][@"intent"] != NULL) {
                    [list  removeObjectAtIndex:i];
                }
            }
            
        
            if (self.isPullDown) {
                self.dataSource = [LPModelJokeList arrayOfModelsFromDictionaries:list];
              }
            if (self.isLoadMore) {
                [self.dataSource addObjectsFromArray:[LPModelJokeList arrayOfModelsFromDictionaries:list]];
            }
            [self endRefresh];
            [self.myTableView reloadData];
        } failure:^(NSError *error) {
//            NSLog(@"请求失败--- %@",error);
//            NSLog(@"请检查网络");
        }];
    }

}
- (void)createPullHeaderRefresh {
    __weak LoLNewsViewController *weakSelf = self;
    [self.myTableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        //标识正在下拉
        weakSelf.isPullDown = YES;
        //初始化数据
        [weakSelf refreshPage];
        //请求数据
        
        [weakSelf loadDataSource];
        if (self.page == 1) {
        [weakSelf loadScDataSource];
        }
        
        
        
        
    }];
}
#pragma mark - 实现代理

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LPModelJokeList *mode = self.dataSource[indexPath.row];
    if (indexPath.row == 0) {
       // NSLog(@"!!!!!!!!!!!%@",mode.article_url);
    }
    if ([mode.image_with_btn isEqualToString:@"True"]) {
        LoLTextVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videocell"];
        [cell configData:mode];
        return cell;
    } else {
    LoLTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lolTextCell"];
    
    [cell configData:mode];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LPModelJokeList *mode = self.dataSource[indexPath.row];
    
    if ([mode.is_subject isEqualToString:@"1"]) {
        LoLSubjectViewController * lolsubVC = [[LoLSubjectViewController alloc] init];
        lolsubVC.title = @"联英雄盟";
        lolsubVC.isSubject = YES;
        [self.navigationController pushViewController:lolsubVC animated:YES];
    }else {
    LoLDetailViewController *lolVC = [[LoLDetailViewController alloc] init];
        lolVC.title = @"联英雄盟";
    lolVC.mode = mode;
    [self.navigationController pushViewController:lolVC animated:YES];
    }
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
