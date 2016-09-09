//
//  NewsViewController.m
//  KiddingBean
//
//  Created by Qianfeng on 16/2/25.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "NewsViewController.h"
#import "WPYNavBar.h"
@interface NewsViewController ()<WPYNavBarDelegat,UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView *mainScrollView;
@property (nonatomic, strong)WPYNavBar *navBar;
@property (nonatomic)NSInteger currentPage;
@end
@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self createNavBar];
    [self createMainScrollView];
    self.mainScrollView.pagingEnabled = YES;
    
}
- (void)createMainScrollView {
    CGFloat scrollViewY = 37;
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, scrollViewY, self.view.frame.size.width, self.view.frame.size.height - scrollViewY - 44)];
    _mainScrollView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_mainScrollView];
    self.mainScrollView.bounces = NO;
    
    
    self.mainScrollView.delegate = self;
    //添加显示界面
    NSArray * ViewNames = @[@"jokeViewController",@"KiddingPicViewController",@"LoLNewsViewController"];
   // NSArray *ViewNames = @[@"KiddingPicViewController"];
    for (int i=0; i<ViewNames.count; i++) {
        Class cls = NSClassFromString(ViewNames[i]);
        UIViewController *viewController = [[cls alloc]init];
        viewController.view.frame = CGRectMake(i * _mainScrollView.frame.size.width, 0, _mainScrollView.frame.size.width, _mainScrollView.frame.size.height);
        [_mainScrollView addSubview:viewController.view];
        [self addChildViewController:viewController];
    }
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width * ViewNames.count,_mainScrollView.frame.size.height);
}


- (void)createNavBar {
    _navBar = [[WPYNavBar alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 37) titleColor:[UIColor lightGrayColor] andSelectTitleColor:[UIColor colorWithRed:0.1 green:0.8 blue:1 alpha:1]];
    _navBar.delegate = self;
    NSArray *btnNameArray =@[@"段子",@"囧图",@"LoL"];
    [_navBar AddNavBarArray:btnNameArray isBtnLine:YES btnLineColor:[UIColor lightGrayColor]];
    [_navBar selectTheButton:0];
    [self.view addSubview:_navBar];
    
}

#pragma mark - 实现 UIScrollViewDelegate


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _currentPage = scrollView.contentOffset.x/_mainScrollView.frame.size.width;
    NSLog(@"%ld",_currentPage);
    [self.navBar selectTheButton:_currentPage];
}
#pragma mark - WPYNavBarDelegat 
- (void)selectChangetoViewNum:(NSInteger)num {
    [UIView animateWithDuration:0.2 animations:^{
        [self.mainScrollView setContentOffset:CGPointMake(self.view.frame.size.width * num,0)];
    } completion:nil];
    //[self.mainScrollView setContentOffset:CGPointMake(self.view.frame.size.width * num,0) animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
