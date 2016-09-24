//
//  SkillCollectionReusableView.m
//  FindTraining
//
//  Created by Jiang on 16/9/22.
//  Copyright © 2016年 Yuxiao Jiang. All rights reserved.
//

#import "SkillCollectionReusableView.h"
@interface SkillCollectionReusableView ()

@property (nonatomic, retain) UILabel *Label;


@end
@implementation SkillCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.Label = [[UILabel alloc] initWithFrame:CGRectZero];
    _Label.textAlignment = NSTextAlignmentLeft;
    _Label.textColor = [UIColor colorWithRed:1.000 green:0.487 blue:0.472 alpha:1.000];
    [self addSubview:_Label];
    return self;
}

- (void)setText:(NSString *)text {
    if (_text != text) {
        _text = text;
        _Label.text = text;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _Label.frame = CGRectMake(15, 0, self.frame.size.width, self.frame.size.height);
}
@end
