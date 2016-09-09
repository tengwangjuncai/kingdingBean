//
//  VideoViewController.m
//  KiddingBean
//
//  Created by Qianfeng on 16/2/25.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "VideoViewController.h"
#import "WPYNavBar.h"
@interface VideoViewController ()<WPYNavBarDelegat,UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView *mainScrollView;
@property (nonatomic, strong)WPYNavBar *navBar;

@end
@implementation VideoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createNavBar];
    [self createMainScrollView];

}


- (void)createMainScrollView {
    CGFloat scrollViewY = 37;
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, scrollViewY, self.view.frame.size.width, self.view.frame.size.height - scrollViewY - 44)];
    _mainScrollView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_mainScrollView];
    self.mainScrollView.bounces = NO;
    self.mainScrollView.pagingEnabled = YES;
    
    self.mainScrollView.delegate = self;
    //添加显示界面
    NSArray * ViewNames = @[@"KiddingVideoViewController",@"LoLVideoViewController"];
    for (int i=0; i<ViewNames.count; i++) {
        Class cls = NSClassFromString(ViewNames[i]);
        UIViewController *viewController = [[cls alloc]init];
        viewController.view.frame = CGRectMake(i * _mainScrollView.frame.size.width, 0, _mainScrollView.frame.size.width, _mainScrollView.frame.size.height);
        [_mainScrollView addSubview:viewController.view];
        [self addChildViewController:viewController];
    }
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width * ViewNames.count, 0);
}


- (void)createNavBar {
    _navBar = [[WPYNavBar alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 37) titleColor:[UIColor lightGrayColor] andSelectTitleColor:[UIColor colorWithRed:0.1 green:0.8 blue:1 alpha:1]];
    _navBar.delegate = self;
    NSArray *btnNameArray =@[@"搞笑视频",@"英雄时刻"];
    [_navBar AddNavBarArray:btnNameArray isBtnLine:YES btnLineColor:[UIColor lightGrayColor]];
    [_navBar selectTheButton:0];
    [self.view addSubview:_navBar];
    
}

#pragma mark - 实现 UIScrollViewDelegate
static NSInteger currentPage = 0;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    currentPage = (int)(scrollView.contentOffset.x/self.view.frame.size.width);
    [self.navBar selectTheButton:currentPage];
}
#pragma mark - WPYNavBarDelegat
- (void)selectChangetoViewNum:(NSInteger)num {
    [UIView animateWithDuration:0.2 animations:^{
        [self.mainScrollView setContentOffset:CGPointMake(self.view.frame.size.width * num,0)];
    } completion:nil];
//    [self.mainScrollView setContentOffset:CGPointMake(self.view.frame.size.width * num,0) animated:YES];
}
@end
