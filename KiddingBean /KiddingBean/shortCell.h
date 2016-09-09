//
//  shortCell.h
//  KiddingBean
//
//  Created by Qianfeng on 16/3/7.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPYFirstModel.h"
#import "DeleteReload.h"
@interface shortCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (nonatomic, strong)WPYFirstModel *mode;
@property (nonatomic, strong) id<DeleteReloadDelegate> delegate;
- (void)configData:(WPYFirstModel*)mode;

@end
