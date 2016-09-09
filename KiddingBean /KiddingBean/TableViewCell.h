//
//  TableViewCell.h
//  KiddingBean
//
//  Created by Qianfeng on 16/2/26.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPYFirstModel.h"
@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *login;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

@property (weak, nonatomic) IBOutlet UILabel *shareLabel;
@property (weak, nonatomic) WPYFirstModel *mode;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *myImageH;


- (void)configData:(WPYFirstModel *)mode;

@end
