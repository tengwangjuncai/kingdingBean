//
//  LoLTextVideoTableViewCell.h
//  KiddingBean
//
//  Created by Qianfeng on 16/2/28.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPModelJokeList.h"
@interface LoLTextVideoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *lolImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabe;

@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
- (void)configData:(LPModelJokeList *)mode;
@end
