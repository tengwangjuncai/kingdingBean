//
//  CacheManager.h
//  KiddingBean
//
//  Created by Qianfeng on 16/2/29.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  sdwebimage 缓存原理（图片）  就是把请求回来的数据，存在本地沙盒里面，把这个请求的URL用MD5加密一下，当做文件名称。
 
 */
@interface CacheManager : NSObject
//存数据,传入对象 和 URL
+ (void)saveData:(id)object withUrl:(NSString*)urlStr;
//读数据
+ (id)readDataWithUrl:(NSString*)urlStr;
@end
