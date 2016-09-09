//
//  WPYUserModel.m
//  ZZ15191060WangPengYu
//
//  Created by Qianfeng on 16/2/20.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "WPYUserModel.h"

@implementation WPYUserModel
+ (JSONKeyMapper *)keyMapper {
    NSDictionary *dict = @{@"id":@"ID"};
    return [[JSONKeyMapper alloc] initWithDictionary:dict];
}
@end
