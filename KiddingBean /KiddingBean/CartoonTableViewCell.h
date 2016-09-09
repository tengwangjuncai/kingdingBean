//
//  CartoonTableViewCell.h
//  KiddingBean
//
//  Created by Qianfeng on 16/3/3.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPModelJokeChapter_List.h"
@interface CartoonTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *inforLabel;

- (void)configData:(LPModelJokeChapter_List *)mode Page:(NSInteger)num;
@end
