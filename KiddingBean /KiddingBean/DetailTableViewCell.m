//
//  DetailTableViewCell.m
//  KiddingBean
//
//  Created by Qianfeng on 16/2/26.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "DetailTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "Define.h"
@implementation DetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)configData:(WPYFirstModel *)mode {
    NSString *userid4 = [mode.user.ID substringToIndex:4];
    NSString * iconUrl = [NSString stringWithFormat:KuserIcon,userid4,mode.user.ID,mode.user.icon];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:[UIImage imageNamed:@"icon"]];
    self.nameLabel.text = mode.user.login;
    self.contentLabel.text = mode.content;
    self.floorLabel.text = mode.floor;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
