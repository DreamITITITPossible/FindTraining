//
//  ImageView_TextFieldWithBorderView.m
//  FindTraining
//
//  Created by Jiang on 16/9/21.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "ImageView_TextFieldWithBorderView.h"


@interface ImageView_TextFieldWithBorderView ()
<
UITextFieldDelegate
>
@property (nonatomic, retain) UITextField *textField;
@property (nonatomic, retain) UIImageView *leftImageView;
@end
@implementation ImageView_TextFieldWithBorderView

@synthesize text = _text;
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *backView = [[UIView alloc] init];
        [self addSubview:backView];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        backView.layer.borderWidth = 0.5;
        backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        backView.layer.cornerRadius = 6;
        backView.clipsToBounds = YES;
        
        self.leftImageView = [[UIImageView alloc] init];
        
        _leftImageView.alpha = 1;
        [backView addSubview:_leftImageView];
        [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(backView.mas_top).offset(4);
            make.left.equalTo(backView.mas_left).offset(4);
            make.bottom.equalTo(backView.mas_bottom).offset(-4);
            make.width.equalTo(backView.mas_height).offset(-8);
        }];
        
        self.textField = [[UITextField alloc] init];
        _textField.delegate = self;
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_leftImageView.mas_right).offset(4);
            make.right.equalTo(backView.mas_right).offset(0);
            make.bottom.equalTo(backView.mas_bottom).offset(0);
            make.height.equalTo(backView.mas_height);
        }];
        
    }
    return self;
}

- (void)setText:(NSString *)text {
    if (_text != text) {
        _text = text;
        _textField.text = _text;
    }
}
- (void)setPlaceholder:(NSString *)placeholder {
    if (_placeholder != placeholder) {
        _placeholder = placeholder;
        _textField.placeholder = _placeholder;
    }
}
- (NSString *)text {
    _text = _textField.text;
    return _text;
    
}
- (void)setImage:(UIImage *)image {
    if (_image != image) {
        _image = image;
        _leftImageView.image = _image;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_textField resignFirstResponder];
    return YES;
}
@end
