//
//  WPYSpinerLayer.h
//  WPYAnimation
//
//  Copyright © 2016年 wpy. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface WPYSpinerLayer : CAShapeLayer

- (instancetype)initWithFrame:(CGRect)frame;

- (void)beginAnimation;

- (void)stopAnimation;
@end
