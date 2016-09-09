//
//  LoLTextVideoTableViewCell.m
//  KiddingBean
//
//  Created by Qianfeng on 16/2/28.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "LoLTextVideoTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation LoLTextVideoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)configData:(LPModelJokeList *)mode {
    [self.lolImageView sd_setImageWithURL:[NSURL URLWithString:mode.image_url_small] placeholderImage:[UIImage imageNamed:@"umeng_socialize_share_pic"]];
    self.titleLabe.text = mode.title;
    self.summaryLabel.text = mode.summary;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
