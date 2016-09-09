//
//  KiddingPic+CoreDataProperties.h
//  KiddingBean
//
//  Created by Qianfeng on 16/3/6.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "KiddingPic.h"

NS_ASSUME_NONNULL_BEGIN

@interface KiddingPic (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *mode_comments_count;
@property (nullable, nonatomic, retain) NSString *mode_content;
@property (nullable, nonatomic, retain) NSString *mode_ID;
@property (nullable, nonatomic, retain) NSString *mode_image;
@property (nullable, nonatomic, retain) NSString *mode_share_count;
@property (nullable, nonatomic, retain) NSString *user_ID;
@property (nullable, nonatomic, retain) NSString *user_login;

@end

NS_ASSUME_NONNULL_END
