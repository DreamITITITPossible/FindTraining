//
//  LoginViewController.m
//  FindTraining
//
//  Created by Jiang on 16/9/21.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "LoginViewController.h"
#import "Login_Image_TextField_Line_View.h"
#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"

@interface LoginViewController ()
@property (nonatomic, retain) Login_Image_TextField_Line_View *userView;
@property (nonatomic, retain) Login_Image_TextField_Line_View *passwordView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createView];

    
}
- (void) createView {
    UIImageView *logoImageView = [[UIImageView alloc] init];
    logoImageView.image = [UIImage imageNamed:@"logo"];
    //    logoImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.view addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(120);
        make.height.equalTo(@80);
        make.width.equalTo(@60);
    }];
    
    self.userView = [[Login_Image_TextField_Line_View alloc] init];
    _userView.placeholder = @" 请 输 入 手 机 号";
    _userView.image = [UIImage imageNamed:@"user"];
    [self.view addSubview:_userView];
    [_userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImageView.mas_bottom).offset(40);
        make.left.equalTo(self.view.mas_left).offset(50);
        make.right.equalTo(self.view.mas_right).offset(-50);
        make.height.equalTo(@50);
    }];
    
    self.passwordView = [[Login_Image_TextField_Line_View alloc] init ];
    _passwordView.placeholder = @" 请 输 入 密 码";
    _passwordView.image = [UIImage imageNamed:@"password"];
    [self.view addSubview:_passwordView];
    [_passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userView.mas_bottom).offset(1);
        make.left.equalTo(self.view.mas_left).offset(50);
        make.right.equalTo(self.view.mas_right).offset(-50);
        make.height.equalTo(_userView.mas_height);
    }];
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor colorWithRed:255.0 / 255 green:255.0 / 255 blue:255.0 / 255 alpha:1.0] forState:UIControlStateNormal];
    loginButton.backgroundColor = [UIColor colorWithRed:255.0 / 255.0 green:0.0 / 255.0 blue:0.0 / 255.0 alpha:1.0];
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    loginButton.layer.cornerRadius = 25;
    loginButton.clipsToBounds = YES;
    [self.view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordView.mas_bottom).offset(80);
        make.left.equalTo(self.view.mas_left).offset(50);
        make.right.equalTo(self.view.mas_right).offset(-50);
        make.height.equalTo(_passwordView.mas_height);
    }];
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerFindTraining) forControlEvents:UIControlEventTouchUpInside];
    [registerButton setTitleColor:[UIColor colorWithRed:255.0 / 255 green:0.0 / 255 blue:0.0 / 255 alpha:1.0] forState:UIControlStateNormal];
    
    
    
    [self.view addSubview:registerButton];
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginButton.mas_bottom).offset(20);
        make.left.equalTo(loginButton.mas_left);
        make.right.equalTo(loginButton.mas_right);
        make.height.equalTo(loginButton.mas_height);
    }];
    UIButton *forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [forgetButton setImage:[UIImage imageNamed:@"list_arrow_right"] forState:UIControlStateNormal];
    CGSize forgetImageSize = forgetButton.imageView.frame.size;
    CGSize forgetTitleSize = forgetButton.titleLabel.frame.size;
    
    forgetButton.titleEdgeInsets = UIEdgeInsetsMake(0.0, forgetImageSize.width, 0.0, forgetImageSize.width * 2);
    forgetButton.imageEdgeInsets = UIEdgeInsetsMake(0.0, forgetTitleSize.width, 0.0, -forgetTitleSize.width * 17);
    

    
    

    forgetButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [forgetButton addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetButton];
    
    [forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordView.mas_bottom).offset(20);
        make.right.equalTo(_passwordView.mas_right);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
}

- (void)login {
    if ([_userView.text isPhoneNumber]) {
 
    NSString *urlString = [baseURL stringByAppendingString:@"/wechapi/member/login"] ;
    // MD5加密
    NSString *summary_custom = [key_API stringByAppendingString:_userView.text];
    summary_custom = [summary_custom stringByAppendingString:[NSString stringWithFormat:@"%lld", TIMESTAMP]];
    NSString *summary = [summary_custom stringWith32BitMD5Lower];
    NSString *passwordMD5 = [_passwordView.text stringWith32BitMD5Lower];
    NSString *bodyStr = [NSString stringWithFormat:@"cellphone=%@&password=%@&timeStamp=%lld&summary=%@", _userView.text, passwordMD5, TIMESTAMP, summary];
    
    [HttpClient POST:urlString body:bodyStr bodyStyle:JYX_BodyString headerFile:nil response:JYX_JSON success:^(id result) {
        [UIView showMessage:[NSString stringWithFormat:@"%@", [result objectForKey:@"msg"]]];

        
    } failure:^(NSError *error) {
    }];
    } else {
        [UIView showMessage:@"手机号码错误"];
    }
}
- (void)registerFindTraining {
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    registerVC.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:registerVC animated:YES];
    
}
- (void)forgetPassword {
    ForgetPasswordViewController *forgetVC = [[ForgetPasswordViewController alloc] init];
    forgetVC.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:forgetVC animated:YES];
    
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
