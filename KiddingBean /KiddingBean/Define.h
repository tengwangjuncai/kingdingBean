//
//  Define.h
//  KiddingBean
//
//  Created by Qianfeng on 16/2/25.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#ifndef Define_h
#define Define_h

#define kHight kScreenWidth + 117
#define kPlayerH kScreenWidth + 59


#define kAppLoadNum @"kAppLoadNum"
#define kScreenFrame [UIScreen mainScreen].bounds
#define kScreenWidth kScreenFrame.size.width
#define kScreenHeight kScreenFrame.size.height
//段子
#define ktext @"http://m2.qiushibaike.com/article/list/text?page=%d&count=30"
#define kPicture @"http://m2.qiushibaike.com/article/list/imgrank?count=%d&page=%d"
#define kBestPic @"http://m2.qiushibaike.com/article/list/day?count=%d&page=%d"
#define kcomment @"http://m2.qiushibaike.com/article/%@/comments?count=%d&page=%d"
#define kpic @"http://pic.qiushibaike.com/system/pictures/%@/%@/medium/%@"
#define KuserIcon @"http://pic.qiushibaike.com/system/avtnew/%@/%@/medium/%@"
#define kdetail @"http://m2.qiushibaike.com/article/%@/comments?count=%d&page=%d"
#define kLoLsc @"http://qt.qq.com/static/pages/news/phone/c13_list_%d.shtml"
#define kLoLtext @"http://qt.qq.com/static/pages/news/phone/c12_list_%d.shtml"
#define kLoLdetail @"http://qt.qq.com/static/pages/news/phone/%@"
#define kLoLSubjectSc @"http://qt.qq.com/static/pages/news/phone/c160_list_%d.shtml"
#define kLoLSubjectCell @"http://qt.qq.com/static/pages/news/phone/c161_list_%d.shtml"
#define kLoLActSc @"http://qt.qq.com/static/pages/news/phone/c182_list_%d.shtml"
#define kLoLActCell @"http://qt.qq.com/static/pages/news/phone/c183_list_%d.shtml"
#define kVideo @"http://m2.qiushibaike.com/article/list/video?page=%d&count=%d"
#define kLoLVideo @"http://waqu.com/v3/video/pv.json?ts=%d&platform=and&appName=lol&profile=general_and&sid=28e31fb5f5cf&partner=0002&appVersion=3.4.5&size=10"
#define kLoLrelated @"http://waqu.com/v3/video/vrv.json?ts=%d&platform=and&appName=lol&profile=general_and&sid=28e31fb5f5cf&partner=0002&appVersion=3.4.5&wid=%@&size=10"
#define kCartoon @"http://app.u17.com/v3/app/android/phone/list/index?size=20&argName=theme&argValue=1&con=%d&android_id=b9f9ede10476d592&key=null&come_from=ff26&model=SM-G9009D"
#define kCartoonDetail @"http://app.u17.com/v3/app/android/phone/comic/detail_static?comicid=%@&android_id=b9f9ede10476d592&key=null&come_from=ff26&model=SM-G9009D"
#define kCartoonShow @"http://app.u17.com/v3/app/android/phone/comic/chapter?chapter_id=%@&android_id=b9f9ede10476d592&key=null&come_from=ff26&model=SM-G9009D"
#endif /* Define_h */
