//
//  InformationViewController.m
//  FindTraining
//
//  Created by Jiang on 16/9/21.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "InformationViewController.h"
#import "VerifyCodeModel.h"
#import "ImageView_TextFieldWithBorderView.h"
#import "SkillViewController.h"
#import "Register_InformationModel.h"

@interface InformationViewController ()
@property (nonatomic, retain) ImageView_TextFieldWithBorderView *nickNameView;
@property (nonatomic, retain) ImageView_TextFieldWithBorderView *ageView;
@property (nonatomic, retain) ImageView_TextFieldWithBorderView *passwordView;
@property (nonatomic, retain) UIButton *maleButton;
@property (nonatomic, retain) UIButton *femaleButton;
@property (nonatomic, retain) NSString *timeStamp;
@property (nonatomic, retain) NSString *sex;

@end

@implementation InformationViewController
- (void)viewDidLoad {
    self.nickNameView = [[ImageView_TextFieldWithBorderView alloc] init];
    
    [self.view addSubview:_nickNameView];
    [_nickNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(10);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.equalTo(@40);
    }];
    _nickNameView.image = [UIImage imageNamed:@"user_black"];
    _nickNameView.placeholder = @"  请 输 入 昵 称 ( 限 10 字 符 )";
    
    
    self.ageView = [[ImageView_TextFieldWithBorderView alloc] init];
    [self.view addSubview:_ageView];
    [_ageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nickNameView.mas_bottom).offset(10);
        make.left.equalTo(_nickNameView.mas_left).offset(0);
        make.right.equalTo(_nickNameView.mas_right).offset(0);
        make.height.equalTo(_nickNameView.mas_height);
    }];
    _ageView.image = [UIImage imageNamed:@"age"];
    _ageView.placeholder = @"  请 输 入 年 龄";
    
    self.passwordView = [[ImageView_TextFieldWithBorderView alloc] init];
    
    [self.view addSubview:_passwordView];
    [_passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_ageView.mas_bottom).offset(10);
        make.left.equalTo(_ageView.mas_left).offset(0);
        make.right.equalTo(_ageView.mas_right).offset(0);
        make.height.equalTo(_ageView.mas_height);
    }];
    _passwordView.image = [UIImage imageNamed:@"password_black"];
    _passwordView.placeholder = @"  请 输 入 密 码";
    UIButton *nextStepButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextStepButton.backgroundColor = [UIColor redColor];
    [nextStepButton setTitle:@"下 一 步" forState:UIControlStateNormal];
    [nextStepButton addTarget:self action:@selector(nextStepAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextStepButton];
    [nextStepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.top.equalTo(self.view.mas_bottom).offset(-50);
        make.height.equalTo(@50);
    }];
    
    UILabel *sexLabel = [[UILabel alloc] init];
    sexLabel.text = @"性别";
    [self.view addSubview:sexLabel];
    [sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_passwordView.mas_left).offset(5);
        make.width.equalTo(@40);
        make.top.equalTo(_passwordView.mas_bottom).offset(20);
        make.height.equalTo(@20);
        
    }];
    self.maleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"me_sex_nan"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_maleButton setImage:image forState:UIControlStateNormal];
    
    [_maleButton setTitle:@"男" forState:UIControlStateNormal];
    [_maleButton setTitleColor:[UIColor colorWithRed:0.0 green:0.502 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    _maleButton.titleLabel.font = [UIFont systemFontOfSize:20];
    
    _maleButton.backgroundColor = [UIColor clearColor];
    _maleButton.layer.borderWidth = 1;
    _maleButton.layer.borderColor = [UIColor colorWithRed:0.0 green:0.502 blue:1.0 alpha:1.0].CGColor;
    [_maleButton setTitle:@"男" forState:UIControlStateSelected];
   
    [_maleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_maleButton addTarget:self action:@selector(getSexValue:) forControlEvents:UIControlEventTouchUpInside];
    _maleButton.layer.cornerRadius = 10;
    [self.view addSubview:_maleButton];
    [_maleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sexLabel.mas_right).offset(10);
        make.width.equalTo(@80);
        make.top.equalTo(_passwordView.mas_bottom).offset(10);
        make.height.equalTo(@40);
    }];
    CGSize imageSize = _maleButton.imageView.frame.size;
    _maleButton.titleEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, - imageSize.width);
    
    CGSize titleSize = _maleButton.titleLabel.frame.size;
    _maleButton.imageEdgeInsets = UIEdgeInsetsMake(0.0, - titleSize.width, 0.0, 0.0);
   
    
    
    
    self.femaleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *femaleImage = [UIImage imageNamed:@"me_sex_nv"];
    femaleImage = [femaleImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_femaleButton setImage:femaleImage forState:UIControlStateNormal];
    
    [_femaleButton setTitle:@"女" forState:UIControlStateNormal];
    [_femaleButton setTitleColor:[UIColor colorWithRed:1.0 green:0.4353 blue:0.8118 alpha:1.0] forState:UIControlStateNormal];
    [_femaleButton setTitle:@"女" forState:UIControlStateSelected];
    [_femaleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    
    _femaleButton.titleLabel.font = [UIFont systemFontOfSize:20];
    _femaleButton.backgroundColor = [UIColor clearColor];
    _femaleButton.layer.borderWidth = 1;
    _femaleButton.layer.borderColor = [UIColor colorWithRed:1.0 green:0.4353 blue:0.8118 alpha:1.0].CGColor;
    _femaleButton.layer.cornerRadius = 10;
    [_femaleButton addTarget:self action:@selector(getSexValue:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_femaleButton];
    [_femaleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_maleButton.mas_right).offset(10);
        make.width.equalTo(@80);
        make.top.equalTo(_passwordView.mas_bottom).offset(10);
        make.height.equalTo(@40);
    }];
    CGSize femaleImageSize = _femaleButton.imageView.frame.size;
    _femaleButton.titleEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, - femaleImageSize.width);
    
    CGSize femaleTitleSize = _femaleButton.titleLabel.frame.size;
    _femaleButton.imageEdgeInsets = UIEdgeInsetsMake(0.0, - femaleTitleSize.width, 0.0, 0.0);

    
    
}

- (void)getSexValue:(UIButton *)button {
    if ([button isEqual:_maleButton]) {
        button.selected = !button.selected;
        if (button.selected) {
            _maleButton.backgroundColor = [UIColor colorWithRed:0.0 green:0.502 blue:1.0 alpha:1.0];
            [_maleButton setTitle:@"男" forState:UIControlStateHighlighted];
            [_maleButton setTitleColor:[UIColor colorWithRed:0.0 green:0.502 blue:1.0 alpha:1.0] forState: UIControlStateHighlighted];
            if (_femaleButton.selected) {
                _femaleButton.selected = !_femaleButton.selected;
                _femaleButton.backgroundColor = [UIColor whiteColor];
           
//                _femaleButton.imageView.backgroundColor = [UIColor whiteColor];
            }
            _sex = @"男";
        } else {
            _maleButton.backgroundColor = [UIColor whiteColor];
            _sex = @"";
        }
    } else {
        button.selected = !button.selected;
        if (button.selected) {
            _femaleButton.backgroundColor = [UIColor colorWithRed:1.0 green:0.4353 blue:0.8118 alpha:1.0];
            [_femaleButton setTitle:@"女" forState:UIControlStateHighlighted];
            [_femaleButton setTitleColor:[UIColor whiteColor] forState: UIControlStateHighlighted];
            if (_maleButton.selected) {
                _maleButton.selected = !_maleButton.selected;
                _maleButton.backgroundColor = [UIColor whiteColor];
                
                
            }
            
            _sex = @"女";
        } else {
            _femaleButton.backgroundColor = [UIColor whiteColor];
            [_femaleButton setTitle:@"女" forState:UIControlStateHighlighted];
            [_femaleButton setTitleColor:[UIColor colorWithRed:1.0 green:0.4353 blue:0.8118 alpha:1.0] forState: UIControlStateHighlighted];
            _sex = @"";
        }
        
    }
//    NSLog(@"%@", _sex);
}





- (void)nextStepAction:(UIButton *)nextStepButton {
    
    if (![NSString isEmpty:_nickNameView.text trim:NO]) {
        if (![NSString isEmpty:_ageView.text trim:NO]) {
            if (![NSString isEmpty:_passwordView.text trim:NO]) {
                if (![NSString isEmpty:_sex trim:NO]) {
                    SkillViewController *skillVC = [[SkillViewController alloc] init];
                    Register_InformationModel *reg_InfoModel = [[Register_InformationModel alloc] init];
                    reg_InfoModel.cellphone = _verifyCodeModel.cellphone;
                    reg_InfoModel.password = _passwordView.text;
                    reg_InfoModel.invCode = _verifyCodeModel.invCode;
                    reg_InfoModel.verifyCode = _verifyCodeModel.verifyCode;
                    reg_InfoModel.deviceId = @"BB82F230-9C0B-4175-BA70-ACD6CA6EB5ED";
                    reg_InfoModel.sex = _sex;
                    reg_InfoModel.age = _ageView.text;
                    reg_InfoModel.nickName = _nickNameView.text;
                    skillVC.reg_InfoModel = reg_InfoModel;
                    
                    [self.navigationController pushViewController:skillVC animated:YES];
                } else {
                    [UIView showMessage:@"请选择性别"];
                }
            } else {
                [UIView showMessage:@"密码不能为空"];
            }
        } else {
             [UIView showMessage:@"年龄不能为空"];
        }
    } else {
         [UIView showMessage:@"昵称不能为空"];
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
