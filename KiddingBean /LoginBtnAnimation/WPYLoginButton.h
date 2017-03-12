//
//  WPYLoginButton.h
//  WPYAnimation
//
//  Copyright © 2016年 wpy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LoginAnimation)(void);
@interface WPYLoginButton : UIButton

- (instancetype)initWithFrame:(CGRect)frame;

- (void)LoginSucceedCompletion:(LoginAnimation)completion;

- (void)LoginFailedCompletion:(LoginAnimation)completion;
@end
