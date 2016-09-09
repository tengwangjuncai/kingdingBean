//
//  MyManagerTableViewCell.m
//  KiddingBean
//
//  Created by Qianfeng on 16/3/2.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "MyManagerTableViewCell.h"

@implementation MyManagerTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)configData:(MyManagerModel *)mode {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.icoImageView.image = [UIImage imageNamed:mode.image];
    self.nameLable.text = mode.title;
    _icoImageView.clipsToBounds = YES;
    _icoImageView.layer.cornerRadius = 20;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
