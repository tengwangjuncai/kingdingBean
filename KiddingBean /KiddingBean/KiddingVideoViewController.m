//
//  KiddingVideoViewController.m
//  KiddingBean
//
//  Created by Qianfeng on 16/2/26.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "KiddingVideoViewController.h"
#import "KiddingVideoDetailViewController.h"
#import "Define.h"

@interface KiddingVideoViewController ()

@end

@implementation KiddingVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"finishedPlay" object:nil];
}

- (NSString *)urlStr {
    return [NSString stringWithFormat:kVideo,self.page,self.count];
}


#pragma mark - 懒加载代码
#pragma mark - 实现代理 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return kHight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kidcell"];
    WPYFirstModel *mode = self.dataSource[indexPath.row];
    [cell configData:mode andNum:indexPath.row];
    
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    KiddingVideoDetailViewController * kvdVC = [[KiddingVideoDetailViewController alloc] init];
    kvdVC.title = @"搞笑视频";
    kvdVC.mode = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:kvdVC animated:YES];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoTableViewCell *videoCell = (VideoTableViewCell *)cell;
    [videoCell.videoController dismiss];
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
