//
//  LoginBtnAnimationVC.m
//  WPYAnimation
//
//  Created by 又一车－UI on 16/9/2.
//  Copyright © 2016年 wpy. All rights reserved.
//

#import "LoginBtnAnimationVC.h"
#import "WPYLoginButton.h"
#import "TabBarController.h"
#import "AppDelegate.h"
@interface LoginBtnAnimationVC ()

@property (nonatomic, strong)UISwitch *successSwith;
@property (nonatomic,strong)UIImageView *icon;
@property (nonatomic,strong)UITextField *userText;
@property (nonatomic,strong)UITextField *passwordText;
@end

@implementation LoginBtnAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUp];
}

- (void)setUp{

    self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.center.x - 50,100, 100, 100)];
    self.icon.image = [UIImage imageNamed:@"icon"];
    self.icon.layer.cornerRadius = 15;
    self.icon.clipsToBounds = YES;
    [self.view addSubview:self.icon];

    [self createUserTextField];
    [self createPassWordTextField];
    WPYLoginButton * loginBtn = [[WPYLoginButton alloc] initWithFrame:CGRectMake(30, self.view.center.y + 40, self.view.frame.size.width - 60, 44)];
    [self.view addSubview:loginBtn];
    [loginBtn setBackgroundColor:[UIColor orangeColor]];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    
//    self.successSwith = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 40,40)];
//    self.successSwith.center = CGPointMake(self.view.center.x, CGRectGetMaxY(loginBtn.frame) + 30);
//    self.successSwith.on = YES;
//    [self.view addSubview:self.successSwith];
    
}
- (UILabel *)createLabel {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:label];
    return label;
}
- (void)createUserTextField {
    UILabel *label = [self createLabel];
    label.frame = CGRectMake(50, 240, 80, 30);
    label.text = @"用户名:";
    label.tag = 9;
    UITextField * tf=[[UITextField alloc] initWithFrame:CGRectMake(130, 240, 200, 35)];
    self.userText = tf;
    tf.borderStyle = UITextBorderStyleNone;
    tf.layer.borderColor = [UIColor blackColor].CGColor;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.font = [UIFont systemFontOfSize:18];
    tf.placeholder = @"请输入用户名";
    tf.tag =10;
    tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:tf];
}
- (void)createPassWordTextField {
    UILabel *label = [self createLabel];
    label.frame = CGRectMake(50, 290, 80, 30);
    label.text = @"密 码:";
    label.tag = 11;
    UITextField * tf=[[UITextField alloc] initWithFrame:CGRectMake(130, 290, 200, 35)];
    self.passwordText = tf;
    tf.borderStyle = UITextBorderStyleNone;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.font = [UIFont systemFontOfSize:18];
    tf.placeholder = @"请输入密码";
    tf.secureTextEntry = YES;
    tf.tag = 12;
    tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:tf];
}
- (void)login:(WPYLoginButton *)btn {
    
    typeof(self) __weak weak = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%@----%@",weak.userText.text,weak.passwordText.text);
        if ([weak.userText.text isEqualToString:@"wpy"] && [weak.passwordText.text isEqualToString:@"123"]) {
            
        
            [btn LoginSucceedCompletion:^{
                
                [weak goNewView];
            }];
        }else {
            
            [btn LoginFailedCompletion:^{
                
            }];
        }
    });
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)goNewView {
    TabBarController * tabBarVC = [[TabBarController alloc]init];
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    app.window.rootViewController = tabBarVC;
    
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
