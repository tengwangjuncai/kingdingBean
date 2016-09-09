//
//  RootViewController.m
//  KiddingBean
//
//  Created by Qianfeng on 16/2/25.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "RootViewController.h"
#import "TabBarController.h"
#import "AppDelegate.h"
#import "StartGuide.h"
#include "RecordAppLoad.h"
@interface RootViewController ()
@property (nonatomic, strong)UIImageView *adImageView;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic) NSInteger adInterVal;
@property (nonatomic, strong)UILabel *timerLabel;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([RecordAppLoad isFirstLoadApp]) {
        //第一次打开 软件介绍或新特性
        [self startGuide];
    }else {
        //不是第一次打开 加载图
        [self showAD];
        [self createTimer];
    }
    NSLog(@"调了");
}
/**
 *  为软件加载图创建定时器
 */
- (void)createTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeTimer) userInfo:nil repeats:YES];
}
/**
 *  改变加载时间
 */
- (void)changeTimer {
    _adInterVal--;
    if (_adInterVal == 0) {
        [_timer invalidate];
        [self goTabBar];
    }
    //_timerLabel.text = [NSString stringWithFormat:@"%ld秒",_adInterVal];
}
/**
 *  显示广告或者软件加载图
 */
- (void)showAD {
    UIImage * image = [UIImage imageNamed:@"LaunchImage-700-568h"];
    _adImageView = [[UIImageView alloc] initWithFrame:kScreenFrame];
    _adImageView.image = image;
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
//    btn.frame = CGRectMake(kScreenWidth - 150, 20, 100, 30);
//    [btn setTitle:@"跳过" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(skip) forControlEvents:UIControlEventTouchUpInside];
    
//    _timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 50, 25, 30, 20)];
    _adInterVal = 1;
    //_timerLabel.text = [NSString stringWithFormat:@"%ld秒",_adInterVal];
    _adImageView.userInteractionEnabled = YES;
    //[_adImageView addSubview:_timerLabel];
    //[_adImageView addSubview:btn];
    [self.view addSubview:_adImageView];
}
/**
 *  跳过加载视图
 */
- (void)skip {
    _adImageView.alpha = 0;
    [_adImageView removeFromSuperview];
    [_timer invalidate];
    [self goTabBar];
}
/**
 *  直接进入程序主界面
 */
- (void)goTabBar {
    //在这里判断进入那个界面
    //1 强登录 是否已经登录
    //2 不用登录 直接进入
    TabBarController * tabBarVC = [[TabBarController alloc]init];
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    app.window.rootViewController = tabBarVC;
}
/**
 *  软件导航或者显示其新特性
 */
- (void)startGuide {
    NSArray * imageArray = @[@"guide_page1",@"guide_page2",@"guide_page3",@"guide_page4"];
    StartGuide *sG = [[StartGuide alloc] initWithImageArray:imageArray isUrl:NO isBtn:YES frame:kScreenFrame goView:^{
        [self goTabBar];
    }];
    [self.view addSubview:sG];
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
