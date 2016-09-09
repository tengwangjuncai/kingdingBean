//
//  ReadCartoonViewController.m
//  KiddingBean
//
//  Created by Qianfeng on 16/3/4.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "ReadCartoonViewController.h"
#import "PicReturndata.h"
#import "HttpEngine.h"
#import "LPModelJokeChapter_List.h"
#import "ReadTableViewCell.h"
@interface ReadCartoonViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSource;

@property (nonatomic, strong)UILabel *Pagelabel;
@end

@implementation ReadCartoonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadDataSource];
    [self createTableView];
}
- (NSString *)urlStr  {
    
    LPModelJokeChapter_List *mode = self.listSource[_currentPage];
    
    return [NSString stringWithFormat:kCartoonShow,mode.chapter_id];
}
- (void)loadDataSource {
    HttpEngine *engine = [HttpEngine shareEngine];
    [engine GET:[self urlStr] success:^(id response) {
        NSArray *returnData = response[@"data"][@"returnData"];
        self.dataSource = [PicReturndata arrayOfModelsFromDictionaries:returnData];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"ReadTableViewCell" bundle:nil] forCellReuseIdentifier:@"readcell"];
    self.tableView.estimatedRowHeight = 100;
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    UIButton *lastBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    lastBtn.frame = CGRectMake(kScreenWidth/2 - 100, 0, 50, 30);
    [lastBtn setTitle:@"上一章" forState:UIControlStateNormal];
    [lastBtn addTarget:self action:@selector(lastBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:lastBtn];
    
    _Pagelabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 80)/2, 0, 80, 30)];
    _Pagelabel.textAlignment = NSTextAlignmentCenter;
    [footerView addSubview:_Pagelabel];
    
    _Pagelabel.text = [NSString stringWithFormat:@"第 %ld 章",self.currentPage + 1];
    _Pagelabel.font = [UIFont systemFontOfSize:15];
    CGFloat pageLabelX = CGRectGetMaxX(_Pagelabel.frame);
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    nextBtn.frame = CGRectMake(pageLabelX + 10, 0, 50, 30);
    [nextBtn setTitle:@"下一章" forState:UIControlStateNormal];
    
    [nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:nextBtn];
    
    self.tableView.tableFooterView = footerView ;
                                         
}

- (void)lastBtnClick:(UIButton *)btn {
    if (self.currentPage >0) {
        self.currentPage --;
        
        [self loadDataSource];
        self.tableView.contentOffset = CGPointMake(0, 0);
        self.Pagelabel.text = [NSString stringWithFormat:@"第 %ld 章",self.currentPage + 1];
        //[self.tableView reloadData];
    }else {
        self.Pagelabel.text = @"已是第一章";
    }
}

- (void)nextBtnClick:(UIButton *)btn {
    if (self.currentPage < self.listSource.count-1) {
        self.currentPage ++;
        [self loadDataSource];
        self.tableView.contentOffset = CGPointMake(0, 0);
        self.Pagelabel.text = [NSString stringWithFormat:@"第 %ld 章",self.currentPage + 1];
                //[self.tableView reloadData];
    }else {
        self.Pagelabel.text = @"已是最后章";
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"readcell"];
    PicReturndata *mode = self.dataSource[indexPath.row];
    [cell configData:mode];
    return cell;
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
