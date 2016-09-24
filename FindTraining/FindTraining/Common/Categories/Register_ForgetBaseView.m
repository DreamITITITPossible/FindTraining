//
//  Register_ForgetBaseView.m
//  FindTraining
//
//  Created by Jiang on 16/9/21.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "Register_ForgetBaseView.h"
#import "ImageView_TextFieldWithBorderView.h"


@interface Register_ForgetBaseView ()
<
UITextFieldDelegate
>


@property (nonatomic, retain) UITextField *verifyCodeTextField;
@property (nonatomic, retain) UITextField *invitationCodeTextField;
@property (nonatomic, retain) ImageView_TextFieldWithBorderView *cellphoneView;
@property (nonatomic, retain) UIButton *getVerifyCodeButton;
@property (nonatomic, retain) UIButton *bottomButton;
@end

@implementation Register_ForgetBaseView
@synthesize cellphoneText = _cellphoneText;
@synthesize password_InvitationCodeText = _password_InvitationCodeText;
@synthesize verifyCodeText = _verifyCodeText;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
  
        self.cellphoneView = [[ImageView_TextFieldWithBorderView alloc] init];
        [self addSubview:_cellphoneView];
        [_cellphoneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(10);
            make.left.equalTo(self.mas_left).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
            make.height.equalTo(@40);
        }];
        _cellphoneView.image = [UIImage imageNamed:@"cellphone"];
        _cellphoneView.placeholder = @"  请 输 入 手 机 号";

        
        self.verifyCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(180, 180, 10, 10)];
        _verifyCodeTextField.layer.borderWidth = 0.5;
        _verifyCodeTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _verifyCodeTextField.layer.cornerRadius = 6;
        _verifyCodeTextField.placeholder = @"  请 输 入 验 证 码";
        _verifyCodeTextField.clipsToBounds = YES;
        _verifyCodeTextField.delegate = self;
        [self addSubview:_verifyCodeTextField];
        [_verifyCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_cellphoneView.mas_left).offset(0);
            make.top.equalTo(_cellphoneView.mas_bottom).offset(10);
            make.height.equalTo(_cellphoneView.mas_height);
            make.width.equalTo(@220);
}];

        self.getVerifyCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getVerifyCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getVerifyCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _getVerifyCodeButton.backgroundColor = [UIColor redColor];
        _getVerifyCodeButton.layer.cornerRadius = 6;
        [self addSubview:_getVerifyCodeButton];
        [_getVerifyCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_verifyCodeTextField.mas_right).offset(10);
            make.top.equalTo(_cellphoneView.mas_bottom).offset(10);
            make.height.equalTo(_cellphoneView.mas_height);
            make.right.equalTo(self.mas_right).offset(-10);
        }];

        [_getVerifyCodeButton addTarget:self action:@selector(getVerifyCodeAction:) forControlEvents:UIControlEventTouchUpInside];
        self.invitationCodeTextField = [[UITextField alloc] init];
        [self addSubview:_invitationCodeTextField];
        _invitationCodeTextField.layer.borderWidth = 0.5;
        _invitationCodeTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _invitationCodeTextField.layer.cornerRadius = 6;
        _invitationCodeTextField.clipsToBounds = YES;
        [_invitationCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_verifyCodeTextField.mas_bottom).offset(10);
            make.left.equalTo(_cellphoneView.mas_left).offset(0);
            make.right.equalTo(_cellphoneView.mas_right).offset(0);
            make.height.equalTo(_cellphoneView.mas_height).offset(0);
        }];


        
        self.bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];

        _bottomButton.backgroundColor = [UIColor redColor];


        [_bottomButton addTarget:self action:@selector(nextStepAction:) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:_bottomButton];

        [_bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
 
            make.left.equalTo(self.mas_left).offset(0);
 
            make.right.equalTo(self.mas_right).offset(0);
  
            make.top.equalTo(self.mas_bottom).offset(-50);
 
            make.height.equalTo(@50);
    

        }];
        
    }
    return self;
}
- (void)startTime {
    __block int timeout= 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.getVerifyCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.getVerifyCodeButton.userInteractionEnabled = YES;
                self.getVerifyCodeButton.backgroundColor = [UIColor redColor];

            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [self.getVerifyCodeButton setTitle:[NSString stringWithFormat:@"%@秒后重发",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                self.getVerifyCodeButton.userInteractionEnabled = NO;
                self.getVerifyCodeButton.backgroundColor = [UIColor grayColor];
            });
            timeout--;
        }

    });
    dispatch_resume(_timer);
    
}



- (void)nextStepAction:(UIButton *)button {
    [self.delegate nextStep:self.tag];
}

- (void)getVerifyCodeAction:(UIButton *)button {
    [self.delegate getVerifyCode:self.tag];
}

- (void)setPlaceholder:(NSString *)placeholder {
    if (_placeholder != placeholder) {
        _placeholder = placeholder;
        _invitationCodeTextField.placeholder = _placeholder;
    }
}
- (void)setButtonTitle:(NSString *)buttonTitle {
    if (_buttonTitle != buttonTitle) {
        _buttonTitle = buttonTitle;
        [_bottomButton setTitle:_buttonTitle forState:UIControlStateNormal];

    }
}
- (void)setCellphoneText:(NSString *)cellphoneText {
    if (_cellphoneText != cellphoneText) {
        _cellphoneText = cellphoneText;
        _cellphoneView.text = _cellphoneText;
    }
}
- (void)setVerifyCodeText:(NSString *)verifyCodeText {
    if (_verifyCodeText != verifyCodeText) {
        _verifyCodeText = verifyCodeText;
        _verifyCodeTextField.text = _verifyCodeText;
    }
}
- (void)setPassword_InvitationCodeText:(NSString *)password_InvitationCodeText {
    if (_password_InvitationCodeText != password_InvitationCodeText) {
        _password_InvitationCodeText = password_InvitationCodeText;
        _invitationCodeTextField.text = _password_InvitationCodeText;
    }
}
- (NSString *)cellphoneText {
    _cellphoneText = _cellphoneView.text;
    return _cellphoneText;
}
- (NSString *)verifyCodeText {
    _verifyCodeText = _verifyCodeTextField.text;
    return _verifyCodeText;
}
- (NSString *)password_InvitationCodeText {
    _password_InvitationCodeText = _invitationCodeTextField.text;
    return _password_InvitationCodeText;
}

@end
