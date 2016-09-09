//
//  MyManagerTableViewCell.h
//  KiddingBean
//
//  Created by Qianfeng on 16/3/2.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyManagerModel.h"
@interface MyManagerTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *icoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;

- (void)configData:(MyManagerModel *)mode;
@end
