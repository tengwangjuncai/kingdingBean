//
//  CartoonCell.m
//  KiddingBean
//
//  Created by Qianfeng on 16/3/7.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "CartoonCell.h"
#import "UIImageView+WebCache.h"
#import "MagicalRecord.h"
#import "Cartoon+CoreDataProperties.h"
@implementation CartoonCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)cancelFavTouched:(id)sender {
    [Cartoon MR_deleteAllMatchingPredicate:[NSPredicate predicateWithFormat:@"comic_id = %@",self.mode.comic.comic_id]];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    [self.delegate reloadData];
}

- (void)configData:(DetailReturndata *)mode {
    self.mode = mode;
    if (mode.comic.cover != nil) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:mode.comic.cover] placeholderImage:[UIImage imageNamed:@"umeng_socialize_share_pic"]];
    }
    self.titleLabel.text = mode.comic.name;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
