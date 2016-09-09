//
//  kiddingVideocell.h
//  KiddingBean
//
//  Created by Qianfeng on 16/3/7.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPYFirstModel.h"
#import "MagicalRecord.h"
#import "KiddingVideo+CoreDataProperties.h"
#import "DeleteReload.h"
@interface kiddingVideocell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (nonatomic,strong)id<DeleteReloadDelegate>delegate;
@property (nonatomic, strong)WPYFirstModel *mode;
- (void)configData:(WPYFirstModel *)mode;

@end
