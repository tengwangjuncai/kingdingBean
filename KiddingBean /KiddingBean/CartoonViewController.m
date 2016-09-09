
//  CartoonViewController.m
//  KiddingBean
//
//  Created by Qianfeng on 16/2/25.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "CartoonViewController.h"
#import "DBSphereView.h"
#import "HttpEngine.h"
#import "AFNetworking.h"
#import "CacheManager.h"
#import "LPModelJokeReturndata.h"
#import "UIButton+WebCache.h"
#import "CarToonDetailViewController.h"
@interface CartoonViewController()

@property (nonatomic, retain) DBSphereView *sphereView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *searchDataSource;
@property (nonatomic)int  count;

@end

@implementation CartoonViewController
@synthesize sphereView;

- (void)viewDidLoad {
    [super viewDidLoad];
    _count = 1;
    [self createSphereView];
    [self loadDataSource];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)viewWillAppear:(BOOL)animated {
     [sphereView timerStart];
}
- (void)loadDataSource {
        if (![[AFNetworkReachabilityManager sharedManager]isReachable]) {
            //读取本地数据
            NSArray *arr = [CacheManager readDataWithUrl:[self urlStr]];
            // NSLog(@"缓存中读取数据");
            self.dataSource = [LPModelJokeReturndata arrayOfModelsFromDictionaries:arr];
            [self configBtnData];
            //刷新界面
            return;
        }
        HttpEngine *engine = [HttpEngine shareEngine];
        if ([self urlStr]) {
            [engine GET:[self urlStr] success:^(id response) {
               
                NSArray *returnData = response[@"data"][@"returnData"];
               
                [CacheManager saveData:returnData withUrl:[self urlStr]];
                //解析数据
                    self.dataSource = [LPModelJokeReturndata arrayOfModelsFromDictionaries:returnData];
                
                
                [self configBtnData];
            } failure:^(NSError *error) {
                
                //NSLog(@"请求失败--- %@",error);
            }];
        }

}

- (NSString *)urlStr {

    
    return [NSString stringWithFormat:kCartoon,_count];
    
}
- (void)configBtnData {
    
    for (int i = 0; i < self.dataSource.count; i++) {
        UIButton * btn = (UIButton *) [self.view viewWithTag:i + 100];
        LPModelJokeReturndata * model = self.dataSource[i];
        [btn setTitle:[NSString stringWithFormat:@"%@",model.name] forState:UIControlStateNormal];
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.cover] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"umeng_socialize_share_pic"]];
        //NSLog(@" **********%@",model.cover);
    }
}
- (void)createSphereView {
    sphereView = [[DBSphereView alloc] initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height - 64 - 44)];
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth, sphereView.frame.size.height)];
    
    imageView.backgroundColor = [UIColor colorWithRed:0.9 green:0.98 blue:0.9 alpha:1];
    
    UIButton *changeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    changeBtn.frame = CGRectMake((kScreenWidth - 120)/2, sphereView.frame.size.height - 60, 120, 30);
    [changeBtn setTitle:@"换一批" forState:UIControlStateNormal];
    changeBtn.titleLabel.textColor = [UIColor blueColor];
    changeBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    changeBtn.clipsToBounds = YES;
    changeBtn.layer.cornerRadius = 10;
    changeBtn.layer.borderColor = [UIColor cyanColor].CGColor;
    changeBtn.layer.borderWidth = 2.;
    //changeBtn.backgroundColor = [UIColor redColor];
    [changeBtn addTarget:self action:@selector(changeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [sphereView addSubview:imageView];
    [sphereView addSubview:changeBtn];
    
    for (NSInteger i = 0; i < 20; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.tag = 100 + i;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:18.];
        btn.frame = CGRectMake(0, 0, 100, 150);
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [array addObject:btn];
        
        [sphereView addSubview:btn];
    }
    [sphereView setCloudTags:array];
    sphereView.backgroundColor = [UIColor whiteColor];
    sphereView.alpha = 1;
    self.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:sphereView];

}

- (void)changeButtonPressed {
    if (self.count < 100) {
        self.count ++;
    }else {
        self.count =1;
    }
    
    [self loadDataSource];
}
- (void)buttonPressed:(UIButton *)btn
{
    [sphereView timerStop];
    
    [UIView animateWithDuration:0.2 animations:^{
        btn.transform = CGAffineTransformMakeScale(2., 2.);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            btn.transform = CGAffineTransformMakeScale(1., 1.);
        } completion:^(BOOL finished) {
            CarToonDetailViewController * cartoonDVC  = [[CarToonDetailViewController alloc] init];
            LPModelJokeReturndata *mode = self.dataSource[btn.tag - 100];
            cartoonDVC.title = mode.name;
            cartoonDVC.mode = mode;
            [self.navigationController pushViewController:cartoonDVC animated:YES];
           
        }];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
