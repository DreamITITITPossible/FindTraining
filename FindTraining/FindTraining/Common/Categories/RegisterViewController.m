//
//  RegisterViewController.m
//  FindTraining
//
//  Created by Jiang on 16/9/21.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "RegisterViewController.h"
#import "Register_ForgetBaseView.h"
#import "InformationViewController.h"
#import "VerifyCodeModel.h"

@interface RegisterViewController ()
<
Register_ForgetBaseViewDelegate
>
@property (nonatomic, retain) Register_ForgetBaseView *registerView;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self createView];
}
- (void)createView {
    
    self.registerView = [[Register_ForgetBaseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    _registerView.placeholder = @"  请 输 入 邀 请 码 ( 选 填 )";
    _registerView.tag = 1001;
    self.registerView.delegate = self;

    _registerView.buttonTitle = @"下 一 步";
    
    [self.view addSubview:_registerView];

    
    UILabel *label = [[UILabel alloc] init];
    
    label.text = @"阅读并同意找练";
    
    label.textColor = [UIColor lightGrayColor];
    
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top).offset(175);
        
        make.left.equalTo(self.view.mas_left).offset(15);
        
        make.height.equalTo(@30);
        
        make.width.equalTo(@120);
        
        
    }];
    
    UIButton *agreementButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [agreementButton setTitle:@"使用协议" forState:UIControlStateNormal];
    
    [agreementButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [agreementButton addTarget:self action:@selector(agreementAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:agreementButton];
    
    [agreementButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(label.mas_top).offset(0);
        
        make.left.equalTo(label.mas_right).offset(0);
        
        make.height.equalTo(@30);
        
        make.width.equalTo(@80);
        
        
    }];
    

}




- (void)agreementAction:(UIButton *)agreementbutton {
    
}
- (void)nextStep:(NSInteger)tag {
    if (tag == 1001) {
    if ([_registerView.cellphoneText isPhoneNumber]) {
        NSString *urlString = [baseURL stringByAppendingString:@"/wechapi/member/checkVerifyCode"];
        // MD5加密
        NSString *summary_custom  = [key_API stringByAppendingString:_registerView.cellphoneText];
        summary_custom = [summary_custom stringByAppendingString:[NSString stringWithFormat:@"%lld", TIMESTAMP]];
        NSString *summary = [summary_custom stringWith32BitMD5Lower];
        // Body
        NSString *bodyStr = [NSString stringWithFormat:@"cellphone=%@&verifyCode=%@&timeStamp=%lld&summary=%@", _registerView.cellphoneText, _registerView.verifyCodeText, TIMESTAMP, summary];
        NSLog(@"%@", bodyStr);
        
        [HttpClient POST:urlString body:bodyStr bodyStyle:JYX_BodyString headerFile:nil response:JYX_JSON success:^(id result) {
            NSDictionary *dic = result;
            NSString *msg = [dic objectForKey:@"msg"];
            [UIView showMessage:msg];
            if ([msg isEqualToString:@"success"]) {
                InformationViewController *infoVC = [[InformationViewController alloc] init];
                VerifyCodeModel *verifyCodeModel = [[VerifyCodeModel alloc] init];
                verifyCodeModel.cellphone = _registerView.cellphoneText;
                verifyCodeModel.verifyCode = _registerView.verifyCodeText;
                verifyCodeModel.summary = summary;
                verifyCodeModel.invCode = _registerView.password_InvitationCodeText;
                
                
                infoVC.verifyCodeModel = verifyCodeModel;
                infoVC.navigationItem.title = @"完善信息";
                [self.navigationController pushViewController:infoVC animated:YES];
                
            }
        } failure:^(NSError *error) {
//            NSLog(@"%@", error);
            }];
        } else {
            [UIView showMessage:@"手机号错误, 请勿在发送验证码时修改您的手机号"];

        }
        
        
    }

}






#pragma mark - 获取验证码
- (void)getVerifyCode:(NSInteger)tag{
    if (tag == 1001) {
    if ([_registerView.cellphoneText isPhoneNumber]) {
    NSString *urlString =[baseURL stringByAppendingString:@"/wechapi/member/getVerifyCode"];
    
    // MD5加密
    NSString *summary_custom  = [key_API stringByAppendingString:_registerView.cellphoneText];
    summary_custom = [summary_custom stringByAppendingString:[NSString stringWithFormat:@"%lld", TIMESTAMP]];
    NSString *summary = [summary_custom stringWith32BitMD5Lower];
    // Body
    NSString *bodyStr = [NSString stringWithFormat:@"cellphone=%@&timeStamp=%lld&summary=%@", _registerView.cellphoneText, TIMESTAMP, summary];
    
 
    
    [HttpClient POST:urlString body:bodyStr bodyStyle:JYX_BodyString headerFile:nil response:JYX_JSON success:^(id result) {
        NSDictionary *dic = result;
        
        NSString *msg = [dic objectForKey:@"msg"];
        [UIView showMessage:msg];
        if ([msg isEqualToString:@"success"]) {
            [_registerView startTime];
        }

     
    } failure:^(NSError *error) {
        
    }];
        
    } else {
        [UIView showMessage:@"手机号有误, 请检查你的手机号是否正确"];
    
    }
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
