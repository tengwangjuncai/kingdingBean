//
//  Cartoon+CoreDataProperties.h
//  KiddingBean
//
//  Created by Qianfeng on 16/3/6.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Cartoon.h"

NS_ASSUME_NONNULL_BEGIN

@interface Cartoon (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *comic_cover;
@property (nullable, nonatomic, retain) NSString *comic_name;
@property (nullable, nonatomic, retain) NSString *comic_author_name;
@property (nullable, nonatomic, retain) NSString *comic_click_total;
@property (nullable, nonatomic, retain) NSString *comic_id;
@property (nullable, nonatomic, retain) NSString *comic_theDescrition;

@end

NS_ASSUME_NONNULL_END
