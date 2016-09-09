//
//  kiddingVideocell.m
//  KiddingBean
//
//  Created by Qianfeng on 16/3/7.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "kiddingVideocell.h"
#import "Define.h"
#import "UIImageView+WebCache.h"
@implementation kiddingVideocell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)cancelFavTouched:(id)sender {
    [KiddingVideo MR_deleteAllMatchingPredicate:[NSPredicate predicateWithFormat:@"mode_ID = %@",self.mode.ID]];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    [self.delegate reloadData];
}

- (void)configData:(WPYFirstModel *)mode {
    self.mode = mode;
    NSString *userid4 = [mode.user.ID substringToIndex:4];
    NSString * iconUrl = [NSString stringWithFormat:KuserIcon,userid4,mode.user.ID,mode.user.icon];
     NSLog(@"%@",iconUrl);
    NSLog(@"$$$$$$$%@",mode.pic_url);
    if (mode.user.ID != nil) {
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:[UIImage imageNamed:@"u=2455866049,3455590870&fm=21&gp=0.jpg"]];
    }else {
        self.iconImageView.image = [UIImage imageNamed:@"u=2455866049,3455590870&fm=21&gp=0.jpg"];
    }
    self.contentLabel.text = mode.content;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
