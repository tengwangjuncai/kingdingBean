//
//  WPYNavBar.h
//  KiddingBean
//
//  Created by Qianfeng on 16/2/26.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WPYNavBarDelegat <NSObject>

@optional
/**
 *  获取点击下标
 */
-(void)selectChangetoViewNum:(NSInteger)num;

@end
@interface WPYNavBar : UIView
@property (nonatomic, strong)id<WPYNavBarDelegat> delegate;
@property (nonatomic, strong)NSMutableArray *ButtonArray;
@property (nonatomic, strong)UIColor *titleColor;
@property (nonatomic, strong)UIColor *selectColor;
@property (nonatomic, strong)UIFont  *titleFont;

- (void)AddNavBarArray:(NSArray *)NavBarArray isBtnLine:(BOOL)isBtnLine btnLineColor:(UIColor *)color;
- (instancetype)initWithFrame:(CGRect)frame titleColor:(UIColor *)titleColor andSelectTitleColor:(UIColor *)selectTitleColor;
- (void)selectTheButton:(NSInteger)btn;
@end
