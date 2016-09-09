//
//  RecordAppLoad.m
//  KiddingBean
//
//  Created by Qianfeng on 16/2/25.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "RecordAppLoad.h"

@implementation RecordAppLoad

/**
 *  记录软件登录次数
 */
+ (void)recordAppLoadNum {
    NSInteger num = [[NSUserDefaults standardUserDefaults] integerForKey:kAppLoadNum];
    num ++;
    [[NSUserDefaults standardUserDefaults] setInteger:num forKey:kAppLoadNum];
    //同步更新
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  是否是第一次登录
 *
 *  @return YES or NO
 */
+(BOOL)isFirstLoadApp {
    NSInteger num = [[NSUserDefaults standardUserDefaults] integerForKey:kAppLoadNum];
    if (num == 1) {
        return YES;
    }else {
        return NO;
    }
}
@end
