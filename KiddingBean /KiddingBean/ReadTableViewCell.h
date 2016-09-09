//
//  ReadTableViewCell.h
//  KiddingBean
//
//  Created by Qianfeng on 16/3/4.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PicReturndata.h"
@interface ReadTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cartoonView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHight;

- (void)configData:(PicReturndata *)mode;
@end
