
//
//  MeViewController.m
//  KiddingBean
//
//  Created by Qianfeng on 16/3/2.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "MeViewController.h"
#import "MyManagerModel.h"
#import "MyManagerTableViewCell.h"
#import "IntroduceViewController.h"
#import "SDImageCache.h"
#import "FavouriteViewController.h"
@interface MeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSMutableArray * dataSource;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIView * nightView;
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createImageView];
    [self loadConfigFile];
    [self createTableView];
    [self addobserverToNightView];
}

- (void)createImageView {
   _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/3)];
    _imageView.userInteractionEnabled = YES;
    [self.view addSubview:_imageView];
    _iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _iconBtn.frame = CGRectMake(0, 0,kScreenWidth/6,kScreenWidth/6);
    _iconBtn.center = _imageView.center;
    [_iconBtn setBackgroundImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
    _iconBtn.clipsToBounds = YES;
    _iconBtn.layer.cornerRadius = 10;
    [_imageView addSubview:_iconBtn];
    _nameLabel = [[UILabel alloc] init];
    
    CGFloat iconBtnY = CGRectGetMaxY(_iconBtn.frame);
    _nameLabel.frame = CGRectMake(_iconBtn.center.x - 50, iconBtnY + 20, 100, 25);
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.text = @"逗 豆";
    _nameLabel.font = [UIFont systemFontOfSize:20];
    _nameLabel.textColor = [UIColor orangeColor];
    [_imageView addSubview:_nameLabel];
    _imageView.image = [UIImage imageNamed:@"iconBackground"];
}
- (void)loadConfigFile {
   
    _dataSource = [NSMutableArray new];
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"MyManager.plist" ofType:nil];
    NSArray * contentArray = [NSArray arrayWithContentsOfFile:filePath];
    for (NSDictionary *dict in contentArray) {
        MyManagerModel *mode = [MyManagerModel new];
        mode.title = dict[@"title"];
        mode.image = dict[@"image"];
        [_dataSource addObject:mode];
    }
}
- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,kScreenHeight/3, kScreenWidth, kScreenHeight - 64-kScreenHeight/3 - 44)];
    //去除竖直方向滚动条
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.dataSource =self;
    _tableView.delegate = self;
    self.tableView.estimatedRowHeight = 44;
    [self.view addSubview:_tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyManagerTableViewCell" bundle:nil] forCellReuseIdentifier:@"managerCell"];
    _tableView.scrollEnabled = NO;
   // self.tableView.bounces = NO;
}

#pragma mark - 实现代理

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"managerCell"];
    MyManagerModel *mode = self.dataSource[indexPath.row];
    [cell configData:mode];
    if (indexPath.row == self.dataSource.count - 2) {
        UISwitch * switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(kScreenWidth - 80, 10, 30, 30)];
        [switchBtn setOn:NO];
        
        [switchBtn addTarget:self action:@selector(switchBtnTouched:) forControlEvents:UIControlEventValueChanged];
        [cell.contentView addSubview:switchBtn];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            FavouriteViewController *favVC = [[FavouriteViewController alloc] init];
            favVC.title = @"我的收藏";
            [self.navigationController pushViewController:favVC animated:YES];
        }
            break;
        case 1: {
            [self clearCache];
        }
            break;
        case 3: {
            
            [self createFlash];
            
            IntroduceViewController *introduceVC = [[IntroduceViewController alloc] init];
            introduceVC.title = @"关于软件";
            [self.navigationController pushViewController:introduceVC animated:YES];
        }
            break;
        default:
            break;
    }
}
- (void)createFlash {
    CATransition *animation = [CATransition animation];
    //1.设置类型
    animation.type = @"rippleEffect";
    //2.设置方向
    animation.subtype = @"fromLeft";
    //3动画的时间
    animation.duration = 1;
    //4设置动画的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    //5 增加到导航控制器view 的layer上
    //导航的layer 上 子视图发生的转场
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    CATransition *animation = [CATransition animation];
    [self createFlash];
}
#pragma mark - 夜间模式
- (void)switchBtnTouched:(UISwitch *)theSwitch {
    if (theSwitch.on) {
        [[NSUserDefaults standardUserDefaults] setObject:@(NO) forKey:@"isDay"];
    }else {
        [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:@"isDay"];
    }
    
}

- (void)createNightView {
    self.nightView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.nightView.backgroundColor = [UIColor blackColor];
    self.nightView.alpha = 0.5;
    self.nightView.userInteractionEnabled = NO;
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.nightView];
    self.nightView.hidden = NO;
}

- (void)addobserverToNightView {
    [[NSUserDefaults standardUserDefaults]  addObserver:self forKeyPath:@"isDay" options:NSKeyValueObservingOptionNew |NSKeyValueObservingOptionOld context:nil];
    [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:@"isDay"];
}
//观察的代理方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    NSNumber *dayNight = [[NSUserDefaults standardUserDefaults] valueForKey:@"isDay"];
    
    BOOL isDay = [dayNight boolValue];
    if (isDay) {
        if (!self.nightView) {
            [self createNightView];
            NSLog(@"ddd");
        }
        self.nightView.hidden = YES;
    }else {
        self.nightView.hidden = NO;
    }
}

#pragma mark - 清除缓存

- (void)clearCache {
    NSUInteger size = [[SDImageCache sharedImageCache]getSize];
    CGFloat sizeOfM = size * 1.0 /1024/1024;
    NSString *cacheString = [NSString stringWithFormat:@"缓存数据 %.2fM，是否清除",sizeOfM];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"逗豆提醒" message:cacheString preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //清除缓存操作 SDWebImage提供的
        [[SDImageCache sharedImageCache]clearDisk];
        [[SDImageCache sharedImageCache] clearMemory];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
