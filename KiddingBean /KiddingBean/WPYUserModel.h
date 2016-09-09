//
//  WPYUserModel.h
//  ZZ15191060WangPengYu
//
//  Created by Qianfeng on 16/2/20.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "JSONModel.h"

@interface WPYUserModel : JSONModel
@property (nonatomic,copy) NSString<Optional> *login;
@property (nonatomic,copy) NSString <Optional>*icon;
@property (nonatomic,copy) NSString <Optional>*ID;
@end
