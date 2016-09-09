//
//  HttpEngine.h
//  ZZ15191060WangPengYu
//
//  Created by Qianfeng on 16/2/20.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import <Foundation/Foundation.h>
//成功的回调blcok
typedef void(^SucessBlcokType)(id response);
//失败的回调的blcok
typedef void(^FailedBlockType)(NSError *error);

@interface HttpEngine : NSObject

+ (instancetype)shareEngine ;

- (void)GET:(NSString*)URLString success:(SucessBlcokType)success failure:(FailedBlockType)failure;
@end