//
//  KiddingVideoDetailViewController.m
//  KiddingBean
//
//  Created by Qianfeng on 16/3/1.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "KiddingVideoDetailViewController.h"
#import "DetailTableViewCell.h"
#import "VideoTableViewCell.h"
@interface KiddingVideoDetailViewController ()

@end

@implementation KiddingVideoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.myTableView registerClass:[VideoTableViewCell class] forCellReuseIdentifier:@"videoDetailCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return kHight;
    }else {
    return 102;
    }
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
        VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videoDetailCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configData:self.mode andNum:indexPath.row];
        return cell;
    }else {
        DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        WPYFirstModel *model = self.dataSource[indexPath.row];
        [cell configData:model];
        return cell;
    }
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
