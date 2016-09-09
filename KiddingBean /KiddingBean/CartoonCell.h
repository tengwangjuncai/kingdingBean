//
//  CartoonCell.h
//  KiddingBean
//
//  Created by Qianfeng on 16/3/7.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailReturndata.h"
#import "DeleteReload.h"
@interface CartoonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cartoonImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong)id<DeleteReloadDelegate>delegate;
@property (nonatomic, strong)DetailReturndata *mode;
- (void)configData:(DetailReturndata *)mode;

@end
