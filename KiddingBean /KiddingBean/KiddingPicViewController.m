//
//  KiddingPicViewController.m
//  KiddingBean
//
//  Created by Qianfeng on 16/2/26.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "KiddingPicViewController.h"
#import "DetailViewController.h"
@interface KiddingPicViewController ()

@end

@implementation KiddingPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isDetailView = NO;
}
- (NSString *)urlStr {
    return [NSString stringWithFormat:kPicture,self.count,self.page];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (!self.isDetailView) {
        DetailViewController *detailVC = [[DetailViewController alloc] init];
        detailVC.title = @"囧图";
        detailVC.mode = self.dataSource[indexPath.row];
        [self.navigationController pushViewController:detailVC animated:YES];
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
