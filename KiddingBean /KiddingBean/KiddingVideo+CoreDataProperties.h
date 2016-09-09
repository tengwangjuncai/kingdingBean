//
//  KiddingVideo+CoreDataProperties.h
//  KiddingBean
//
//  Created by Qianfeng on 16/3/8.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "KiddingVideo.h"

NS_ASSUME_NONNULL_BEGIN

@interface KiddingVideo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *mode_comments_count;
@property (nullable, nonatomic, retain) NSString *mode_high_url;
@property (nullable, nonatomic, retain) NSString *mode_low_url;
@property (nullable, nonatomic, retain) NSString *mode_pic_url;
@property (nullable, nonatomic, retain) NSString *mode_share_count;
@property (nullable, nonatomic, retain) NSString *mpde_content;
@property (nullable, nonatomic, retain) NSString *user_icon;
@property (nullable, nonatomic, retain) NSString *user_id;
@property (nullable, nonatomic, retain) NSString *user_login;
@property (nullable, nonatomic, retain) NSString *mode_ID;

@end

NS_ASSUME_NONNULL_END
