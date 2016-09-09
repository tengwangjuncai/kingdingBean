//
//  LoLTextTableViewCell.m
//  KiddingBean
//
//  Created by Qianfeng on 16/2/27.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "LoLTextTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation LoLTextTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)configData:(LPModelJokeList *)mode {
    [self.lolImageView sd_setImageWithURL:[NSURL URLWithString:mode.image_url_small] placeholderImage:[UIImage imageNamed:@"umeng_socialize_share_pic"]];
    self.titleLabe.text = mode.title;
    self.summaryLabel.text = mode.summary;
    
    if ([mode.is_subject isEqualToString:@"1"]) {
        self.typeLabel.text = @"专题";
    }else {
        self.typeLabel.text = @"资讯";
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
