//
//  LoLVideocell.m
//  KiddingBean
//
//  Created by Qianfeng on 16/3/7.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "LoLVideocell.h"
#import "Define.h"
#import "UIImageView+WebCache.h"
#import "MagicalRecord.h"
#import "LoLVideo+CoreDataProperties.h"
@implementation LoLVideocell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)cancelFavTouched:(id)sender {
    [LoLVideo MR_deleteAllMatchingPredicate:[NSPredicate predicateWithFormat:@"wid = %@",self.mode.wid]];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    [self.delegate reloadData];
}
- (void)configData:(VideoModel *)mode {
    self.mode = mode;
    if (mode.imgUrl != NULL) {
        [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:mode.imgUrl]];
        self.titleLabel.text = mode.title;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
