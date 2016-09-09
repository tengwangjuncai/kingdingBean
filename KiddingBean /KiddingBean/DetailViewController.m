//
//  DetailViewController.m
//  KiddingBean
//
//  Created by Qianfeng on 16/2/26.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "DetailViewController.h"
#import "TableViewCell.h"
#import "DetailTableViewCell.h"
@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isDetailView = YES;
    self.myTableView.frame = CGRectMake(0,0, kScreenWidth, kScreenHeight - 64);
    
}
- (NSString *)urlStr {
    return [NSString stringWithFormat:kdetail,self.mode.ID,self.count,self.page];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else {
        return self.dataSource.count;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        [cell configData:_mode];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell"];
        WPYFirstModel *model = self.dataSource[indexPath.row];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configData:model];
        return cell;
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
