//
//  ForgetPasswordViewController.m
//  FindTraining
//
//  Created by Jiang on 16/9/21.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "Register_ForgetBaseView.h"
#import "LoginViewController.h"

@interface ForgetPasswordViewController ()
<
Register_ForgetBaseViewDelegate
>
@property (nonatomic, retain) Register_ForgetBaseView *forgetView;

@end

@implementation ForgetPasswordViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    [self createView];
}
- (void)createView {
    
    self.forgetView = [[Register_ForgetBaseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    _forgetView.placeholder = @"  请 输 入 新 密 码 ";
    _forgetView.tag = 1002;
    _forgetView.delegate = self;
    _forgetView.buttonTitle = @"修 改 完 成";
    [self.view addSubview:_forgetView];
    
    
    
    
}
- (void)getVerifyCode:(NSInteger)tag {
    if (tag == 1002) {
        if ([_forgetView.cellphoneText isPhoneNumber]) {
            NSString *urlString =[baseURL stringByAppendingString:@"/wechapi/member/getVerifyCode"];
            
            // MD5加密
            NSString *summary_custom  = [key_API stringByAppendingString:_forgetView.cellphoneText];
            summary_custom = [summary_custom stringByAppendingString:[NSString stringWithFormat:@"%lld", TIMESTAMP]];
            NSString *summary = [summary_custom stringWith32BitMD5Lower];
            // Body
            NSString *bodyStr = [NSString stringWithFormat:@"cellphone=%@&timeStamp=%lld&summary=%@", _forgetView.cellphoneText, TIMESTAMP, summary];
        
            [HttpClient POST:urlString body:bodyStr bodyStyle:JYX_BodyString headerFile:nil response:JYX_JSON success:^(id result) {
                NSDictionary *dic = result;
                
                NSString *msg = [dic objectForKey:@"msg"];
                    [UIView showMessage:msg];
                    [_forgetView startTime];
                
            } failure:^(NSError *error) {
            }];
        } else {
            [UIView showMessage:@"手机号有误, 请检查你的手机号是否正确"];

        }
    }
}
- (void)nextStep:(NSInteger)tag {
    if (tag == 1002) {
            if ([_forgetView.cellphoneText isPhoneNumber]) {
                NSString *urlString = [baseURL stringByAppendingString:@"/wechapi/member/changepassword"];
                NSString *passwordMD5 = [_forgetView.password_InvitationCodeText stringWith32BitMD5Lower];
                // MD5加密
                NSString *summary_custom  = [key_API stringByAppendingString:_forgetView.cellphoneText];
                summary_custom = [summary_custom stringByAppendingString:[NSString stringWithFormat:@"%lld", TIMESTAMP]];
                NSString *summary = [summary_custom stringWith32BitMD5Lower];
                // Body
                NSString *bodyStr = [NSString stringWithFormat:@"cellphone=%@&password=%@&summary=%@&timeStamp=%lld&verifyCode=%@", _forgetView.cellphoneText, passwordMD5, summary, TIMESTAMP, _forgetView.verifyCodeText];
        
                [HttpClient POST:urlString body:bodyStr bodyStyle:JYX_BodyString headerFile:nil response:JYX_JSON success:^(id result) {
                    NSDictionary *dic = result;
                    
                    NSString *msg = [dic objectForKey:@"msg"];
                    [UIView showMessage:msg];
                    if ([msg isEqualToString:@"success"]) {
//        LoginViewController *infoVC = [[InformationViewController alloc] init];
//        VerifyCodeModel *verifyCodeModel = [[VerifyCodeModel alloc] init];
//        verifyCodeModel.cellphone = _registerView.cellphoneText;
//        verifyCodeModel.verifyCode = _registerView.verifyCodeText;
//        verifyCodeModel.summary = _summary;
//        verifyCodeModel.invCode = _registerView.password_InvitationCodeText;
//        
        
//        infoVC.verifyCodeModel = verifyCodeModel;
//        infoVC.navigationItem.title = @"完善信息";
        [self.navigationController popViewControllerAnimated:YES];
        
                    }
                } failure:^(NSError *error) {
//                    NSLog(@"%@", error);
                    }];
                } else {
                    [UIView showMessage:@"手机号错误, 请勿在发送验证码时修改您的手机号"];
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
