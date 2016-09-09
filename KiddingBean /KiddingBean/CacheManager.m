//
//  CacheManager.m
//  KiddingBean
//
//  Created by Qianfeng on 16/2/29.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "CacheManager.h"
#import "NSString+Hashing.h"
@implementation CacheManager
//指定一个存取数据的路径 方便存取
+(NSString *)cacheDirectory {
    
    //创建一个路径
    NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    cacheDir = [cacheDir stringByAppendingPathComponent:@"dataCache"];
    BOOL bret = [[NSFileManager defaultManager]createDirectoryAtPath:cacheDir withIntermediateDirectories:YES attributes:nil error:nil];
    if (bret) {
        NSLog(@"获取成功");
    }
    return cacheDir;
}
+(NSString *)fullPathWithUrl:(NSString *)urlStr {
    //先去得到路径
    NSString *cacheDir = [self cacheDirectory];
    //得到加密后的字符串
    NSString *md5Str = [urlStr MD5Hash];
    NSString *fullPath = [cacheDir stringByAppendingPathComponent:md5Str];
    return fullPath;
}
//存取数据
+ (void)saveData:(id)object withUrl:(NSString *)urlStr {
    NSString *path = [self fullPathWithUrl:urlStr];
    
    //把对象转化成二进制数据
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    //把数据写入文件
    BOOL res = [data writeToFile:path atomically:YES];
    if (res) {
        NSLog(@"写入成功");
    }else {
        NSLog(@"写入失败");
    }
}

//读取数据
+ (id)readDataWithUrl:(NSString *)urlStr {
    //先把URL 转换为抵制路径
    NSString *path = [self fullPathWithUrl:urlStr];
    //读取数据
    NSData *data = [NSData dataWithContentsOfFile:path];
    //最后返回的时候，要吧二进制数据转化为对象(解归档)
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}


@end
