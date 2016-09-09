//
//  VideoModel.h
//  KiddingBean
//
//  Created by Qianfeng on 16/2/28.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "JSONModel.h"

@interface VideoModel : JSONModel
@property (nonatomic, copy) NSString <Optional> * videoSize;
@property (nonatomic, copy) NSString <Optional> * title;
@property (nonatomic, copy) NSString <Optional> * preview;
@property (nonatomic, copy) NSString <Optional> * ctag;
@property (nonatomic, copy) NSString <Optional> * duration;
@property (nonatomic, copy) NSString <Optional> * url;
@property (nonatomic, copy) NSString <Optional> * offlineBySite;
@property (nonatomic, copy) NSString <Optional> * hd;
@property (nonatomic, copy) NSString <Optional> * slow;
@property (nonatomic, copy) NSString <Optional> * favCount;
@property (nonatomic, copy) NSString <Optional> * watchCount;
@property (nonatomic, copy) NSString <Optional> * flashUrl;
@property (nonatomic, copy) NSString <Optional> * download_url;
@property (nonatomic, copy) NSString <Optional> * bigImgUrl;
@property (nonatomic, copy) NSString <Optional> * wid;
@property (nonatomic, copy) NSString <Optional> * imgUrl;
@property (nonatomic, copy) NSString <Optional> * uploadTime;
@property (nonatomic, copy) NSString <Optional> * createTime;
@property (nonatomic, copy) NSString <Optional> * loop;
@property (nonatomic, copy) NSString <Optional> * playTime;
@property (nonatomic, copy) NSString <Optional> * playlist;
@end
