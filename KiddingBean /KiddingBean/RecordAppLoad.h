//
//  RecordAppLoad.h
//  KiddingBean
//
//  Created by Qianfeng on 16/2/25.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Define.h"
@interface RecordAppLoad : NSObject
+(void)recordAppLoadNum;
+(BOOL)isFirstLoadApp;
@end
