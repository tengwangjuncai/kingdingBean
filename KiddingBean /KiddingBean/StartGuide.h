//
//  StartGuide.h
//  KiddingBean
//
//  Created by Qianfeng on 16/2/25.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  block块实现回调
 */
typedef void(^BlockgoView)(NSInteger currentPage);
typedef void(^BlockBack)(void);
@interface StartGuide : UIView<UIScrollViewDelegate>

@property (nonatomic, copy)BlockBack block;
@property (nonatomic, copy)BlockgoView blockgoView;
-(instancetype)initWithImageArray:(NSArray *)imageArray isUrl:(BOOL)isUrl isBtn:(BOOL)isBtn frame:(CGRect)frame goView:(BlockBack)block;
-(instancetype)initWithModeArray:(NSArray *)modeArray frame:(CGRect)frame isLabel:(BOOL)isLabel goView:(BlockgoView)block;
@property (nonatomic, strong)UIPageControl *pageControl;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic)NSInteger currentPage;
@property (nonatomic)NSInteger count;
@property (nonatomic, strong) UIScrollView *scrollView;
@end
