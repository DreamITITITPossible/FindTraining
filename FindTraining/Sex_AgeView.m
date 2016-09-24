//
//  Sex_AgeView.m
//  FindTraining
//
//  Created by Jiang on 16/9/24.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "Sex_AgeView.h"

@interface Sex_AgeView ()
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UIView *customView;
@end

@implementation Sex_AgeView
@synthesize age = _age;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.customView = [[UIView alloc] init];
        _customView.layer.borderWidth = 2;
        _customView.clipsToBounds = YES;
        _customView.layer.cornerRadius = 4;
        [self addSubview:_customView];
       
        self.imageView = [[UIImageView alloc] init];
      
        [_customView addSubview:_imageView];

        
        self.label = [[UILabel alloc] init];
        _label.font = kFONT_SIZE_15;
        _label.textColor = [UIColor lightGrayColor];
        [_customView addSubview:_label];
        
        
    
        
    }
    return self;
}




- (void)setSex:(NSString *)sex {
    if (_sex != sex) {
        _sex = sex;
        if ([_sex isEqualToString:@"男"]) {
            _imageView.image = [UIImage imageNamed:@"icon_sex_nan"];
            _label.textColor = [UIColor colorWithRed:0.2489 green:0.6996 blue:1.0 alpha:1.0];
            _customView.layer.borderColor = [UIColor colorWithRed:0.2489 green:0.6996 blue:1.0 alpha:1.0].CGColor;
        } else {
            _imageView.image = [UIImage imageNamed:@"icon_sex_nv"];
            _label.textColor = [UIColor colorWithRed:0.9986 green:0.3696 blue:0.6676 alpha:1.0];
            _customView.layer.borderColor = [UIColor colorWithRed:0.9986 green:0.3696 blue:0.6676 alpha:1.0].CGColor;
        }
    }
}
- (void)setAge:(NSString *)age {
    if (_age != age) {
        _age = age;
        self.label.text = [NSString stringWithFormat:@"%@岁", _age];
        NSLog(@"%@", _label.text);
    }
}
- (NSString *)age {
    _age = self.label.text;
    return _age;
}
- (void)layoutSubviews {
    [super subviews];
    if ([_sex isEqualToString:@"男"]) {
        _imageView.frame = CGRectMake(10, 4, 10, 12);
    } else {
        _imageView.frame = CGRectMake(10, 4, 8, 12);
    }
    CGFloat width = [UILabel getWidthWithTitle:_label.text font:kFONT_SIZE_15];
    _label.frame = CGRectMake(_imageView.frame.origin.x + _imageView.frame.size.width + 10, self.frame.size.height / 2 - 10, width, 20);
    
    _customView.frame = CGRectMake(_imageView.frame.origin.x - 10, 0, _label.frame.origin.x + _label.frame.size.width + 10 - _imageView.frame.origin.x + 10, 20);


}

@end
