//
//  PlayerModel.h
//  KiddingBean
//
//  Created by Qianfeng on 16/2/28.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "JSONModel.h"

@interface PlayerModel : JSONModel
@property (nonatomic, copy) NSString <Optional> * success;
@property (nonatomic, copy) NSString <Optional> * type;
@property (nonatomic, copy) NSString <Optional> * url;
@end
