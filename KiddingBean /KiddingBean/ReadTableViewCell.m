//
//  ReadTableViewCell.m
//  KiddingBean
//
//  Created by Qianfeng on 16/3/4.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "ReadTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "Define.h"
@implementation ReadTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)configData:(PicReturndata *)mode {
    
    [self.cartoonView sd_setImageWithURL:[NSURL URLWithString:mode.location] placeholderImage:[UIImage imageNamed:@""]];
    self.imageHight.constant =[mode.height floatValue] /([mode.width floatValue]/kScreenWidth);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
