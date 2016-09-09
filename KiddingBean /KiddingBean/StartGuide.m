//
//  StartGuide.m
//  KiddingBean
//
//  Created by Qianfeng on 16/2/25.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "StartGuide.h"
#import "UIImageView+WebCache.h"
#import "LPModelJokeList.h"
@implementation StartGuide


/**
 *  初始化页面
 */
//功能导航的创建
- (instancetype)initWithImageArray:(NSArray *)imageArray isUrl:(BOOL)isUrl isBtn:(BOOL)isBtn frame:(CGRect)frame goView:(BlockBack)block {
    if (self = [super init]) {
        self.frame = frame;
        [self createScrollViewWithImageArray:imageArray isUrl:isUrl isBtn:isBtn];
        [self createPageControl2:imageArray.count];
        //创建scrollView
        _block = block;
    }
    return self;
}
//图片展示的创建
-(instancetype)initWithModeArray:(NSArray *)modeArray frame:(CGRect)frame isLabel:(BOOL)isLabel goView:(BlockgoView)block {
    if (self = [super init]) {
        self.frame = frame;
        [self createScrollViewWithModeArray:modeArray isLabel:isLabel];
        [self createTimer:modeArray.count];
        if (modeArray.count>1) {
            [self createPageControl:modeArray.count];
        }
        _blockgoView = block;
        _count = 0;
        _currentPage = 0;
    
    }
    return self;
}
//创建定时器
- (void)createTimer:(NSInteger)pages {
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeTime:) userInfo:[NSNumber numberWithInteger:pages]repeats:YES];
}
- (void)changeTime:(NSTimer *)timer {
    NSInteger pages = [timer.userInfo integerValue];
    _count ++;
    if (_count == 5) {
        _currentPage++;
        if (_currentPage < pages) {
            self.scrollView.contentOffset = CGPointMake(_currentPage * self.bounds.size.width,0);
            self.pageControl.currentPage = _currentPage;
        }else {
            _currentPage = 0;
            self.scrollView.contentOffset = CGPointMake(_currentPage * self.bounds.size.width,0);
            self.pageControl.currentPage = _currentPage;
        }
         _count = 0;
    }
    
    
    
}
-(void)createScrollViewWithModeArray:(NSArray *)modeArray isLabel:(BOOL)isLabel {

    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    _scrollView.backgroundColor = [UIColor colorWithRed:0.8 green:0.9 blue:1 alpha:1];
    _scrollView.contentSize = CGSizeMake(self.bounds.size.width * modeArray.count, self.bounds.size.height);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    for (int num = 0; num < modeArray.count; num ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(num * self.bounds.size.width, 1, self.bounds.size.width, self.bounds.size.height-30)];
        LPModelJokeList *mode = modeArray[num];
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(num * self.bounds.size.width +10, self.bounds.size.height - 25, self.bounds.size.width - 110, 20)];
        contentLabel.textColor = [UIColor grayColor];
        contentLabel.text = mode.title;
       // NSLog(@"%@",mode.title);
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:mode.image_url_big] placeholderImage:[UIImage imageNamed:@""]];
        [_scrollView addSubview:contentLabel];
        [_scrollView addSubview:imageView];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [_scrollView addGestureRecognizer:tap];
}
- (void)tap:(UITapGestureRecognizer *)sender {
    _blockgoView(_currentPage);
}


- (void)createPageControl2:(NSInteger)pages {
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.bounds.size.width - 150)/2, self.bounds.size.height - 200,150,20)];
    [self addSubview:_pageControl];
    _pageControl.numberOfPages = pages;
    _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    _pageControl.pageIndicatorTintColor = [UIColor groupTableViewBackgroundColor];
}
/**
 *  创建PageControl
 */
- (void)createPageControl:(NSInteger)pages {
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.bounds.size.width - 90, self.bounds.size.height - 25, 80,20)];
    [self addSubview:_pageControl];
    _pageControl.numberOfPages = pages;
    _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    _pageControl.pageIndicatorTintColor = [UIColor groupTableViewBackgroundColor];
}
/**
 *  创建功能导航滚动视图
 *
 *  @param imageArray 图片路径或者url
 *  @param isUrl      是否是网络图片
 *  @param isBtn      是否要体验按钮
 */
- (void)createScrollViewWithImageArray:(NSArray *)imageArray isUrl:(BOOL)isUrl isBtn:(BOOL)isBtn{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(self.bounds.size.width * imageArray.count, self.bounds.size.height);
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    for (int num = 0; num < imageArray.count; num ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(num * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
        [scrollView addSubview:imageView];
        if (isUrl) {
       //网络加载
            [imageView sd_setImageWithURL:imageArray[num] placeholderImage:[UIImage imageNamed:@""]];
        }else {
            //本地图片
            UIImage *image = [UIImage imageNamed:imageArray[num]];
            imageView.image = image;
        }
        if ((num == imageArray.count - 1) && isBtn) {
            UIButton *btn = [self createButton];
            imageView.userInteractionEnabled = YES;
            [imageView addSubview:btn];
            [btn addTarget:self action:@selector(btnPressed) forControlEvents:UIControlEventTouchUpInside];
            
        }
    }
}
- (UIButton *)createButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake((self.bounds.size.width -150)/2, self.bounds.size.height - 100, 150, 40);
    [btn setTitle:@"立即体验" forState:UIControlStateNormal];
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 10;
    btn.layer.borderColor = [UIColor greenColor].CGColor;
    btn.layer.borderWidth = 1.0;
    
    return btn;
    }

- (void)btnPressed {
    _block();
    NSLog(@"调了");
}

#pragma mark - 实现代理
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _currentPage = scrollView.contentOffset.x/scrollView.frame.size.width;
    self.pageControl.currentPage = _currentPage;
    _count = 0;
    [self.timer setFireDate:[NSDate distantPast]];
}
@end
