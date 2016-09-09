//
//  WPYFirstModel.h
//  ZZ15191060WangPengYu
//
//  Created by Qianfeng on 16/2/20.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "JSONModel.h"
#import "WPYUserModel.h"
#import "LPModelJokeImage_Size.h"
@protocol  WPYUserModel<NSObject>

@end
@protocol LPModelJokeImage_Size <NSObject>


@end
@interface WPYFirstModel : JSONModel
@property (nonatomic, copy) NSString <Optional>* content;
@property (nonatomic) NSString <Optional>* comments_count;
@property (nonatomic,copy)NSString <Optional>*floor;
@property (nonatomic) NSString <Optional>*  share_count;
@property (nonatomic, copy) NSString <Optional>* image;
@property (nonatomic,copy) NSString *ID;
@property (nonatomic, strong) WPYUserModel <Optional>*user;
@property (nonatomic, copy) NSString <Optional>*format;
@property (nonatomic, copy) NSString <Optional>*type;
@property (nonatomic, copy) NSString <Optional>*high_url;
@property (nonatomic, copy) NSString <Optional>*low_url;
@property (nonatomic, copy) NSString <Optional>*pic_url;
@property (nonatomic, strong)LPModelJokeImage_Size <Optional>* image_size;
@end
