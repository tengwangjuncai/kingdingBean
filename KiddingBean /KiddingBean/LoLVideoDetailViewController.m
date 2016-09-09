//
//  LoLVideoDetailViewController.m
//  KiddingBean
//
//  Created by Qianfeng on 16/3/1.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "LoLVideoDetailViewController.h"
#import "LoLVideoTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "WPYNavBar.h"
#import "KrVideoPlayerController.h"
#import "LoLVideo+CoreDataProperties.h"
#import "MagicalRecord.h"
#import "ShareTool.h"
@interface LoLVideoDetailViewController ()<UIScrollViewDelegate,WPYNavBarDelegat>
@property (nonatomic, strong) WPYNavBar *btnView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *videoImageView;
@property (nonatomic, strong) UITableView * videoTableView;
@property (nonatomic)NSInteger currentPage;
@property (nonatomic, strong) KrVideoPlayerController  *videoController;
@end

@implementation LoLVideoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor blackColor];
    [self loadPlayerData];
}
- (void)viewDidDisappear:(BOOL)animated {
     [self.videoController dismiss];
    self.videoController = nil;
}
- (void)createTableView {
    self.myTableView = [[UITableView alloc] init];
    [self.view addSubview:self.myTableView];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    self.myTableView.estimatedRowHeight = 44;
    self.myTableView.showsVerticalScrollIndicator = NO;
    [self.myTableView registerNib:[UINib nibWithNibName:@"LoLVideoTableViewCell" bundle:nil] forCellReuseIdentifier:@"lolVideoCell"];
    self.myTableView.tag = 201;
    _videoTableView = [[UITableView alloc] init];
    _videoTableView.dataSource =self;
    _videoTableView.delegate =self;
    _videoTableView.tag = 202;
    _videoTableView.showsVerticalScrollIndicator = NO;
    [self createVideoImageView];
    [self createButtonView];
    [self createScrollView];
    
    
}

- (void)createVideoImageView {
   _videoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth,kScreenHeight/3)];
    _videoImageView.userInteractionEnabled = YES;
    if (_mode.imgUrl != NULL) {
        [_videoImageView sd_setImageWithURL:[NSURL URLWithString:_mode.bigImgUrl] placeholderImage:[UIImage imageNamed:@"bobo_video_back"]];
    }
    [self.view addSubview:_videoImageView];
    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    playBtn.frame = CGRectMake(0, 0, 60, 60);
    playBtn.center = _videoImageView.center;
    [playBtn setBackgroundImage:[UIImage imageNamed:@"competiton_centre_main_live_play_mark"] forState:UIControlStateNormal];
    [_videoImageView addSubview:playBtn];
    [playBtn addTarget:self action:@selector(playBtnPressed:)  forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)createButtonView {
    CGFloat videoImageViewY = CGRectGetMaxY(_videoImageView.frame);
    _btnView = [[WPYNavBar alloc] initWithFrame:CGRectMake(0, videoImageViewY, kScreenWidth/3*2, 32) titleColor:[UIColor grayColor] andSelectTitleColor:[UIColor lightGrayColor]];
    _btnView.backgroundColor = [UIColor colorWithRed:0.8 green:0.9 blue:1 alpha:1];
    _btnView.delegate = self;
    NSArray *btnNameArray = @[@"相关视频"];
    [_btnView AddNavBarArray:btnNameArray isBtnLine:NO btnLineColor:[UIColor lightGrayColor]];
    [_btnView selectTheButton:0];
    [self.view addSubview:_btnView];
    UIView *view  = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/3*2, videoImageViewY, kScreenWidth/3, 32)];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    UIButton *favBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    favBtn.frame = CGRectMake(10, 0, kScreenWidth/6-15, 32);
    [favBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [favBtn addTarget:self action:@selector(favBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    favBtn.backgroundColor = [UIColor colorWithRed:0.8 green:0.9 blue:1 alpha:1];
    UIButton *dowBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    dowBtn.frame = CGRectMake(kScreenWidth/6 +5, 0, kScreenWidth/6 -15, 32);
    [dowBtn setTitle:@"分享" forState:UIControlStateNormal];
    [dowBtn addTarget:self action:@selector(dowBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    dowBtn.backgroundColor = [UIColor colorWithRed:0.8 green:0.9 blue:1 alpha:1];
    [view addSubview:favBtn];
    [view addSubview:dowBtn];
    view.backgroundColor = [UIColor colorWithRed:0.8 green:0.9 blue:1 alpha:1];
    
}
- (void)dowBtnPressed {
    NSString *str = [NSString stringWithFormat:@"%@ %@",self.mode.title,self.playerMode.url];
    [[ShareTool shareManager] shareWithTheStr:str andImageUrl:self.mode.imgUrl];
}
- (void)favBtnPressed {
    [self insertData];
}
- (void)insertData {
    
    if ([self selectData]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"逗豆提醒" message:@"已经收藏，亲" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
        return;
    }
    LoLVideo * L = [LoLVideo MR_createEntity];
    L.bigImage_url = self.mode.bigImgUrl;
    L.imageUrl = self.mode.imgUrl;
    L.mode_url = self.mode.url;
    L.title = self.mode.title;
    L.watchCount = self.mode.watchCount;
    L.favCount = self.mode.favCount;
    L.wid = self.mode.wid;
    L.mode_downlod_url = self.mode.download_url;
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError *error) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"逗豆提醒" message:@"收藏成功" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
    }];
}

- (NSInteger)selectData {
    NSArray * LoLVideoArray = [LoLVideo MR_findByAttribute:@"wid" withValue:self.mode.wid];
    return LoLVideoArray.count;
}

- (void)createScrollView {
    CGFloat btnViewY = CGRectGetMaxY(_btnView.frame);
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, btnViewY, kScreenWidth, kScreenHeight - btnViewY - 64)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scrollView];
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    self.myTableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - btnViewY - 64);
    //self.videoTableView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight - btnViewY -44);
    [self.scrollView addSubview:self.myTableView];
    //[self.scrollView addSubview:self.videoTableView];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth,kScreenHeight - btnViewY -64);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
}
- (void)playBtnPressed:(UIButton *)sender {
    
    [self addVideoPlayerWithURL:[NSURL URLWithString:_playerMode.url]];
}

- (void)addVideoPlayerWithURL:(NSURL *)url{
    if (!self.videoController) {
        self.videoController = [[KrVideoPlayerController alloc] initWithFrame:self.videoImageView.frame];
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
            
        }];
        //        [self.videoController setWillBackOrientationPortrait:^{
        //
        //        }];
        [self.videoController setWillChangeToFullscreenMode:^{
            
            //全屏时隐藏状态栏
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
        }];
        [self.view addSubview:self.videoController.view];
    }
    self.videoController.contentURL = url;
    
}
- (void)loadPlayerData {
    HttpEngine *engine = [HttpEngine shareEngine];
    if (self.mode.download_url != NULL) {
        [engine GET:self.mode.download_url success:^(id response) {
            _playerMode = [[PlayerModel alloc] initWithDictionary:response error:nil];
           // NSLog(@"--------------###%@",response);
            
        } failure:^(NSError *error) {
          //NSLog(@"hahahahha&&&&&&&&&&&&");
        }];
    }
}
- (NSString *)urlStr {
    
        NSDate *date = [NSDate date];
        NSTimeInterval ts = [date timeIntervalSince1970];
        int tsp = ts * 1000;
        
        return [NSString stringWithFormat:kLoLrelated,tsp,self.mode.wid];
}
-(void)loadDataSource {
    if (![[AFNetworkReachabilityManager sharedManager]isReachable]) {
        [self endRefresh];
        //读取本地数据
        NSArray *arr = [CacheManager readDataWithUrl:[self urlStr]];
        // NSLog(@"缓存中读取数据");
        self.dataSource = [VideoModel arrayOfModelsFromDictionaries:arr];
      //  NSLog(@"--------%@",self.dataSource);
        //刷新界面
        [self.myTableView reloadData];
        return;
    }
    HttpEngine *engine = [HttpEngine shareEngine];
    if ([self urlStr]) {
        [engine GET:[self urlStr] success:^(id response) {
            // NSLog(@"请求成功---%@",response);
            NSArray *videos = response[@"videos"];
            
            //解析数据
            if (self.isPullDown) {
                self.dataSource = [VideoModel arrayOfModelsFromDictionaries:videos];
            }
            if (self.isLoadMore) {
                [self.dataSource addObjectsFromArray:[VideoModel arrayOfModelsFromDictionaries:videos]];
            }
            [self endRefresh];
           // NSLog(@"------%ld",self.dataSource.count);
            [self.myTableView reloadData];
        } failure:^(NSError *error) {
            
           // NSLog(@"请求失败--- %@",error);
        }];
    }
}


#pragma mark -实现代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _currentPage = scrollView.contentOffset.x/_scrollView.frame.size.width;
    [self.btnView selectTheButton:_currentPage];
}
-(void)selectChangetoViewNum:(NSInteger)num {
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * num, 0) animated:NO];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LoLVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lolVideoCell"];
    VideoModel *mode = self.dataSource[indexPath.row];
    [cell configData:mode];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LoLVideoDetailViewController * lolvdVC = [[LoLVideoDetailViewController alloc] init];
    lolvdVC.title = @"英雄时刻";
    lolvdVC.mode = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:lolvdVC animated:YES];
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
