//
//  CartoonTableViewCell.m
//  KiddingBean
//
//  Created by Qianfeng on 16/3/3.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "CartoonTableViewCell.h"

@implementation CartoonTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)configData:(LPModelJokeChapter_List *)mode Page:(NSInteger)num {
    self.inforLabel.text = [NSString stringWithFormat:@"%@",mode.name];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
