//
//  SkillCollectionViewCell.m
//  FindTraining
//
//  Created by Jiang on 16/9/22.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "SkillCollectionViewCell.h"

@interface SkillCollectionViewCell ()
@property (nonatomic, retain) UILabel *cellLabel;
//@property (nonatomic, retain) UIButton *cellButton;
@end
@implementation SkillCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.cellLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _cellLabel.textAlignment = NSTextAlignmentCenter;
    _cellLabel.textColor = [UIColor lightGrayColor];
    _cellLabel.font = kFONT_SIZE_15_BOLD;
    [self addSubview:_cellLabel];
    return self;
}

- (void)setText:(NSString *)text {
    if (_text != text) {
        _text = text;
        _cellLabel.text = text;
    }
}
- (void)setTextColor:(UIColor *)textColor {
    if (_textColor != textColor) {
        _textColor = textColor;
        _cellLabel.textColor = _textColor;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _cellLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}


@end
