//
//  TableViewCell.m
//  KiddingBean
//
//  Created by Qianfeng on 16/2/26.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "TableViewCell.h"
#import "Define.h"
#import "UIImageView+WebCache.h"
#import "Short_message+CoreDataProperties.h"
#import "MagicalRecord.h"
#import "ShareTool.h"
@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)configData:(WPYFirstModel *)mode {
    self.mode = mode;
    NSString *userid4 = [mode.user.ID substringToIndex:4];
    NSString * iconUrl = [NSString stringWithFormat:KuserIcon,userid4,mode.user.ID,mode.user.icon];
    if (mode.user.ID != NULL) {
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:[UIImage imageNamed:@"icon"]];
    }else {
        self.iconImageView.image = [UIImage imageNamed:@"icon"];
    }
    
    
    self.myImageView.contentMode = UIViewContentModeScaleToFill;
    if (mode.image != NULL && ![mode.image isEqualToString:@""]) {
        NSString *id5 = [mode.ID substringToIndex:5];
        NSString *imageUrl = [NSString stringWithFormat:kpic,id5,mode.ID,mode.image];
        [self.myImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"usercenter_hd_cover_1"]];
        CGFloat  H = [mode.image_size.s[1] floatValue] ;
        CGFloat  W = [mode.image_size.s[0] floatValue];
        self.myImageH.constant = H / (W /(kScreenWidth -16));
        
    }else {
        self.myImageH.constant = 0;
    }
    if(mode.pic_url){
        [self.myImageView sd_setImageWithURL:[NSURL URLWithString:mode.pic_url] placeholderImage:[UIImage imageNamed:@"usercenter_hd_cover_1"]];
    }
    if (mode.user.login != NULL) {
        self.login.text = mode.user.login;
    }else {
        self.login.text = @"~未名~";
    }
    self.content.text = mode.content;
    
    self.shareLabel.text = [NSString stringWithFormat:@"评论：%@  分享：%@",mode.comments_count,mode.share_count];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
- (IBAction)favBtnPressed:(id)sender {
    [self insertData];
}
- (IBAction)shareBtnPressed:(id)sender {
    if (self.mode.image != NULL) {
        NSString *id5 = [self.mode.ID substringToIndex:5];
        NSString *imageUrl = [NSString stringWithFormat:kpic,id5,self.mode.ID,self.mode.image];
        [[ShareTool shareManager] shareWithTheStr:self.mode.content andImageUrl:imageUrl];
    }else {
        [[ShareTool shareManager] shareWithTheStr:self.mode.content andImageUrl:nil];
    }
    
}


- (void)insertData {
    
    if ([self selectData]) {
        
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"逗豆提醒" message:@"已经收藏，亲" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }]];
            
            [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
        return;
    }
    Short_message * s = [Short_message MR_createEntity];
    s.user_ID = self.mode.user.ID;
    s.mode_ID = self.mode.ID;
    s.user_login = self.mode.user.login;
    s.mode_image = self.mode.image;
    s.mode_content = self.mode.content;
    s.mode_comments_count = self.mode.comments_count;
    s.mode_share_count = self.mode.share_count;
    s.user_icon = self.mode.user.icon;
    s.imageW = [NSString stringWithFormat:@"%@",self.mode.image_size.s[0]];
     s.imageH = [NSString stringWithFormat:@"%@",self.mode.image_size.s[1]];
    NSLog(@"%@",NSHomeDirectory());
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError *error) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"逗豆提醒" message:@"收藏成功" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           
        }]];
        
        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
    }];
}

- (NSInteger)selectData {
    NSArray * shortMessage = [Short_message MR_findByAttribute:@"mode_ID" withValue:self.mode.ID];
    return shortMessage.count;
}
@end
