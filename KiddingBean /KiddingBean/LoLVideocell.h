//
//  LoLVideocell.h
//  KiddingBean
//
//  Created by Qianfeng on 16/3/7.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"
#import "DeleteReload.h"
@interface LoLVideocell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong)VideoModel *mode;
@property (nonatomic, strong)id<DeleteReloadDelegate>delegate;
- (void)configData:(VideoModel *)mode;

@end
