//
//  LoLSubjectViewController.m
//  KiddingBean
//
//  Created by Qianfeng on 16/2/27.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "LoLSubjectViewController.h"

@interface LoLSubjectViewController ()

@end

@implementation LoLSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (NSString *)urlStr {
    if (self.isSubject) {
        return  [NSString stringWithFormat:kLoLSubjectCell,self.page];
    }else {
        return  [NSString stringWithFormat:kLoLActCell,self.page];
    }
    
}
- (NSString *)scUrl {
    if (self.isSubject) {
        return [NSString stringWithFormat:kLoLSubjectSc,self.page];
    }else {
        return [NSString stringWithFormat:kLoLActSc,self.page];
    }
    
}
- (int)refreshPage {
    return 1;
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
