//
//  VideoTableViewCell.h
//  KiddingBean
//
//  Created by Qianfeng on 16/2/28.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPYFirstModel.h"
#import "KrVideoPlayerController.h"
@interface VideoTableViewCell : UITableViewCell


@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel *loginLabel;
@property (nonatomic, strong)UILabel *contentLabel;
@property (nonatomic, strong)UIImageView *viedoImageView;
@property (nonatomic, strong)UILabel * shareLabel;
@property (nonatomic, strong)UIButton *playerBtn;
@property (nonatomic, strong)WPYFirstModel *mode;
@property (nonatomic, strong) KrVideoPlayerController  *videoController;
@property (nonatomic, strong)UIButton *favBtn;
@property (nonatomic, strong)UIButton *shareBtn;
- (void)configData:(WPYFirstModel *)mode andNum:(NSInteger)num;
@end
