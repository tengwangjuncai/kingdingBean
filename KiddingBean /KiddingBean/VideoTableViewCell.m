//
//  VideoTableViewCell.m
//  KiddingBean
//
//  Created by Qianfeng on 16/2/28.
//  Copyright © 2016年 wangpengyu. All rights reserved.
//

#import "VideoTableViewCell.h"
#import "Define.h"
#import "UIImageView+WebCache.h"

#import "KiddingVideo+CoreDataProperties.h"
#import "MagicalRecord.h"
#import "ShareTool.h"
@interface VideoTableViewCell ()

@end
@implementation VideoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    

}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    //先调用父类的方法
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //在这里可以加自己的东西
        [self initUI];
        
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 0.2;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(closeTheVideo:)
                                                     name:@"finishedPlay"object:nil];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self initframe];
}
- (void)initUI {
   _iconImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:_iconImageView];
    _loginLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_loginLabel];
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:15];
    _contentLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_contentLabel];
    
    _viedoImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_viedoImageView];
    _viedoImageView.backgroundColor = [UIColor blackColor];
    _viedoImageView.userInteractionEnabled = YES;
    _shareLabel = [[UILabel alloc] init];
    _shareLabel.font = [UIFont systemFontOfSize:15];
    _shareLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_shareLabel];
    _playerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playerBtn setBackgroundImage:[UIImage imageNamed:@"competiton_centre_main_live_play_mark"] forState:UIControlStateNormal];
    [self.playerBtn addTarget:self action:@selector(playBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_playerBtn];
    _favBtn = [[UIButton alloc] init];
    [_favBtn setBackgroundImage:[UIImage imageNamed:@"share_btn_enshrine_img_icon_normal"] forState:UIControlStateNormal];
    [_favBtn addTarget:self action:@selector(favBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_favBtn];
    
    _shareBtn = [[UIButton alloc] init];
    [_shareBtn setBackgroundImage:[UIImage imageNamed:@"u=3504076099,646908832&fm=21&gp=0.jpg"] forState:UIControlStateNormal];
    [_shareBtn addTarget:self action:@selector(shareBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_shareBtn];
}

-(void)favBtnPressed:(UIButton *)sender {
    [self insertData];
}
-(void)shareBtnPressed:(UIButton *)sender {
    NSString *str = [NSString stringWithFormat:@"%@  %@",self.mode.content,self.mode.high_url];
    [[ShareTool shareManager] shareWithTheStr:str andImageUrl:self.mode.pic_url];
}

- (void)insertData {
    
    if ([self selectData]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"逗豆提醒" message:@"已经收藏，亲" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }]];
            
            [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
        return;
    }
    KiddingVideo * s = [KiddingVideo MR_createEntity];
    s.mode_ID = self.mode.ID;
    s.user_icon = self.mode.user.icon;
    s.user_id = self.mode.user.ID;
    s.mode_pic_url = self.mode.pic_url;
    s.user_login = self.mode.user.login;
    s.mpde_content = self.mode.content;
    s.mode_comments_count = self.mode.comments_count;
    s.mode_share_count = self.mode.share_count;
    
    s.mode_low_url = self.mode.low_url;
    s.mode_high_url =self.mode.high_url;
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError *error) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"逗豆提醒" message:@"收藏成功" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
    }];
}

- (NSInteger)selectData {
    NSArray * KiddingVideoArray = [KiddingVideo MR_findByAttribute:@"mode_ID" withValue:self.mode.ID];
    return KiddingVideoArray.count;
}

- (void)closeTheVideo:(NSNotification *)sender {
    [self.videoController dismiss];
}
- (void)playBtnPressed:(UIButton *)sender {
   
    [self addVideoPlayerWithURL:[NSURL URLWithString:_mode.low_url]];
}

- (void)addVideoPlayerWithURL:(NSURL *)url{
    if (!self.videoController) {
        self.videoController = [[KrVideoPlayerController alloc] initWithFrame:self.viedoImageView.frame];
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
        [self.contentView addSubview:self.videoController.view];
    }
    self.videoController.contentURL = url;
    
}

- (void)initframe {
    _iconImageView.frame = CGRectMake(8, 8, 35, 35);
    CGFloat iconImageViewX = CGRectGetMaxX(_iconImageView.frame);
    CGFloat iconImageViewY = CGRectGetMaxY(_iconImageView.frame);
    _loginLabel.frame = CGRectMake(iconImageViewX + 20,8 , kScreenWidth - iconImageViewX - 40, 21);
    _contentLabel.frame = CGRectMake(8, iconImageViewY + 8, kScreenWidth - 16, 21);
    CGFloat contentLabelY = CGRectGetMaxY(_contentLabel.frame);
    _viedoImageView.frame = CGRectMake(8, contentLabelY+8, kScreenWidth - 16, kScreenWidth);
    
    CGFloat videoImageViewY = CGRectGetMaxY(_viedoImageView.frame);
    _shareLabel.frame = CGRectMake(8, videoImageViewY + 10, kScreenWidth - 16, 21);
    _shareBtn.frame = CGRectMake(kScreenWidth - 32, videoImageViewY + 8, 25, 25);
    _favBtn.frame = CGRectMake(kScreenWidth - 65, videoImageViewY + 8, 25, 25);
    _playerBtn.frame = CGRectMake(0, 0, kScreenWidth/6, kScreenWidth/6);
    _playerBtn.center = _viedoImageView.center;
    
    
}


- (void)configData:(WPYFirstModel *)mode andNum:(NSInteger)num {
    self.mode = mode;
    NSString *userid4 = [mode.user.ID substringToIndex:4];
    NSString * iconUrl = [NSString stringWithFormat:KuserIcon,userid4,mode.user.ID,mode.user.icon];
    if (mode.user.ID) {
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:[UIImage imageNamed:@"icon"]];
    }else {
        self.iconImageView.image = [UIImage imageNamed:@"icon"];
    }
    
    
    self.viedoImageView.contentMode = UIViewContentModeScaleToFill;

    //NSLog(@"---%@",mode.pic_url);
    if(mode.pic_url != nil){
        [self.viedoImageView sd_setImageWithURL:[NSURL URLWithString:mode.pic_url] placeholderImage:[UIImage imageNamed:@"bobo_video_back"]];
    }
    if (mode.user.login != NULL) {
        self.loginLabel.text = mode.user.login;
    }else {
        self.loginLabel.text = @"~未名~";
    }
    self.contentLabel.text = mode.content;
    
    self.shareLabel.text = [NSString stringWithFormat:@"评论：%@  分享：%@",mode.comments_count,mode.share_count];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
