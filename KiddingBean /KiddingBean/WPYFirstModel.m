//
//  WPYFirstModel.m
//  ZZ15191060WangPengYu
//
//  Created by Qianfeng on 16/2/20.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "WPYFirstModel.h"

@implementation WPYFirstModel
+ (JSONKeyMapper *)keyMapper {
    NSDictionary *dict = @{@"id":@"ID"};
    return [[JSONKeyMapper alloc] initWithDictionary:dict];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"给没有定义的成员变量赋值");
}
@end
