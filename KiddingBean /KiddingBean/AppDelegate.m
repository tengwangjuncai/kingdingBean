//
//  AppDelegate.m
//  KiddingBean
//
//  Created by Qianfeng on 16/2/25.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "RecordAppLoad.h"
#import "AFNetworking.h"
#import "MagicalRecord.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
@interface AppDelegate ()
@property (nonatomic)AFNetworkReachabilityStatus statue;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self network];
    [self initUM];
    //创建数据库
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"favoriteLib.sqlite"];
    //记录软件打开次数
    [RecordAppLoad recordAppLoadNum];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    RootViewController *rvc = [[RootViewController alloc] init];
    self.window.rootViewController = rvc;
    [self.window makeKeyAndVisible];
    
    return YES;
}
/**   wx55c21e9fd1858e5a
 *  
 *59f511d6aca16f6448c6a8407a56f5f7
 *  分享
 */
- (void)initUM {
    //必须先注册 um
    [UMSocialData setAppKey:@"561cb9cfe0f55ab327002433"];
    
    [UMSocialWechatHandler setWXAppId:@"wx55c21e9fd1858e5a" appSecret:@"59f511d6aca16f6448c6a8407a56f5f7" url:@"http://www.umeng.com/social"];
}
/**
 *
 *
 * 监听网络状态
 */
- (void)network {
    //判断网络状态 如果网络不通就提示一下
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (self.statue == 2 && status==1) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"逗豆提醒" message:@"由WiFi 进入 数据网" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            
            [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
        }
        if (status == 0) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"逗豆提醒" message:@"无网络" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            
            [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
        }else if (status == 1) {
            NSLog(@"移动网络");
        }else if (status == 2) {
            NSLog(@"wifi");
        }
        self.statue = status;
    }];
    //开始监听
    [manager startMonitoring];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
