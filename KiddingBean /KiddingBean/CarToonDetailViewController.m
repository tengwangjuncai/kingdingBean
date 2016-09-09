//
//  CarToonDetailViewController.m
//  KiddingBean
//
//  Created by Qianfeng on 16/3/3.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "CarToonDetailViewController.h"
#import "HttpEngine.h"
#import "DetailReturndata.h"
#import "UIImageView+WebCache.h"
#import "CartoonTableViewCell.h"
#import "ReadCartoonViewController.h"
#import "Cartoon+CoreDataProperties.h"
#import "MagicalRecord.h"
@interface CarToonDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

@property (weak, nonatomic) IBOutlet UILabel *clickedLabel;

@property (weak, nonatomic) IBOutlet UITextView *descLabel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataSource;

@property (nonatomic, strong)DetailReturndata *detailData;
@end

@implementation CarToonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib nibWithNibName:@"CartoonTableViewCell" bundle:nil] forCellReuseIdentifier:@"cartoonCell"];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self loadDataSource];
}
- (IBAction)startRead:(id)sender {
    ReadCartoonViewController *rcVc = [[ReadCartoonViewController alloc] init];
    rcVc.listSource = self.detailData.chapter_list;
    LPModelJokeChapter_List *mode = self.detailData.chapter_list[0];
    rcVc.title = mode.name;
    rcVc.currentPage = 0;
    [self.navigationController pushViewController:rcVc animated:YES];
}

- (IBAction)favoriteBtnPressed:(id)sender {
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
    Cartoon * C = [Cartoon MR_createEntity];
    C.comic_id = self.mode.comic_id;
    C.comic_cover = self.detailData.comic.cover;
    C.comic_click_total = self.detailData.comic.click_total;
    C.comic_author_name = self.detailData.comic.author.name;
    C.comic_theDescrition = self.detailData.comic.theDescription;
    C.comic_name = self.detailData.comic.name;
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError *error) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"逗豆提醒" message:@"收藏成功" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
    }];
}

- (NSInteger)selectData {
    NSArray * CartoonArray = [Cartoon MR_findByAttribute:@"comic_id" withValue:self.mode.comic_id];
    return CartoonArray.count;
}


-(void)loadDataSource {
    
    HttpEngine *engine = [HttpEngine shareEngine];
    [engine GET:[self urlStr] success:^(id response) {
        // NSLog(@"++++++++%@",response);
        NSDictionary * returnData = response[@"data"][@"returnData"];
       // NSLog(@"++++++++%@",returnData);
       self.detailData = [[DetailReturndata alloc] initWithDictionary:returnData error:nil];
        [self configData];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        //NSLog(@"-----获取数据失败");
    }];
}

- (void)configData {
    
    if (self.detailData.comic.cover) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.detailData.comic.cover] placeholderImage:[UIImage imageNamed:@"umeng_socialize_share_pic"]];
    }
    self.nameLabel.text = self.detailData.comic.name;
    if (self.detailData.comic.author.name) {
        self.authorLabel.text = [NSString stringWithFormat:@"作者：%@",self.detailData.comic.author.name];
    }
    if (self.detailData.comic.click_total) {
        self.clickedLabel.text = [NSString stringWithFormat:@"点读：%@ 次",self.detailData.comic.click_total];

    }
       self.descLabel.editable = NO;
    if (self.detailData.comic.theDescription) {
         self.descLabel.text = self.detailData.comic.theDescription;
    }else {
        self.descLabel.text = @"暂无详细介绍......";
    }
   
}
-(NSString *)urlStr {
    
    return [NSString stringWithFormat:kCartoonDetail,self.mode.comic_id];
   // NSLog(@"====%@",self.mode.comic_id);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.detailData.chapter_list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CartoonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cartoonCell"];
    
    LPModelJokeChapter_List *mode = self.detailData.chapter_list[indexPath.row];
    [cell configData:mode Page:indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ReadCartoonViewController *rcVc = [[ReadCartoonViewController alloc] init];
    rcVc.listSource = self.detailData.chapter_list;
    LPModelJokeChapter_List *mode = self.detailData.chapter_list[indexPath.row];
    rcVc.title = mode.name;
    rcVc.currentPage = indexPath.row;
    [self.navigationController pushViewController:rcVc animated:YES];
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
