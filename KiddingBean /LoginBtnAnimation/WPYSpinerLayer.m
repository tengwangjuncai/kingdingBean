//
//  WPYSpinerLayer.m
//  WPYAnimation
//
//  Copyright © 2016年 wpy. All rights reserved.
//

#import "WPYSpinerLayer.h"
#import <UIKit/UIKit.h>
@implementation WPYSpinerLayer

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        CGFloat radius = CGRectGetHeight(frame) / 4;
        self.frame = CGRectMake(0, 0, CGRectGetHeight(frame), CGRectGetHeight(frame));
        CGPoint center = CGPointMake(CGRectGetHeight(frame)/2, CGRectGetMidY(self.bounds));
        CGFloat startAngle = 0 - M_PI_2;
        CGFloat endAngle = M_PI * 2  - M_PI_2;
        BOOL clock = YES;
        self.path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:clock].CGPath;
        self.fillColor = nil;
        self.strokeColor = [UIColor whiteColor].CGColor;
        self.lineWidth = 1;
        self.strokeEnd = 0.4;
        self.hidden = true;
    }
    
    return self;
}

- (void)beginAnimation {
    self.hidden = false;
    CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotate.fromValue = 0;
    rotate.toValue = @(M_PI * 2);
    // 动画的节奏
    
    //kCAMediaTimingFunctionLinear  线性匀速
    //kCAMediaTimingFunctionEaseIn  先慢后快
    //kCAMediaTimingFunctionEaseOut 先快后慢
    //kCAMediaTimingFunctionEaseInEaseOut 中间快两头慢
    //kCAMediaTimingFunctionDefault 一般的动画
    rotate.duration = 0.4;
    rotate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
//    kCAFillModeRemoved 这个是默认值，也就是说当动画开始前和动画结束后，动画对layer都没有影响，动画结束后，layer会恢复到之前的状态
//    
//    kCAFillModeForwards 当动画结束后，layer会一直保持着动画最后的状态
//    
//    kCAFillModeBackwards 在动画开始前，只需要将动画加入了一个layer，layer便立即进入动画的初始状态并等待动画开始。
//    
//    kCAFillModeBoth 这个其实就是上面两个的合成.动画加入后开始之前，layer便处于动画初始状态，动画结束后layer保持动画最后的状态
//    
//    文／加斯加的猿（简书作者）
    
   //http://www.jianshu.com/p/8c1c1697c0ce  在这里有详细的讲解
    rotate.repeatCount = NSNotFound;
    rotate.fillMode = kCAFillModeForwards;
    rotate.removedOnCompletion = false;//默认为YES，代表动画执行完毕后就从图层上移除，图形会恢复到动画执行前的状态。如果想让图层保持显示动画执行后的状态，那就设置为NO，不过还要设置fillMode为kCAFillModeForwards
    [self addAnimation:rotate forKey:rotate.keyPath];
    
}

- (void)stopAnimation {
    self.hidden = true;
    [self removeAllAnimations];
}
@end
