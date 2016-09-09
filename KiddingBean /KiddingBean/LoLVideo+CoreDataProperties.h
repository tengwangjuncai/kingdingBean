//
//  LoLVideo+CoreDataProperties.h
//  KiddingBean
//
//  Created by Qianfeng on 16/3/8.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "LoLVideo.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoLVideo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *bigImage_url;
@property (nullable, nonatomic, retain) NSString *favCount;
@property (nullable, nonatomic, retain) NSString *imageUrl;
@property (nullable, nonatomic, retain) NSString *mode_downlod_url;
@property (nullable, nonatomic, retain) NSString *mode_url;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *watchCount;
@property (nullable, nonatomic, retain) NSString *wid;

@end

NS_ASSUME_NONNULL_END
