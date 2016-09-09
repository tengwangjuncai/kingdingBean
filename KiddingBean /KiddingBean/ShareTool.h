//
//  ShareTool.h
//  KiddingBean
//
//  Created by Qianfeng on 16/3/8.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocial.h"
@interface ShareTool : UIViewController<UMSocialUIDelegate>
@property (nonatomic,strong)ShareTool *share;
+ (instancetype)shareManager;
- (void)shareWithTheStr:(NSString *)str andImageUrl:(NSString *)imageUrl;
@end
