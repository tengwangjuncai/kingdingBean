//
//  WPYNavBar.m
//  KiddingBean
//
//  Created by Qianfeng on 16/2/26.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "WPYNavBar.h"

@interface WPYNavBar ()
@property(nonatomic) CGFloat widthFloat;
@property(nonatomic, strong) UIView *btnLine;
@property (nonatomic) NSInteger selectBtn;
@property (nonatomic) NSInteger widthBtn;
@end
@implementation WPYNavBar

- (void)AddNavBarArray:(NSArray *)NavBarArray isBtnLine:(BOOL)isBtnLine btnLineColor:(UIColor *)color{
    NSInteger btnNum = NavBarArray.count;
    _widthBtn = (self.bounds.size.width)/(CGFloat)btnNum;
    for (int i = 0; i < btnNum; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * _widthBtn, 0, _widthBtn, self.bounds.size.height - 2)];
        [button setTitle:NavBarArray[i] forState:UIControlStateNormal];
        [button.titleLabel setFont:self.titleFont];
        [button setTitleColor:self.titleColor forState:UIControlStateNormal];
        [button setTitleColor:self.selectColor forState:UIControlStateSelected];
        [button setTag:i+100];
        [button addTarget:self action:@selector(changeButton:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0 && isBtnLine) {
            NSString *str = NavBarArray[i];
            CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
        
            _widthFloat = size.width + 10.0f;
            _btnLine = [[UIView alloc] initWithFrame:CGRectMake(button.center.x - _widthFloat/2, self.bounds.size.height -2,_widthFloat, 2)];
            [_btnLine setBackgroundColor:color];
            [self addSubview:_btnLine];
        }
        [self addSubview:button];
        [self.ButtonArray addObject:button];
    }
    [[self.ButtonArray firstObject] setSelected:YES];
}

- (void)changeButton:(UIButton *)sender {
    UIButton *btn = [self viewWithTag:sender.tag];
    [self.delegate selectChangetoViewNum:sender.tag-100];
    [UIView animateWithDuration:0.1 animations:^{
        [_btnLine setFrame:CGRectMake(btn.center.x - _widthFloat/2, self.bounds.size.height - 2, _widthFloat, 2)];
    }];
    _selectBtn = sender.tag -100;
}
- (void)selectTheButton:(NSInteger)btn {
    UIButton *button = _ButtonArray[btn];
    if (_selectBtn != btn) {
     [self.ButtonArray[_selectBtn] setSelected:NO];
        [self.ButtonArray[btn] setSelected:YES];
        [UIView animateWithDuration:0.1 animations:^{
            [_btnLine setFrame:CGRectMake(button.center.x - _widthFloat/2, self.bounds.size.height - 2, _widthFloat, 2)];
        }];
        _selectBtn = btn;
        
    }
    
}

- (instancetype)initWithFrame:(CGRect)frame titleColor:(UIColor *)titleColor andSelectTitleColor:(UIColor *)selectTitleColor {
    _selectBtn = 0;
    self.ButtonArray = [NSMutableArray arrayWithCapacity:_ButtonArray.count];
    self.titleFont = [UIFont systemFontOfSize:17];
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width,frame.size.height)];
    self.backgroundColor = [UIColor whiteColor];
    self.titleColor = titleColor;
    self.selectColor = selectTitleColor;
    
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
