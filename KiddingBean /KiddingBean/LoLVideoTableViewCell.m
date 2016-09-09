//
//  LoLVideoTableViewCell.m
//  KiddingBean
//
//  Created by Qianfeng on 16/2/28.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "LoLVideoTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation LoLVideoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)configData:(VideoModel *)mode {
    if (mode.imgUrl != NULL) {
        [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:mode.imgUrl]];
        self.titleLabel.text = mode.title;
        self.inforLabel.text = [NSString stringWithFormat:@"播放：%@  收藏：%@",mode.watchCount,mode.favCount];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
