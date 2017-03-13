//
//  WPYLoginButton.m
//  WPYAnimation
//
//  Copyright © 2016年 wpy. All rights reserved.
//

#import "WPYLoginButton.h"
#import "WPYSpinerLayer.h"
@interface WPYLoginButton()<CAAnimationDelegate>

@property (nonatomic, assign)CFTimeInterval shrinkDuration;

@property (nonatomic, strong)CAMediaTimingFunction *shrinkCurve;

@property (nonatomic, strong)CAMediaTimingFunction *expandCurve;

@property (nonatomic, copy)LoginAnimation login;

@property (nonatomic, strong)UIColor *color;

@property (nonatomic, strong)WPYSpinerLayer *spinerLayer;
@end
@implementation WPYLoginButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _spinerLayer = [[WPYSpinerLayer alloc] initWithFrame:self.frame];
        _shrinkCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        _expandCurve = [CAMediaTimingFunction functionWithControlPoints:0.95 :0.02 :1 :0.05];
        self.shrinkDuration = 0.1;
        [self.layer addSublayer:_spinerLayer];
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.layer.cornerRadius = CGRectGetHeight(self.frame)/2;
    self.clipsToBounds = YES;
    [self addTarget:self action:@selector(scalesToSmall) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(scaleAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(scaleToDefault) forControlEvents:UIControlEventTouchDragExit];
}

- (void)scalesToSmall {
    typeof(self) __weak weak = self;
    self.transform = CGAffineTransformMakeScale(1, 1);
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5f initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        weak.transform = CGAffineTransformMakeScale(0.9, 0.9);
    } completion:nil];
}

- (void)scaleAnimation {
    typeof(self) __weak weak = self;
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5f initialSpringVelocity:0.0f options:UIViewAnimationOptionLayoutSubviews animations:^{
        weak.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
    [self beginAnimation];
}

- (void)scaleToDefault {
    typeof(self) __weak weak = self;
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5f initialSpringVelocity:0.4f options:UIViewAnimationOptionLayoutSubviews animations:^{
        weak.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
}

- (void)beginAnimation {
    [self performSelector:@selector(revert) withObject:nil afterDelay:0.f];
    [self.layer addSublayer:_spinerLayer];
    
    CABasicAnimation *shrinkToSmallAnimation = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    shrinkToSmallAnimation.fromValue = @(CGRectGetWidth(self.bounds));
    shrinkToSmallAnimation.toValue = @(CGRectGetHeight(self.bounds));
    shrinkToSmallAnimation.duration = _shrinkDuration;
    shrinkToSmallAnimation.timingFunction = _shrinkCurve;
    shrinkToSmallAnimation.fillMode = kCAFillModeForwards;
    shrinkToSmallAnimation.removedOnCompletion = false;
    [self.layer addAnimation:shrinkToSmallAnimation forKey:shrinkToSmallAnimation.keyPath];
    
    [_spinerLayer beginAnimation];
    [self setUserInteractionEnabled:false];
}

- (void)LoginSucceedCompletion:(LoginAnimation)completion {
    _login = completion;
    
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    expandAnimation.fromValue = @(1.0);
    expandAnimation.toValue = @(55.0);
    expandAnimation.timingFunction = _expandCurve;
    expandAnimation.duration = 0.3;
    expandAnimation.delegate = self;
    expandAnimation.removedOnCompletion = false;
    [self.layer addAnimation:expandAnimation forKey:expandAnimation.keyPath];
    [_spinerLayer stopAnimation];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.login();
        //[self didStopAnimation];
        [self setUserInteractionEnabled:YES];
    });
   
}

- (void)LoginFailedCompletion:(LoginAnimation)completion {
    _login = completion;
    
    CABasicAnimation * shrinkBackAnimation = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    shrinkBackAnimation.fromValue = @(CGRectGetHeight(self.bounds));
    shrinkBackAnimation.toValue = @(CGRectGetWidth(self.bounds));
    shrinkBackAnimation.duration = _shrinkDuration;
    shrinkBackAnimation.timingFunction = _shrinkCurve;
    shrinkBackAnimation.fillMode = kCAFillModeForwards;
    shrinkBackAnimation.removedOnCompletion = false;
    
    _color = self.backgroundColor;
    
    CABasicAnimation *backgroundColorAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    backgroundColorAnimation.toValue = (__bridge id)[UIColor redColor].CGColor;
    backgroundColorAnimation.duration = 0.1f;
    backgroundColorAnimation.timingFunction = _shrinkCurve;
    backgroundColorAnimation.fillMode = kCAFillModeForwards;
    backgroundColorAnimation.removedOnCompletion = false;
    
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint point = self.layer.position;
    
    keyFrameAnimation.values = @[[NSValue valueWithCGPoint:CGPointMake(point.x, point.y)],[NSValue valueWithCGPoint:CGPointMake(point.x - 10, point.y)],[NSValue valueWithCGPoint:CGPointMake(point.x + 10, point.y)],[NSValue valueWithCGPoint:CGPointMake(point.x - 10, point.y)],[NSValue valueWithCGPoint:CGPointMake(point.x + 10, point.y)],[NSValue valueWithCGPoint:CGPointMake(point.x - 10, point.y)],[NSValue valueWithCGPoint:CGPointMake(point.x + 10, point.y)],[NSValue valueWithCGPoint:CGPointMake(point.x, point.y)]];
    keyFrameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    keyFrameAnimation.duration = 0.5f;
    keyFrameAnimation.delegate = self;
    self.layer.position = point;
    
    [self.layer addAnimation:backgroundColorAnimation forKey:backgroundColorAnimation.keyPath];
    [self.layer addAnimation:keyFrameAnimation forKey:keyFrameAnimation.keyPath];
    [self.layer addAnimation:shrinkBackAnimation forKey:shrinkBackAnimation.keyPath];
    
    [self.spinerLayer stopAnimation];
    [self setUserInteractionEnabled:true];
    
}

- (void)revert {
    CABasicAnimation *backgroundColorRevertAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    backgroundColorRevertAnimation.toValue = (__bridge id)self.backgroundColor.CGColor;
    backgroundColorRevertAnimation.duration = 0.1f;
    backgroundColorRevertAnimation.timingFunction = _shrinkCurve;
    backgroundColorRevertAnimation.fillMode = kCAFillModeForwards;
    backgroundColorRevertAnimation.removedOnCompletion = false;
    [self.layer addAnimation:backgroundColorRevertAnimation forKey:@"backgroundColorRever"];
  
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    CABasicAnimation * animation = (CABasicAnimation *)anim;
    if ([animation.keyPath isEqualToString:@"transform.scale"]) {
        if (_login) {
            
        }
        [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(didStopAnimation) userInfo:nil repeats:NO];
    }
}

- (void)didStopAnimation {
    
    [self.layer removeAllAnimations];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
