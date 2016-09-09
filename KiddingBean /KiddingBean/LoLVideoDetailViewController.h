//
//  LoLVideoDetailViewController.h
//  KiddingBean
//
//  Created by Qianfeng on 16/3/1.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "BaseTableViewController.h"
#import "VideoModel.h"
#import "PlayerModel.h"
@interface LoLVideoDetailViewController : BaseTableViewController
@property (nonatomic, strong)VideoModel *mode;
@property (nonatomic, strong)PlayerModel *playerMode;
@property (nonatomic, strong)NSMutableArray *playerData;
@end
