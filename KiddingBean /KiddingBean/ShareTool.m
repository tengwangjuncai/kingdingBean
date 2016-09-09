//
//  ShareTool.m
//  KiddingBean
//
//  Created by Qianfeng on 16/3/8.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "ShareTool.h"

@implementation ShareTool

+ (instancetype)shareManager {
    static dispatch_once_t once = 0;
    static id _share = nil;
    dispatch_once(&once,^{
        _share = [[self alloc] init];
    });

    return _share;
}

- (void)shareWithTheStr:(NSString *)str andImageUrl:(NSString *)imageUrl {
    [UMSocialConfig hiddenNotInstallPlatforms:@[ UMShareToWechatTimeline]];
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    //如果需要分享回调，请将delegate对象设置self，并实现下面的回调方法
    [UMSocialSnsService presentSnsIconSheetView:[UIApplication sharedApplication].keyWindow.rootViewController
                                         appKey:@"561cb9cfe0f55ab327002433"
                                      shareText:str
                                     shareImage:imageUrl
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToEmail,UMShareToSms,UMShareToWechatTimeline,nil]
                                       delegate:self];

}


#pragma mark - UM 协议的方法

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}
@end
