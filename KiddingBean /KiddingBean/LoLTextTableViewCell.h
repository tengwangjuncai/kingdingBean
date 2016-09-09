//
//  LoLTextTableViewCell.h
//  KiddingBean
//
//  Created by Qianfeng on 16/2/27.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPModelJokeList.h"
@interface LoLTextTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *lolImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabe;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (nonatomic, strong) UIImageView *videoImageView;

- (void)configData:(LPModelJokeList *)mode;
@end
