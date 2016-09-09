//
//  Short_message+CoreDataProperties.h
//  KiddingBean
//
//  Created by Qianfeng on 16/3/7.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Short_message.h"

NS_ASSUME_NONNULL_BEGIN

@interface Short_message (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *imageH;
@property (nullable, nonatomic, retain) NSString *imageW;
@property (nullable, nonatomic, retain) NSString *mode_comments_count;
@property (nullable, nonatomic, retain) NSString *mode_content;
@property (nullable, nonatomic, retain) NSString *mode_ID;
@property (nullable, nonatomic, retain) NSString *mode_image;
@property (nullable, nonatomic, retain) NSString *mode_share_count;
@property (nullable, nonatomic, retain) NSString *user_ID;
@property (nullable, nonatomic, retain) NSString *user_login;
@property (nullable, nonatomic, retain) NSString *user_icon;

@end

NS_ASSUME_NONNULL_END
