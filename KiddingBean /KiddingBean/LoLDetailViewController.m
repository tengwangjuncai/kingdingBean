//
//  LoLDetailViewController.m
//  KiddingBean
//
//  Created by Qianfeng on 16/2/27.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "LoLDetailViewController.h"
#import "Define.h"
@interface LoLDetailViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation LoLDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSURLRequest *requst = [NSURLRequest requestWithURL:[NSURL URLWithString:[self urlStr]]];
    _webView.dataDetectorTypes = UIDataDetectorTypeAll;
    [_webView loadRequest:requst];
    
}
- (NSString *)urlStr {
    if ([_mode.is_direct isEqualToString:@"True"]) {
        return _mode.article_url;
    }else {
    return [NSString stringWithFormat:kLoLdetail,_mode.article_url];
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
