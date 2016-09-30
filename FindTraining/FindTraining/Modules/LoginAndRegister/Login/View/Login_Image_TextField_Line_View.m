//
//  Login_Image_TextField_Line_View.m
//  FindTraining
//
//  Created by Jiang on 16/9/21.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "Login_Image_TextField_Line_View.h"

@interface Login_Image_TextField_Line_View ()
<
UITextFieldDelegate
>
@property (nonatomic, retain) UIView *view;
@property (nonatomic, retain) UITextField *textField;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *label;
@end
@implementation Login_Image_TextField_Line_View

@synthesize text = _text;
@synthesize image = _image;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.view = [[UIView alloc] init];
        
        //        self.view.layer.cornerRadius = 6;
        //        _view.clipsToBounds = YES;
        [self addSubview:self.view];
        [_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        self.alpha = 1;
        self.imageView = [[UIImageView alloc] init];
        
        
        _imageView.alpha = 1;
        [self.view addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(4);
            make.left.equalTo(self.view.mas_left).offset(4);
            make.bottom.equalTo(self.view.mas_bottom).offset(-4);
            make.width.equalTo(self.view.mas_height).offset(-8);
        }];
        
        
        
        
        self.textField = [[UITextField alloc] init];
        
        _textField.alpha = 1;
        _textField.delegate = self;
        [self.view addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_imageView.mas_right).offset(4);
            make.right.equalTo(self.view.mas_right).offset(0);
            make.bottom.equalTo(self.view.mas_bottom).offset(0);
            make.height.equalTo(self.view.mas_height);
        }];
    }
    
    self.label = [[UILabel alloc] init];
    _label.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_view.mas_left).offset(0);
        make.right.equalTo(_view.mas_right).offset(0);
        make.height.equalTo(@1);
        make.bottom.equalTo(_view.mas_bottom).offset(-1);
        
    }];
    
    
    
    return self;
}
- (void)setImage:(UIImage *)image {
    if (_image != image) {
        _image = image;
        _imageView.image = _image;
    }
}

- (UIImage *)image {
    _image = _imageView.image;
    return _image;
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
- (void)setTextFieldColor:(UIColor *)textFieldColor {
    if (_textFieldColor != textFieldColor) {
        _textFieldColor = textFieldColor;
        _textField.backgroundColor = _textFieldColor;
    }
}
- (void)setImageViewColor:(UIColor *)imageViewColor {
    
    
    if (_imageViewColor != imageViewColor) {
        _imageViewColor = imageViewColor;
        _imageView.backgroundColor = _imageViewColor;
    }
}






- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.imageView.image = _image;
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_textField resignFirstResponder];
    return YES;
}


@end
