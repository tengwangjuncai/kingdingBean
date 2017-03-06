//
//  FavouriteViewController.m
//  KiddingBean
//
//  Created by Qianfeng on 16/3/7.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "FavouriteViewController.h"
#import "MagicalRecord.h"
#import "Short_message+CoreDataProperties.h"
#import "KiddingVideo+CoreDataProperties.h"
#import "Cartoon+CoreDataProperties.h"
#import "LoLVideo+CoreDataProperties.h"
#import "WPYFirstModel.h"
#import "VideoModel.h"
#import "DetailReturndata.h"
#import "CartoonCell.h"
#import "shortCell.h"
#import "kiddingVideocell.h"
#import "LoLVideocell.h"
#import "DetailViewController.h"
#import "KiddingVideoDetailViewController.h"
#import "CarToonDetailViewController.h"
#import "LoLVideoDetailViewController.h"
#import "LPModelJokeReturndata.h"
#import "DeleteReload.h"
@interface FavouriteViewController ()<UITableViewDataSource,UITableViewDelegate,DeleteReloadDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *shorMessageAndPicArray;
@property (nonatomic,strong)NSMutableArray *kiddingVideoArray;
@property (nonatomic,strong)NSMutableArray *lolVideoArray;
@property (nonatomic,strong)NSMutableArray * cartoonArray;
@property (nonatomic,strong)NSArray *nameArr;

@property (nonatomic,strong)NSMutableArray *statusArr;
@end

@implementation FavouriteViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nameArr = @[@"漫画",@"段子 囧图",@"搞笑视频",@"LoL视频"];
    [self initSectionsState];
    [self initArr];
    [self reloadData];
    [self createTabelView];
    
    
    
}
- (void)initArr {
    self.shorMessageAndPicArray = [NSMutableArray new];
    self.kiddingVideoArray = [NSMutableArray new];
     self.lolVideoArray = [NSMutableArray new];
     self.cartoonArray = [NSMutableArray new];
}
- (void)reloadData {
    [self getCartoonData];
    [self getKiddingVideoData];
    [self getShortMessageAndPicData];
    [self getLoLvideoData];
    [self.tableView reloadData];
}
- (void)initSectionsState {
    _statusArr = [NSMutableArray new];
    for (int i=0 ; i < self.nameArr.count; i++) {
        [_statusArr addObject:@0];
    }
}
- (void)createTabelView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    _tableView.dataSource =self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"CartoonCell" bundle:nil] forCellReuseIdentifier:@"carcell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"shortCell" bundle:nil] forCellReuseIdentifier:@"shortcell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LoLVideocell" bundle:nil] forCellReuseIdentifier:@"LoLVideocell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"kiddingVideocell" bundle:nil] forCellReuseIdentifier:@"kidcell"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    UIView *viewBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:view.frame];
    label.textAlignment = NSTextAlignmentCenter;
    if (self.shorMessageAndPicArray.count + self.kiddingVideoArray.count + self.cartoonArray.count + self.lolVideoArray.count == 0) {
        
        label.text = @"亲，你还没有添加收藏哦";
    }else {
        label.text = @"亲，你的收藏都在这里噢";
    }
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor brownColor];
    [view addSubview:label];
    view.backgroundColor =[UIColor colorWithRed:0.8 green:0.9 blue:0.85 alpha:1];    [viewBack addSubview:view];
    self.tableView.tableHeaderView = viewBack;
    
}

- (void)getShortMessageAndPicData {
    if (self.shorMessageAndPicArray.count > 0) {
        [self.shorMessageAndPicArray removeAllObjects];
    }
    NSArray * shorArr = [Short_message MR_findAll];
    for (Short_message *s in shorArr) {
        WPYFirstModel * mode = [WPYFirstModel new];
        WPYUserModel *user = [WPYUserModel new];
        LPModelJokeImage_Size *image_size = [LPModelJokeImage_Size new];
          mode.user = user;
          mode.user.icon = s.user_icon;
          mode.image_size = image_size;
          mode.user.ID = s.user_ID;
          mode.ID = s.mode_ID;
          mode.user.login = s.user_login;
          mode.image = s.mode_image;
          mode.content = s.mode_content;
          mode.comments_count = s.mode_comments_count;
         mode.share_count = s.mode_share_count;
        
        mode.image_size.s = [NSArray arrayWithObjects:s.imageW,s.imageH, nil];
        [self.shorMessageAndPicArray addObject:mode];
    }
    NSLog(@"short %ld",self.shorMessageAndPicArray.count);
}
- (void)getKiddingVideoData {
    if (self.kiddingVideoArray.count > 0) {
        [self.kiddingVideoArray removeAllObjects];
    }
    NSArray * kiddingVideoArr = [KiddingVideo MR_findAll];
    for (KiddingVideo * s in kiddingVideoArr) {
        WPYFirstModel * mode = [WPYFirstModel new];
       
        WPYUserModel *user = [WPYUserModel new];
        mode.user = user;
        mode.ID = s.mode_ID;
        mode.user.icon = s.user_icon;
        mode.user.ID = s.user_id;
        mode.user.login = s.user_login;
        mode.content = s.mpde_content;
        mode.comments_count = s.mode_comments_count;
        mode.share_count = s.mode_share_count;
        mode.pic_url = s.mode_pic_url;
        mode.low_loc = s.mode_low_url;
        mode.high_loc = s.mode_high_url;
        
        [self.kiddingVideoArray addObject:mode];
    }
    NSLog(@"kid----%ld ",self.kiddingVideoArray.count);
}
- (void)getLoLvideoData {
    if (self.lolVideoArray.count > 0) {
        [self.lolVideoArray removeAllObjects];
    }
    NSArray * lolVideoArr = [LoLVideo MR_findAll];
    for (LoLVideo * L in lolVideoArr) {
        VideoModel *mode = [VideoModel new];
         mode.bigImgUrl = L.bigImage_url;
         mode.imgUrl = L.imageUrl;
         mode.url = L.mode_url;
         mode.title = L.title;
         mode.watchCount = L.watchCount;
         mode.favCount = L.favCount;
         mode.wid = L.wid;
         mode.download_url = L.mode_downlod_url ;
        [self.lolVideoArray addObject:mode];
    }
    NSLog(@"lol----%ld",self.lolVideoArray.count);
}
- (void)getCartoonData {
    if (self.cartoonArray.count > 0) {
        [self.cartoonArray removeAllObjects];
    }
    NSArray * cartoonArr = [Cartoon MR_findAll];
    for (Cartoon *C in cartoonArr) {
        DetailReturndata * mode = [DetailReturndata new];
        LPModelJokeComic *comic = [LPModelJokeComic new];
        mode.comic = comic;
         mode.comic.comic_id = C.comic_id;
         mode.comic.cover = C.comic_cover;
         mode.comic.click_total = C.comic_click_total;
         mode.comic.author.name = C.comic_author_name;
         mode.comic.theDescription = C.comic_theDescrition;
         mode.comic.name = C.comic_name;
        [self.cartoonArray addObject:mode];
    }
    NSLog(@"cartoon---%ld",self.cartoonArray.count);
}

- (void)headViewPressed:(UIButton *)sender {
    NSInteger section = sender.tag - 100;
    //取出点击这组的状态
    BOOL state = [_statusArr[section] boolValue];
    NSNumber *currenState = state ? @0:@1;
    //替换状态数组的数据源
    [_statusArr replaceObjectAtIndex:section withObject:currenState];
    
    //刷新对应组的section
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
   // NSLog(@"dd");
}
#pragma mark - 实现协议方法 

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIButton *headerView = [UIButton buttonWithType:UIButtonTypeSystem];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 44);
    NSString *name = self.nameArr[section];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 200, 24)];
    label.text = name;
    label.font = [UIFont systemFontOfSize:17];
    [headerView addSubview:label];
    headerView.backgroundColor = [UIColor colorWithRed:0.7 green:0.9 blue:0.8 alpha:1];
    headerView.tag = section + 100;
    headerView.layer.borderColor = [UIColor grayColor].CGColor;
    [headerView addTarget:self action:@selector(headViewPressed:) forControlEvents:UIControlEventTouchUpInside];
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 86;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSNumber *state = self.statusArr[section];
    if (state.intValue == 0) {
        return 0;
    }
    if (section == 0) {
        return self.cartoonArray.count;
    }else if (section == 1) {
        return self.shorMessageAndPicArray.count;
    }else if (section == 2) {
        return self.kiddingVideoArray.count;
    }else {
        return self.lolVideoArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CartoonCell * cell = [tableView dequeueReusableCellWithIdentifier:@"carcell"];
        cell.delegate = self;
        DetailReturndata * mode = self.cartoonArray[indexPath.row];
        [cell configData:mode];
        return cell;
    }else if (indexPath.section == 1) {
        shortCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shortcell"];
        cell.delegate = self;
        WPYFirstModel *mode = self.shorMessageAndPicArray[indexPath.row];
        [cell configData:mode];
        return cell;
    }else if (indexPath.section == 2) {
        kiddingVideocell *cell = [tableView dequeueReusableCellWithIdentifier:@"kidcell"];
        cell.delegate = self;
        WPYFirstModel *mode = self.kiddingVideoArray[indexPath.row];
        [cell configData:mode];
        return cell;
    }else {
        LoLVideocell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoLVideocell"];
        cell.delegate = self;
        VideoModel *mode = self.lolVideoArray[indexPath.row];
        [cell configData:mode];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            CarToonDetailViewController * cartoonVC = [[CarToonDetailViewController alloc] init];
            DetailReturndata *mode = self.cartoonArray[indexPath.row];
            cartoonVC.mode = [LPModelJokeReturndata new];
            cartoonVC.title = mode.comic.name;
            cartoonVC.mode.comic_id = mode.comic.comic_id;            //NSLog(@"666%@",mode.comic.comic_id);
            [self.navigationController pushViewController:cartoonVC animated:YES];
            
        }
            break;
        case 1:
        {
            DetailViewController  * VC = [[DetailViewController alloc] init];
            WPYFirstModel *mode = self.shorMessageAndPicArray[indexPath.row];
            VC.mode = mode;
            VC.title = @"逗文";
            [self.navigationController pushViewController:VC animated:YES];
            
        }
            break;
        case 2:
        {
            KiddingVideoDetailViewController *kidVC = [[KiddingVideoDetailViewController alloc] init];
            WPYFirstModel *mode = self.kiddingVideoArray[indexPath.row];
            kidVC.mode = mode;
            kidVC.title = @"搞笑视频";
            [self.navigationController pushViewController:kidVC animated:YES];
        }
            break;
        case 3:
        {
          LoLVideoDetailViewController   *lolVC = [[LoLVideoDetailViewController alloc] init];
            VideoModel *mode = self.lolVideoArray[indexPath.row];
            lolVC.mode = mode;
            lolVC.title = @"英雄时刻";
            [self.navigationController pushViewController:lolVC animated:YES];
            
        }
            break;
        default:
            break;
    }
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
