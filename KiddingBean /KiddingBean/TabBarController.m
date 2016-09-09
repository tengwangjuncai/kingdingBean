//
//  TabBarController.m
//  KiddingBean
//
//  Created by Qianfeng on 16/2/25.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "TabBarController.h"
#import "TabBarModel.h"
#import "BaseNavigationController.h"
@implementation TabBarController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *tabbarModelArray = [self loadConfigFile];
    self.viewControllers = [self createViewControllers:tabbarModelArray];
}
/**
 *  加载主页面文件
 *
 *  @return 返回属性Model
 */
- (NSArray *)loadConfigFile {
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"TabBarConfig.plist" ofType:nil];
    NSArray * contentArray = [NSArray arrayWithContentsOfFile:filePath];
    for (NSDictionary *dic in contentArray) {
        TabBarModel *model = [[TabBarModel alloc] init];
        model.className = dic[@"className"];
        model.imageNormal = dic[@"imageNormal"];
        model.imageHighlight = dic[@"imageHighlight"];
        model.tilte = dic[@"title"];
        [resultArray addObject:model];
    }
    return resultArray;
}

/**
 *  创建视图控制器
 */
- (NSArray *)createViewControllers:(NSArray *)tabbarModelArray {
    NSMutableArray *rsultArray = [NSMutableArray new];
    for (TabBarModel *model in tabbarModelArray) {
        UIViewController *vc = [[NSClassFromString(model.className) alloc] init];
        vc.title = model.tilte;
        vc.tabBarItem.image = [UIImage imageNamed:model.imageNormal];
        //如果要系统蓝第一个 原色 则下面的
        vc.tabBarItem.selectedImage = [UIImage imageNamed:model.imageHighlight];
       // vc.tabBarItem.selectedImage = [[UIImage imageNamed:model.imageHighlight]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName,[UIColor grayColor],NSForegroundColorAttributeName,nil];
        [vc.tabBarItem setTitleTextAttributes:dic forState:UIControlStateSelected];
        [vc.tabBarItem setTitleTextAttributes:dic forState:UIControlStateNormal];
        NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,[UIFont systemFontOfSize:20],UITextAttributeFont,nil];
        
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        nav.navigationBar.titleTextAttributes = dic2;
        [rsultArray addObject:nav];
    }
    return rsultArray;
}

@end
